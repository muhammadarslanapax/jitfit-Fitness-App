import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/notification_service/notification_service.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class ManageCtagoryController extends GetxController {
  static ManageCtagoryController get my => Get.find();
  TextEditingController categorynamecontroller = TextEditingController();
  TextEditingController videonamecontroller = TextEditingController();
  TextEditingController categorydurationtimelinecontroller =
      TextEditingController();
  TextEditingController searchviewercontroller = TextEditingController();
  TextEditingController searchplaylistcontroller = TextEditingController();
  TextEditingController categorydescriptioncontroller = TextEditingController();
  TextEditingController videodescriptioncontroller = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? categoryID;
  bool categoryloading = false;
  bool playlistloading = false;
  bool editplaylistloading = false;
  bool uploadingeditvideoclick = false;
  bool is_edit_category_click = false;
  bool is_edit_playlist_click = false;
  bool is_edit_video_click = false;
  bool is_viewer_click = false;
  bool is_upload_video_click = false;
  bool uploadplaylistloading = false;
  bool edituploadplaylistloading = false;
  String name = '';
  VideoPlayerController? videoplayerController;
  String? selectedCategory;
  XFile? videofile;
  CategoryModel? editcategory_Model;
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

  List<String> instructormenuItems = [];
  List<String> videolanguagemenuItems = [
    "German",
    "English",
    "Russian",
  ];

  String? catagoryselectedValue = "Workout";
  String? difficultyselectedvalue = "Easy";
  String? typeselectedvalue = "Public";
  String? classtypeselectedvalue = "Solo";
  String? instructorselectedvalue = 'Java';
  String? videolanguageselectedvalue = "German";
  String? videoooourl;
  String? playlistID;

  void pickVideo(String catid) async {
    videofile = null;
    playlistloading = true;
    update();
    videofile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    update();
    if (videofile != null) {
      var videoBytes = await videofile!.readAsBytes();
      videoooourl = await uploadVideo(videoBytes, catid);

      update();
    } else {
      playlistloading = false;
      update();
    }
  }

  Future<String> uploadVideo(Uint8List unitlist, String catid) async {
    String pillly = const Uuid().v4();
    playlistID = pillly;
    Reference storageRef =
        storage.ref().child('category/$catid/playlist/$playlistID');
    TaskSnapshot uploadTask = await storageRef.putData(unitlist);
    String url = await uploadTask.ref.getDownloadURL();
    playlistloading = false;
    update();
    return url;
  }

  void videoviewdelete(PlayListModel model, int index, context) async {
    var ref = FirebaseFirestore.instance
        .collection("category")
        .doc(model.categoryID)
        .collection("playlist")
        .doc(model.videoID);
    var refdoc = await ref.get();
    List<String> viewers = [];
    viewers.clear();
    viewers = List<String>.from(refdoc.get('viewers') ?? []);
    viewers.removeAt(index);

    await ref.update(
      {'viewers': viewers},
    );
    Navigator.pop(context);
    getviewers(model);

    update();
  }

  List<String> videoviewers = [];
  List<UserModel> usermodel = [];
  PlayListModel? playlistVideoModel;
  Future<List<UserModel>> getviewers(PlayListModel model) async {
    videoviewers.clear();
    usermodel.clear();
    playlistVideoModel = model;
    is_viewer_click = true;
    update();

    videoviewers = List<String>.from(model.viewers ?? []);
// get list of users;;;
    for (var u in videoviewers) {
      FirebaseFirestore.instance.collection("User").doc(u).get().then((value) {
        if (value.data() != null) {
          UserModel model = UserModel.fromMap(value.data()!);
          usermodel.add(model);
          update();
        }
      });
    }
    fetchusermodel();
    return usermodel;
  }

  Future<List<UserModel>> fetchusermodel() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return usermodel;
  }

  void uploadplaylistToDB(String videoUrl, String catid) async {
    uploadplaylistloading = true;
    update();
    PlayListModel model = PlayListModel(
      duration: '',
      categoryID: catid,
      videoDescription: videodescriptioncontroller.text,
      videoID: playlistID,
      videoName: videonamecontroller.text,
      videoURL: videoUrl,
      viewers: [],
    );
    await firebaseFirestore
        .collection("category")
        .doc(catid)
        .collection("playlist")
        .doc(playlistID)
        .set(model.toMap());
    pushNotificationsAllUsers(
        body:
            "${Staticdata.adminmodel!.name} posted video ${videonamecontroller.text}",
        title: "A new playlist video arrived");
    showtoast("Sucess");
    uploadplaylistloading = false;
    is_upload_video_click = false;
    videofile = null;

    update();
  }

  String? dropdownValues;

  void falseAllClick() {
    is_edit_category_click = false;
    is_edit_playlist_click = false;
    is_edit_video_click = false;
    is_viewer_click = false;
    is_single_viewer_click = false;
    is_upload_video_click = false;
    selectedCategory = 'Workout';
  }

  void editcategoryimage(XFile image, String catid) async {
    var bytes = await image.readAsBytes();

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef =
        storage.ref().child('category/$catid/thumbnailimage$catid');
    var uploadTask = await storageRef.putData(bytes);
    await uploadTask.ref.getDownloadURL().then((value) {
      editcategory_Model!.thumbnailimageURL = value;
      update();

      firebaseFirestore.collection("category").doc(catid).update({
        'thumbnailimageURL': value,
      });
    });
    categoryloading = false;
    update();
  }

  void uploadeEditcategoryToDB(String id) async {
    categoryloading = true;
    update();
    await firebaseFirestore.collection("category").doc(id).update({
      'categoryDescription': categorydescriptioncontroller.text,
      'categoryID': id,
      "classType": classtypeselectedvalue,
      "dificulty": difficultyselectedvalue,
      "instructor": instructorselectedvalue,
      "videoLanguage": videolanguageselectedvalue,
      'categoryName': categorynamecontroller.text,
      'categoryType': catagoryselectedValue,
      'playlistType': typeselectedvalue,
      'categoryTimeline': categorydurationtimelinecontroller.text,
    });
    categoryloading = false;
    is_edit_category_click = false;
    is_edit_playlist_click = false;

    update();
    showtoast("succesfully saved");
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> deleteFolderAndContents(String folderPath) async {
    Reference playlistRef = storage.ref().child(folderPath);

    try {
      ListResult listResult = await playlistRef.listAll();

      await Future.forEach(listResult.items, (Reference item) async {
        await item.delete();
      });
      await playlistRef.delete();
    } catch (e) {
      print('Error deleting playlist folder $folderPath: $e');
    }
  }

  void deletecategory(String catID, context) async {
    Reference categoryRef =
        FirebaseStorage.instance.ref().child('category/$catID');
    Reference playlistRef = categoryRef.child('playlist');

    try {
      await deleteFolderAndContents(playlistRef.fullPath);
      await categoryRef.child('thumbnailimage$catID').delete();
      await categoryRef.delete();

      print('Category folder $catID and playlist deleted successfully.');
    } catch (e) {
      print('Error deleting category folder $catID and playlist: $e');
    }
    try {
      DocumentReference categoryDocRef =
          FirebaseFirestore.instance.collection('category').doc(catID);

      CollectionReference playlistCollectionRef =
          categoryDocRef.collection('playlist');

      QuerySnapshot playlistSnapshot = await playlistCollectionRef.get();

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (var playlistDoc in playlistSnapshot.docs) {
        batch.delete(playlistDoc.reference);
      }

      batch.delete(categoryDocRef);

      await batch.commit();

      print(
          'Category with catID: $catID and its playlist deleted successfully.');
    } catch (e) {
      print('Error deleting category with catID: $catID and playlist: $e');
    }

    showtoast("deleted");
    Navigator.pop(context);

    update();
  }

  XFile? thumbnailImage;
  Uint8List? imagebytes;

  void pickImage(String id) async {
    thumbnailImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (thumbnailImage != null) {
      categoryloading = true;
      update();
      imagebytes = await thumbnailImage!.readAsBytes();
      editcategoryimage(thumbnailImage!, id);
      update();
    } else {
      categoryloading = false;
      update();
    }
  }

  void editcategory_click_method(CategoryModel model) {
    is_edit_category_click = true;
    update();
    editcategory_Model = model;
    classtypeselectedvalue = model.classType;
    difficultyselectedvalue = model.dificulty;
    instructorselectedvalue = model.instructor;
    videolanguageselectedvalue = model.videoLanguage;
    catagoryselectedValue = model.categoryType!;
    categorynamecontroller.text = model.categoryName!;
    typeselectedvalue = model.playlistType!;
    categorydescriptioncontroller.text = model.categoryDescription!;
    categorydurationtimelinecontroller.text = model.categoryTimeline!;
  }

  void iseditplaylistclick(CategoryModel model) {
    is_edit_playlist_click = true;

    editcategory_Model = model;
    update();
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

  PlayListModel? playListModel;

  void editvideoclick(PlayListModel model) {
    is_edit_video_click = true;
    update();

    playListModel = model;

    videodescriptioncontroller.text = model.videoDescription!;
    videonamecontroller.text = model.videoName!;

    update();
  }

  //////////////////////////// edit
  ///  /////////////////// delete video
  bool is_edit_single_video_click = false;
  void deletesinglevideo(String videoID, context) async {
    Reference storageRef = storage.ref().child('video/$videoID');
    await storageRef.delete();

    await firebaseFirestore.collection("videos").doc(videoID).delete();

    showtoast("deleted");
    Navigator.pop(context);
  }

  VideossModel? videossModel;

  void editsinglevideoclick(VideossModel model) {
    is_edit_single_video_click = true;
    videossModel = model;
    update();

    videonamecontroller.text = model.videoName!;
    videodescriptioncontroller.text = model.videoDescription!;
    categorydurationtimelinecontroller.text = model.duration!;

    classtypeselectedvalue = model.classType;
    catagoryselectedValue = model.catagorytpe;

    difficultyselectedvalue = model.dificulty;
    typeselectedvalue = model.videotype!;
    instructorselectedvalue = model.instructor;
    print("instructorselectedvalues ${instructorselectedvalue}");
    videolanguageselectedvalue = model.videoLanguage;
    videodescriptioncontroller.text = model.videoDescription!;
    videonamecontroller.text = model.videoName!;

    update();
  }

  void editsinglepickVideo(String videoID) async {
    editplaylistloading = true;
    update();
    videofile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    update();
    if (videofile != null) {
      var videoBytes = await videofile!.readAsBytes();
      videoooourl = await edituploadsinglevideo(videoBytes, videoID);

      update();
    } else {
      print("falsseeeeeee");

      editplaylistloading = false;
      is_edit_video_click = false;

      update();
    }
  }

  Future<String> edituploadsinglevideo(
      Uint8List unitlist, String videoID) async {
    Reference storageRef = storage.ref().child('video/$videoID');
    TaskSnapshot uploadTask = await storageRef.putData(unitlist);

    String url = await uploadTask.ref.getDownloadURL().then((value) {
      // update URl To db

      firebaseFirestore.collection("videos").doc(videoID).update({
        'videoURL': value,
      });
      return value;
    });

    print("video Url $url");

    // ading stream data

    editplaylistloading = false;

    update();
    return url;
  }

  void uploadeedtsingleVideoToDB(
    String videoID,
  ) async {
    uploadingeditvideoclick = true;
    update();

    await firebaseFirestore.collection("videos").doc(videoID).update({
      'classType': classtypeselectedvalue,
      'dificulty': difficultyselectedvalue,
      'instructor': instructorselectedvalue,
      'videoLanguage': videolanguageselectedvalue,
      'videoDescription': videodescriptioncontroller.text,
      'duration': categorydurationtimelinecontroller.text,
      'videoName': videonamecontroller.text,
      'videotype': typeselectedvalue,
      'catagorytpe': catagoryselectedValue,
    });

    videodescriptioncontroller.clear();
    videonamecontroller.clear();
    if (videofile != null) {
      videofile = null;
    }
    update();
    videoooourl = null;
    is_edit_single_video_click = false;
    editplaylistloading = false;
    uploadingeditvideoclick = false;
    uploadplaylistloading = false;

    update();
    showtoast("succesfully saved");
  }

///////////////////////////////////////////
  void uploadeEditplaylistToDB(String catid, String playlistID) async {
    uploadplaylistloading = true;
    uploadingeditvideoclick = false;
    update();

    await firebaseFirestore
        .collection("category")
        .doc(catid)
        .collection("playlist")
        .doc(playlistID)
        .update({
      'classType': classtypeselectedvalue,
      'dificulty': difficultyselectedvalue,
      'instructor': instructorselectedvalue,
      'videoLanguage': videolanguageselectedvalue,
      'videoDescription': videodescriptioncontroller.text,
      'videoName': videonamecontroller.text,
    });
    videofile = null;
    videoooourl = null;
    is_edit_video_click = false;
    uploadplaylistloading = false;

    update();
    showtoast("succesfully saved");
  }

///////////////////////////
  void editpickVideo(String catid, String playlistId) async {
    editplaylistloading = true;
    uploadingeditvideoclick = true;
    update();
    videofile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    update();
    if (videofile != null) {
      var videoBytes = await videofile!.readAsBytes();
      videoooourl = await edituploadvideo(videoBytes, catid, playlistId);

      update();
    } else {
      print("falsseeeeeee");
      uploadingeditvideoclick = false;

      editplaylistloading = false;
      is_edit_video_click = false;

      update();
    }
  }

  Future<String> edituploadvideo(
      Uint8List unitlist, String catid, String playlistid) async {
    Reference storageRef =
        storage.ref().child('category/$catid/playlist/$playlistid');
    TaskSnapshot uploadTask = await storageRef.putData(unitlist);

    String url = await uploadTask.ref.getDownloadURL().then((value) {
      // update URl To db
      firebaseFirestore
          .collection("category")
          .doc(catid)
          .collection("playlist")
          .doc(playlistid)
          .update({
        'videoURL': value,
      });
      return value;
    });

    print("video Url $url");

    // ading stream data

    editplaylistloading = false;

    update();
    return url;
  }

  int index = 0;
  bool isFilterOpen = false;

  bool isclick = false;
  bool isSortOpen = false;
  String filter = "";

  changePage(int n) {
    index = n;
    update();
  }

  openFilter(bool v) {
    isFilterOpen = v;
    update();
  }

  sortFilter(bool v) {
    isSortOpen = v;
    update();
  }

  filterChange(String f) {
    filter = f;
    update();
  }

  ///////////////////////////

  bool is_single_viewer_click = false;

  Future<List<UserModel>> getsingleviewers(VideossModel model) async {
    videoviewers.clear();
    usermodel.clear();
    videossModel = model;
    is_single_viewer_click = true;
    update();

    videoviewers = List<String>.from(model.viewers ?? []);
// get list of users;;;
    for (var u in videoviewers) {
      FirebaseFirestore.instance.collection("User").doc(u).get().then((value) {
        if (value.data() != null) {
          UserModel model = UserModel.fromMap(value.data()!);
          usermodel.add(model);
          update();
        }
      });
    }
    fetchsingleusermodel();
    return usermodel;
  }

  Future<List<UserModel>> fetchsingleusermodel() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return usermodel;
  }

  void videosingleviewdelete(VideossModel model, int index, context) async {
    var ref =
        FirebaseFirestore.instance.collection("videos").doc(model.videoID);

    var refdoc = await ref.get();
    List<String> viewers = [];
    viewers.clear();
    viewers = List<String>.from(refdoc.get('viewers') ?? []);
    viewers.removeAt(index);

    await ref.update(
      {'viewers': viewers},
    );
    Navigator.pop(context);
    getsingleviewers(model);

    update();
  }
}
