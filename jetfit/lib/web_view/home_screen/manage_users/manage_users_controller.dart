import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ManageUserController extends GetxController {
  static ManageUserController get my => Get.find();
  TextEditingController searchusercontroller = TextEditingController();
  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  String? imageURL;
  String name = '';
  XFile? profileImage;
  Uint8List? imagebytes;
  bool imageloading = false;
  bool updateLoading = false;
  bool is_edit_user_click = false;
  String? image;
  UserModel? userModel;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? selectedvalue;
  List<String> menuItems = [
    "free user",
    "premium user",
  ];

  void deleteUser(UserModel model, context) async {
    if (model.imageURL != '') {
      Reference refrence =
          FirebaseStorage.instance.ref().child("UserProfile/${model.id}");
      await refrence.delete();
    }

    await firebaseFirestore.collection("User").doc(model.id).delete();
    Navigator.pop(context);
    showtoast("deleted");
  }

  void edituserclick(UserModel model) async {
    profileImage = null;
    update();

    is_edit_user_click = true;
    userModel = model;
    usernamecontroller.text = model.name!;
    useremailcontroller.text = model.email!;
    image = model.imageURL;
    selectedvalue = model.role;

    update();
  }

  void updateuser(String userID) async {
    updateLoading = true;
    update();

    if (imageloading == true) {
      showtoast("Uploading in progress");
      updateLoading = false;
      update();
    } else {
      await firebaseFirestore.collection("User").doc(userID).update(
        {
          'name': usernamecontroller.text,
          'email': useremailcontroller.text,
          'role': selectedvalue,
        },
      );
      showtoast("successfully saved");
      updateLoading = false;
      is_edit_user_click = false;
      update();
    }
  }

  void pickImage(UserModel model) async {
    imageloading = true;
    update();
    profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      imagebytes = await profileImage!.readAsBytes();
      updateprofilepicture(model);
    } else {
      imageloading = false;
      update();
    }
  }

  void updateprofilepicture(UserModel model) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference reference = storage.ref().child("UserProfile/${model.id}");

    UploadTask uploadTask = reference.putData(imagebytes!);

    await uploadTask.whenComplete(() => null);

    String imageUrl = await reference.getDownloadURL();

    await FirebaseFirestore.instance.collection('User').doc(model.id).set(
      {
        'imageURL': imageUrl,
      },
      SetOptions(merge: true),
    );

    showtoast("prfile updated successfully");
    imageloading = false;
    is_edit_user_click = false;
    update();
  }

  void deletepic(UserModel model, context) async {
    updateLoading = true;
    update();
    Navigator.pop(context);

    if (model.imageURL == null && profileImage == null) {
      showtoast("Already deleted");
      updateLoading = false;
      update();
    } else {
      profileImage = null;
      update();
      Reference refrence =
          FirebaseStorage.instance.ref().child("UserProfile/${model.id}");
      await refrence.delete();

      await FirebaseFirestore.instance.collection('User').doc(model.id).set(
        {
          'imageURL': null,
        },
        SetOptions(merge: true),
      );

      showtoast("Deleted Succesfully");
      updateLoading = false;
      update();
    }
  }
}
