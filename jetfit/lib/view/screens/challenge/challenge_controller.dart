import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';

class ChallengeController extends GetxController {
  static ChallengeController get instance => Get.find();
  void removetofavourite(
    String id,
  ) async {
    await FirebaseFirestore.instance
        .collection("favourite")
        .doc(Staticdata.uid)
        .collection("userVideos")
        .doc(id)
        .delete();
    showtoast(" remove from favourite");
    update();
  }

  bool isclick = false;
  void addtofavourite(VideossModel videomodel, context) async {
    await FirebaseFirestore.instance
        .collection("favourite")
        .doc(Staticdata.uid)
        .collection("userVideos")
        .doc(videomodel.videoID)
        .set(videomodel.toMap());
    showtoast("${videomodel.videoName} added to favourite");
    Navigator.pop(context);
    update();
  }
}
