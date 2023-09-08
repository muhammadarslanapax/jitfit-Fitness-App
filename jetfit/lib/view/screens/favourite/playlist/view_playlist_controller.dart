import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';

class ViewPlaylistController extends GetxController {
  static ViewPlaylistController get instance => Get.find();
  void addtofavourite(CategoryModel model, context) async {
    List<PlayListModel> modellist = [];
    FirebaseFirestore.instance
        .collection("category")
        .doc(model.categoryID)
        .collection("playlist")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          modellist.add(PlayListModel.fromMap(element.data()));
        });
      }
    });

    await FirebaseFirestore.instance
        .collection("favourite")
        .doc(Staticdata.uid)
        .collection("userplaylist")
        .doc(model.categoryID)
        .set(model.toMap());

    for (var u in modellist) {
      await FirebaseFirestore.instance
          .collection("favourite")
          .doc(Staticdata.uid)
          .collection("userplaylist")
          .doc(model.categoryID)
          .collection("videos")
          .doc(u.videoID)
          .set(u.toMap());
    }
    Navigator.pop(context);
    showtoast("added to favourite");
    update();
  }

  bool isclick = false;
  void removetofavourite(CategoryModel model, context) async {
    List<PlayListModel> modellist = [];
    modellist.clear();
    FirebaseFirestore.instance
        .collection("favourite")
        .doc(Staticdata.uid)
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
          .doc(Staticdata.uid)
          .collection("userplaylist")
          .doc(model.categoryID)
          .collection("videos")
          .doc(u.videoID)
          .delete();
    }
    await FirebaseFirestore.instance
        .collection("favourite")
        .doc(Staticdata.uid)
        .collection("userplaylist")
        .doc(model.categoryID)
        .delete();

    showtoast("remove from favourite");
    Navigator.pop(context);
    update();
  }
}
