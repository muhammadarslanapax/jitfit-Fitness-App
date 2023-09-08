import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetfit/utilis/notification_service/notification_service.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class AddVideoController extends GetxController {
  static AddVideoController get my => Get.find();
  TextEditingController categorydurationtimelinecontroller =
      TextEditingController();
  bool playlistloading = false;

  TextEditingController videonamecontroller = TextEditingController();
  TextEditingController videopricecontroller = TextEditingController();
  TextEditingController videodescriptioncontroller = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isaddvideoclick = false;
  VideoPlayerController? videoplayerController;
  bool uploadplaylistloading = false;
  String? videoID;
  XFile? videofile;
  bool categoryloading = false;
  bool isvideoplayclick = true;
  List<String> instructormenuItems = [];

  List<String> typeitems = [
    "Public",
    "Premium",
    "Exclusive",
  ];
  List<String> catagorytypeitems = [
    "Workout",
    "Challenges",
    "Routines",
    "Series",
  ];
  List<String> difficultymenuItems = [
    "Easy",
    "Hard",
    "Medium",
  ];
  List<String> classtypemenuItems = [
    "Solo",
    "Duo",
    "Group",
  ];

  List<String> videolanguagemenuItems = [
    "German",
    "English",
    "Russian",
  ];
  String catagoryselectedValue = "Workout";
  String difficultyselectedvalue = "Easy";
  String typeselectedvalue = "Public";
  String classtypeselectedvalue = "Solo";
  String instructorselectedvalue = 'Java';
  String videolanguageselectedvalue = "German";

  void initstatefunctions() {
    categorydurationtimelinecontroller.clear();
    videodescriptioncontroller.clear();
    videonamecontroller.clear();
    isaddvideoclick = false;
    categoryloading = false;
    playlistloading = false;
    videofile = null;
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadVideo(Uint8List unitlist) async {
    videoID = const Uuid().v4();

    Reference storageRef = storage.ref().child('video/$videoID');
    TaskSnapshot uploadTask = await storageRef.putData(unitlist);
    String url = await uploadTask.ref.getDownloadURL();
    playlistloading = false;
    update();
    return url;
  }

  String? videoooourl;

  void pickVideo() async {
    videofile = null;
    playlistloading = true;
    update();
    videofile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    update();
    if (videofile != null) {
      var videoBytes = await videofile!.readAsBytes();
      videoooourl = await uploadVideo(videoBytes);

      update();
    } else {
      print("falsseeeeeee");
      playlistloading = false;
      update();
    }
  }

  void uploadplaylistToDB(String videoUrl, String videoID) async {
    uploadplaylistloading = true;
    update();
    VideossModel model = VideossModel(
      videotype: typeselectedvalue,
      viewers: [],
      classType: classtypeselectedvalue,
      dificulty: difficultyselectedvalue,
      duration: categorydurationtimelinecontroller.text,
      instructor: instructorselectedvalue,
      videoLanguage: videolanguageselectedvalue,
      catagorytpe: catagoryselectedValue,
      videoDescription: videodescriptioncontroller.text,
      videoID: videoID,
      videoName: videonamecontroller.text,
      videoURL: videoUrl,
      price: typeselectedvalue == 'Exclusive' ? videopricecontroller.text : '',
    );
    await firebaseFirestore
        .collection("videos")
        .doc(videoID)
        .set(model.toMap());
    showtoast("Sucess");
    pushNotificationsAllUsers(
        body:
            "${Staticdata.adminmodel!.name} posted a video ${videonamecontroller.text}",
        title: "A new video arrived");
    uploadplaylistloading = false;

    categorydurationtimelinecontroller.clear();
    videodescriptioncontroller.clear();
    videonamecontroller.clear();
    isaddvideoclick = false;
    categoryloading = false;
    playlistloading = false;
    videofile = null;

    update();
  }
}
