import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';

class FavouriteController extends GetxController {
  static FavouriteController get my => Get.find();
  bool isclick = false;

  TextEditingController searchController = TextEditingController();
  String name = '';
  void removetofavourite(
      VideossModel vaideomodel, context, DashBoardController obj) async {
    await FirebaseFirestore.instance
        .collection("favourite")
        .doc(Staticdata.uid)
        .collection("userVideos")
        .doc(vaideomodel.videoID)
        .delete();
    showtoast("${vaideomodel.videoName} remove from favourite");

    Navigator.pop(context);

    obj.index = 3;
    obj.update();
    isclick = false;

    update();
  }

  PlayListModel? playListModel;
  void videoclickModel(PlayListModel model) {
    playListModel = model;
    isclick = true;
    update();
  }

  bool ispremuimclick = false;
  bool isexclusiveclick = false;

  VideossModel? videossModel;
  void premiumClickModel(VideossModel model) {
    videossModel = model;
    update();
    ispremuimclick = true;
    print('zzzzzzzzzzzzzzzz$model');
    print('zzzzzzzzzzzzzzzz$ispremuimclick');
    update();
  }

  void exclusiveClickModel(VideossModel model) {
    videossModel = model;
    update();
    isexclusiveclick = true;
    print('zzzzzzzzzzzzzzzz$model');
    print('zzzzzzzzzzzzzzzz$ispremuimclick');
    update();
  }
}
