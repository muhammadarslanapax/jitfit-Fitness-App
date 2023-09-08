import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:get/get.dart';
import 'package:jetfit/view/screens/feedback/feedback.dart';

class FeedbackController extends GetxController {
  static FeedbackController get my => Get.find();
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController descriptioncontroller = TextEditingController();
  bool is_edit_playlist_click = false;
  CategoryModel? categorymodel;
  TextEditingController searchplaylistcontroller = TextEditingController();
  String? selectedCategory;
  String name = '';
  void iseditplaylistclick(CategoryModel model) {
    is_edit_playlist_click = true;

    categorymodel = model;
    print("categorymodel ${categorymodel}");
    update();
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  void deletefeedbfile(
      String catID, FeedbackModel feedbackmodel, context, bool isvideo) async {
    if (feedbackmodel.videourl != '' || feedbackmodel.imageurl != '') {
      Reference storageRef =
          storage.ref().child('category/${catID}/feedback/${feedbackmodel.id}');
      await storageRef.delete();
      if (isvideo == true) {
        print("video");
        await firebaseFirestore
            .collection("category")
            .doc(catID)
            .collection("feedback")
            .doc(feedbackmodel.id)
            .update({"videourl": null});
      } else {
        print("image");
        await firebaseFirestore
            .collection("category")
            .doc(catID)
            .collection("feedback")
            .doc(feedbackmodel.id)
            .update({"imageurl": null});
      }
      Navigator.pop(context);
      showtoast("deleted");
    } else {
      Navigator.pop(context);
      showtoast("already deleted");
    }
  }
}
