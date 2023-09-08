import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final fireStorageRef = FirebaseStorage.instance;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('User');
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();

  Map<String, dynamic>? userInfo;
  var selectedImage = Rx<XFile?>(null);
  String url = '';

  void getGalleryImage() async {
    XFile? pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      selectedImage.value = pickImage;
      update();
    }
  }

  void getCameraImage() async {
    XFile? pickImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickImage != null) {
      selectedImage.value = pickImage;
      update();
    }
  }

  void uploadImage(context) async {
    isLoading = true;
    update();
    if (selectedImage.value == null && Staticdata.userModel!.imageURL == null) {
      showtoast("please select image");
    } else {
      Reference storageref =
          FirebaseStorage.instance.ref("Images").child("${Staticdata.uid}");
      TaskSnapshot uploadtask =
          await storageref.putFile(File(selectedImage.value!.path));
      url = await uploadtask.ref.getDownloadURL();
      await collection
          .doc(Staticdata.uid)
          .update({
            'imageURL': url,
          })
          .then((value) => {
                Fluttertoast.showToast(msg: 'save'),
              })
          .onError((error, stackTrace) => {
                Fluttertoast.showToast(msg: 'Failed'),
              });
    }
    await collection
        .doc(Staticdata.uid)
        .update({
          'name': nameController.text,
        })
        .then((value) => {
              Fluttertoast.showToast(msg: 'save'),
            })
        .onError((error, stackTrace) => {
              Fluttertoast.showToast(msg: 'Failed'),
            });

    FirebaseFirestore.instance
        .collection("User")
        .doc(Staticdata.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        showtoast("Invalid Signin !");
      } else {
        Staticdata.userModel = UserModel.fromMap(value.data()!);
      }
    });
    isLoading = false;
    update();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ));
  }
}
