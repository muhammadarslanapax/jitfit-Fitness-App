import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home01Controller extends GetxController {
  static Home01Controller get my => Get.find();
  int? catindex;
  bool? value;
  CategoryModel? model;
  Stream<QuerySnapshot<Map<String, dynamic>>>? categoriesStream;
  void getVisit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool("check");
  }

  void setVisit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool("check");
    value = null;
    if (value == null) {
      value = false;
      update();
      prefs.setBool("check", false);
    } else if (value == false) {
      prefs.setBool("check", true);
    }
  }

  Future<void> getcatagories() async {
    categoriesStream =
        await FirebaseFirestore.instance.collection('category').snapshots();
    await FirebaseFirestore.instance.collection('category').get().then((value) {
      if (value.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> firstDocument = value.docs.first;
        CategoryModel firstCategory =
            CategoryModel.fromMap(firstDocument.data()!);
        print("First Category ID: ${firstCategory.categoryID}");
        fetchPlaylistForCategory(firstCategory.categoryID!);
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? playlistSnapshot;
  Future<void> fetchPlaylistForCategory(String categoryId) async {
    playlistSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc(categoryId)
        .collection("playlist")
        .snapshots();
    update();
  }

  void onCategoryTap(String categoryId) {
    fetchPlaylistForCategory(categoryId);

    update();
  }

  void videoview(String categoryId, String playlistId, String uid) async {
    var ref = FirebaseFirestore.instance
        .collection("category")
        .doc(categoryId)
        .collection("playlist")
        .doc(playlistId);
    var refdoc = await ref.get();
    var viewers = List<String>.from(refdoc.get('viewers') ?? []);

    int updateindex = viewers.indexWhere((element) => element == uid);
    if (updateindex != -1) {
      viewers[updateindex] = uid;
      update();
    } else {
      viewers.add(uid);
    }

    await ref.update(
      {'viewers': viewers},
    );
  }

  bool ispremuimclick = false;
  bool isexclusiveclick = false;

  VideossModel? videossModel;
  void premiumClickModel(VideossModel model) {
    videossModel = model;
    update();
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

  void singlevideoview(String videoid, String uid) async {
    var ref = FirebaseFirestore.instance.collection("videos").doc(videoid);
    var refdoc = await ref.get();
    var viewers = List<String>.from(refdoc.get('viewers') ?? []);

    int updateindex = viewers.indexWhere((element) => element == uid);
    if (updateindex != -1) {
      viewers[updateindex] = uid;
      update();
    } else {
      viewers.add(uid);
    }

    await ref.update(
      {'viewers': viewers},
    );
  }
}
