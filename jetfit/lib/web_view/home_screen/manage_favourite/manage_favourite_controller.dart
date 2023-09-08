import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:get/get.dart';

class ManageFAvouriteController extends GetxController {
  static ManageFAvouriteController get my => Get.find();
  TextEditingController searchusercontroller = TextEditingController();

  String name = '';

  bool is_edit_favourite_click = false;
  UserModel? userModel;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void deleteUser(String userID, String favID, context) async {
    print("userID $userID");
    print("favID $favID");
    await firebaseFirestore
        .collection("favourite")
        .doc(userID)
        .collection("userVideos")
        .doc(favID)
        .delete();
    Navigator.pop(context);
    showtoast("deleted");
  }

  void removetofavourite(String userID, String catID, context) async {
    List<PlayListModel> modellist = [];
    modellist.clear();
    FirebaseFirestore.instance
        .collection("favourite")
        .doc(userID)
        .collection("userplaylist")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          modellist.add(PlayListModel.fromMap(element.data()));
        });
      }
    });
    for (var u in modellist) {
      await FirebaseFirestore.instance
          .collection("favourite")
          .doc(userID)
          .collection("userplaylist")
          .doc(catID)
          .collection("videos")
          .doc(u.videoID)
          .delete();
    }
    await FirebaseFirestore.instance
        .collection("favourite")
        .doc(userID)
        .collection("userplaylist")
        .doc(catID)
        .delete();

    showtoast("remove from favourite");
    Navigator.pop(context);
    update();
  }

  // void deletecategory(String userID, String catID, context) async {
  //   print("userID $userID");
  //   print("catID $catID");
  //   await firebaseFirestore
  //       .collection("favourite")
  //       .doc(userID)
  //       .collection("userplaylist")
  //       .doc(catID)
  //       .delete();
  //   Navigator.pop(context);
  //   showtoast("deleted");
  // }

  void manageFavouritetap(UserModel model) async {
    is_edit_favourite_click = true;
    userModel = model;

    name = '';
    searchusercontroller.clear();
    update();
  }
}
