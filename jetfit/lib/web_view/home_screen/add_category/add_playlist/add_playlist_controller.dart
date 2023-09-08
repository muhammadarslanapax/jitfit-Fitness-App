import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/notification_service/notification_service.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class AddCtagoryController extends GetxController {
  static AddCtagoryController get my => Get.find();
  TextEditingController categorynamecontroller = TextEditingController();
  TextEditingController categorydurationtimelinecontroller =
      TextEditingController();

  TextEditingController videodurationtimelinecontroller =
      TextEditingController();
  TextEditingController videonamecontroller = TextEditingController();
  TextEditingController categorydescriptioncontroller = TextEditingController();
  TextEditingController videodescriptioncontroller = TextEditingController();
  TextEditingController categorydayscontroller = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isaddvideoclick = false;
  VideoPlayerController? videoplayerController;
  String? playlistID;
  bool playlistloading = false;
  bool uploadplaylistloading = false;
  bool categoryloading = false;
  bool isvideoplayclick = true;
  List<String> instructormenuItems = [];

  String catagoryselectedValue = "Workout";
  String typeselectedvalue = "Public";
  String difficultyselectedvalue = "Easy";
  String classtypeselectedvalue = "Solo";
  String instructorselectedvalue = "Java";
  String videolanguageselectedvalue = "German";
  Future<Uint8List>? thumbnailFuture;

  //////////////////
  XFile? videofile;
  String? videoooourl;

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

  void changeisaddvideoclick(bool value) {
    isaddvideoclick = value;
    update();
  }

  void nulluploadvideo() {
    changeisaddvideoclick(false);
    playlistloading = false;
    uploadplaylistloading = false;
    videodescriptioncontroller.clear();
    videonamecontroller.clear();
    if (videofile != null) {
      videofile = null;
    }
    update();
  }

  // void changedropdownselectedvalue(String value, String selectedValue) {
  //   selectedValue = value;
  //   update();
  // }

  String? categoryId;

  void uploadcategoryToDB(String imageUrl, String id) async {
    categoryId = id;
    CategoryModel model = CategoryModel(
      classType: classtypeselectedvalue,
      dificulty: difficultyselectedvalue,
      instructor: instructorselectedvalue,
      videoLanguage: videolanguageselectedvalue,
      categoryDescription: categorydescriptioncontroller.text,
      categoryID: id,
      categoryName: categorynamecontroller.text,
      playlistType: typeselectedvalue,
      categoryType: catagoryselectedValue,
      thumbnailimageURL: imageUrl,
      categoryTimeline: categorydurationtimelinecontroller.text,
    );
    await firebaseFirestore.collection("category").doc(id).set(model.toMap());
    categoryloading = false;
    update();
    pushNotificationsAllUsers(
        body:
            "${Staticdata.adminmodel!.name} posted a playlist ${categorynamecontroller.text}",
        title: "A new playlist arrived");
    showtoast("category added succesfully");
  }

  void initstatefunctions() {
    categorynamecontroller.clear();
    categorydescriptioncontroller.clear();
    categorydescriptioncontroller.clear();
    categorydurationtimelinecontroller.clear();
    categoryId = null;
    isaddvideoclick = false;
    thumbnailImage = null;
    categoryloading = false;
    playlistloading = false;
    videofile = null;
  }

  void uploadplaylistToDB(String videoUrl) async {
    uploadplaylistloading = true;
    update();
    PlayListModel model = PlayListModel(
      duration: '',
      categoryID: categoryId,
      videoDescription: videodescriptioncontroller.text,
      videoID: playlistID,
      videoName: videonamecontroller.text,
      videoURL: videoUrl,
      viewers: [],
    );
    pushNotificationsAllUsers(
        body:
            "${Staticdata.adminmodel!.name} posted video ${videonamecontroller.text} in ${categorynamecontroller.text}",
        title: "A new playlist video arrived");
    await firebaseFirestore
        .collection("category")
        .doc(categoryId)
        .collection("playlist")
        .doc(playlistID)
        .set(model.toMap());
    showtoast("Sucess");
    uploadplaylistloading = false;
    isaddvideoclick = false;
    videofile = null;

    update();
  }

  // Future<void>? initializeVideoPlayerFuture;
  // void initvideoplayer(String url) async {
  //   videoplayerController = VideoPlayerController.networkUrl(Uri.parse(url));
  //   initializeVideoPlayerFuture = videoplayerController!.initialize();
  //   update();
  // }

///////////////////////////////////////
  FirebaseStorage storage = FirebaseStorage.instance;

  ///
  Future<String> uploadVideo(Uint8List unitlist) async {
    String pillly = const Uuid().v4();
    playlistID = pillly;
    Reference storageRef =
        storage.ref().child('category/$categoryId/playlist/$playlistID');
    TaskSnapshot uploadTask = await storageRef.putData(unitlist);
    String url = await uploadTask.ref.getDownloadURL();
    playlistloading = false;
    update();
    return url;
  }

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

  /////////////////////////////////////////
  XFile? thumbnailImage;
  Uint8List? imagebytes;

  void pickImage() async {
    thumbnailImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
    if (thumbnailImage != null) {
      imagebytes = await thumbnailImage!.readAsBytes();
      update();
    }
  }

  void uploadImage(XFile image) async {
    var bytes = await image.readAsBytes();

    String categoryid = const Uuid().v4();
    categoryloading = true;
    update();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef =
        storage.ref().child('category/$categoryid/thumbnailimage$categoryid');
    var uploadTask = await storageRef.putData(bytes);
    await uploadTask.ref.getDownloadURL().then((value) {
      uploadcategoryToDB(value, categoryid);
    });
  }

  void deletevideo(String catID, String playlistID, context) async {
    Reference storageRef =
        storage.ref().child('category/$catID/playlist/$playlistID');
    await storageRef.delete();

    await firebaseFirestore
        .collection("category")
        .doc(catID)
        .collection("playlist")
        .doc(playlistID)
        .delete();
    showtoast("deleted");
    Navigator.pop(context);
  }

  void floatingactionfunction() {
    if (categoryId != null && thumbnailImage != null) {
      videodescriptioncontroller.clear();
      videonamecontroller.clear();
      changeisaddvideoclick(true);
      if (videofile != null) {
        videofile = null;
      }
      playlistloading = false;
      update();
    } else {
      showtoast("Please Save category");
    }
  }
}
