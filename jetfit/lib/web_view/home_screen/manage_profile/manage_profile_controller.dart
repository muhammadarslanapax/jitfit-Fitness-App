import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/models/instructor_mdel.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ManageProfileController extends GetxController {
  static ManageProfileController get my => Get.find();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController useremailcontroller = TextEditingController();
  String? imageURL;
  XFile? profileImage;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Uint8List? imagebytes;
  bool imageloading = false;
  void pickImage() async {
    imageloading = true;
    update();
    profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      imagebytes = await profileImage!.readAsBytes();
      updateprofilepicture();
    } else {
      imageloading = false;
      update();
    }
  }

  bool? videoloading;
  Uint8List? videobytes;
  XFile? profilevideo;
  VideoModel? model;

  void pickvideo() async {
    videoloading = true;
    update();
    profilevideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (profilevideo != null) {
      videobytes = await profilevideo!.readAsBytes();
      uploadVideo(videobytes!);
    } else {
      videoloading = false;
      update();
    }
  }

  void uploadVideo(
    Uint8List unitlist,
  ) async {
    Reference storageRef = storage.ref().child('introvideo/1');
    TaskSnapshot uploadTask = await storageRef.putData(unitlist);

    await uploadTask.ref.getDownloadURL().then((value) {
      firebaseFirestore
          .collection("introvideo")
          .doc('1')
          .set(VideoModel(videoID: "1", videoURL: value).toMap());
    });

    getvideofromDB();
  }

  void deletevideo(context) async {
    getvideofromDB();
    videoloading = true;
    update();
    if (profilevideo == null && model!.videoURL == null) {
      showtoast("Already deleted");
      Navigator.pop(context);
      videoloading = false;
      update();
    } else {
      profilevideo = null;
      update();
      Reference refrence = FirebaseStorage.instance.ref().child("introvideo/1");
      await refrence.delete();

      await FirebaseFirestore.instance
          .collection('introvideo')
          .doc('1')
          .delete();

      getvideofromDB();
      showtoast("Deleted Succesfully");
      videoloading = false;
      Navigator.pop(context);
      update();
    }
  }

  void getvideofromDB() {
    firebaseFirestore.collection("introvideo").doc('1').get().then((value) {
      if (value.data() != null) {
        model = VideoModel.fromMap(value.data()!);
      }
      videoloading = false;
      update();
    });
  }

  void deleteinstructor(String id, context) {
    firebaseFirestore.collection("instructors").doc(id).delete();
    // Navigator.pop(context);
  }

  void assignValues() {
    imageloading = false;
    usernamecontroller.text = Staticdata.adminmodel!.name!;
    useremailcontroller.text = Staticdata.adminmodel!.email!;
  }

  void updateprofilepicture() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference reference = storage.ref().child("AdminProfile/${Staticdata.uid}");

    UploadTask uploadTask = reference.putData(imagebytes!);

    await uploadTask.whenComplete(() => null);

    String imageUrl = await reference.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(Staticdata.uid)
        .set(
      {
        'imageURL': imageUrl,
      },
      SetOptions(merge: true),
    );

    await firebaseFirestore
        .collection('Admin')
        .doc(Staticdata.uid)
        .get()
        .then((value) {
      Staticdata.adminmodel = AdminwebModel.fromMap(value.data()!);
    });

    showtoast("prfile updated successfully");
    imageloading = false;
    update();
  }

  void deletepic(context) async {
    imageloading = true;
    update();
    if (Staticdata.adminmodel!.imageURL == null && profileImage == null) {
      showtoast("Already deleted");
      imageloading = false;
      update();
      Navigator.pop(context);
    } else {
      Staticdata.adminmodel!.imageURL = null;
      profileImage = null;
      update();
      Reference refrence = FirebaseStorage.instance
          .ref()
          .child("AdminProfile/${Staticdata.uid}");
      await refrence.delete();

      await FirebaseFirestore.instance
          .collection('Admin')
          .doc(Staticdata.uid)
          .set(
        {
          'imageURL': null,
        },
        SetOptions(merge: true),
      );

      await firebaseFirestore
          .collection('Admin')
          .doc(Staticdata.uid)
          .get()
          .then((value) {
        Staticdata.adminmodel = AdminwebModel.fromMap(value.data()!);
      });
      showtoast("Deleted Succesfully");
      imageloading = false;
      Navigator.pop(context);
      update();
    }
  }

  void updatefields() async {
    imageloading = true;

    update();
    await FirebaseFirestore.instance
        .collection('Admin')
        .doc(Staticdata.uid)
        .set(
      {
        'name': usernamecontroller.text,
        'email': useremailcontroller.text,
      },
      SetOptions(merge: true),
    );
    showtoast("Succesfully Saved");
    imageloading = false;
    update();
  }

  bool opentextfield = false;
  TextEditingController controllerleaders = TextEditingController();

  void addleaderslist(context) {
    //////////////////////////
    if (controllerleaders.text.isNotEmpty) {
      String id = const Uuid().v4();
      InstructorModel model = InstructorModel(
        id: id,
        name: controllerleaders.text,
      );
      ManageProfileController.my.firebaseFirestore
          .collection("instructors")
          .doc(id)
          .set(model.toMap());
      update();
      opentextfield = false;
      showtoast(
        "sucessflly added instructor",
      );
      controllerleaders.clear();
    } else {
      showtoast(
        "deleted",
      );
    }
    update();
  }
}

@immutable
class VideoModel {
  final String? videoURL;
  final String? videoID;
  final String? time;

  const VideoModel({this.videoURL, this.videoID, this.time});

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoURL: map['videoURL'],
      videoID: map['videoID'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoURL': videoURL,
      'videoID': videoID,
      'time': time,
    };
  }
}
