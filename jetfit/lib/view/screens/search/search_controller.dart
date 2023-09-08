import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/static_data.dart';

class VideoSearchController extends GetxController {
  static VideoSearchController get instance => Get.find();

  TextEditingController searchController = TextEditingController();

  String name = '';
  bool ispremuimclick = false;
  bool isexclusiveclick = false;

  VideossModel? videossModel;
  void premiumClickModel(VideossModel model) {
    videossModel = model;

    ispremuimclick = true;

    update();
  }

  void exclusiveClickModel(VideossModel model) async {
    videossModel = model;

    Staticdata.isexclusive = await isVideoIDInFavorites(model.videoID!);

    isexclusiveclick = true;
    update();
  }

  Future<bool> isVideoIDInFavorites(String videoID) async {
    try {
      List<String> favoriteVideoIDs = await getFavoriteVideoIDs();
      return favoriteVideoIDs.contains(videoID);
    } catch (e) {
      print("Error checking video ID in favorites: $e");
      return false; // Handle the error appropriately
    }
  }

  Future<List<String>> getFavoriteVideoIDs() async {
    List<String> videoIDs = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("favourite")
          .doc(Staticdata.uid)
          .collection("exclusive")
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        var data = doc.data();
        if (data.containsKey("videoID") && data["videoID"] is String) {
          videoIDs.add(data["videoID"]);
        }
      }
    } catch (e) {
      print("Error getting favorite video IDs: $e");
    }

    return videoIDs;
  }

// // Usage example:
// Future<void> fetchData() async {
//   List<String> favoriteVideoIDs = await getFavoriteVideoIDs();
//   // Now you have a list of favorite video IDs in `favoriteVideoIDs`.
//   // You can use this list for further processing.
// }
}
