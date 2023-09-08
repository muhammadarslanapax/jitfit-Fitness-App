import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/web_view/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:jetfit/models/add_category.dart';

class TrainingController extends GetxController {
  static TrainingController get to => Get.find();

  int index = 0;
  final categories = [
    'Workout',
    'Series',
    'Challenges',
    'Routines',
  ];
  bool isFilterOpen = false;

  bool isclick = false;
  bool isSortOpen = false;
  String filter = "";
  List<String> instructorMenuItems = [];
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

  Future<List<PlayListModel>> fetchplaylistmodel() async {
    List<PlayListModel> l = [];
    l.clear();
    l = DashboardController.to.trainingList;

    return l;
  }

  void addtofavourite(PlayListModel playListMode) async {
    await firebaseFirestore
        .collection("Favourite")
        .doc(Staticdata.uid)
        .collection("UserFavourites")
        .doc(playListMode.videoID)
        .set(playListModel!.toMap());
    showtoast("${playListModel!.videoName} added to favourite");
    isclick = false;
    update();
  }

  //   Stream<QuerySnapshot> getFilteredVideosStream() {
  //   // Construct a query based on selected filters
  //   Query query = FirebaseFirestore.instance.collection('videos');

  //   if (selectedCategory != null) {
  //     query = query.where('catagorytype', isEqualTo: selectedCategory);
  //   }

  //   if (selectedDifficulty != null) {
  //     query = query.where('dificulty', isEqualTo: selectedDifficulty);
  //   }

  //   if (selectedClassType != null) {
  //     query = query.where('classType', isEqualTo: selectedClassType);
  //   }

  //   if (selectedLanguage != null) {
  //     query = query.where('videoLanguage', isEqualTo: selectedLanguage);
  //   }
  //   return query.snapshots();
  // }

  PlayListModel? playListModel;
  void videoclickModel(PlayListModel model) {
    print(" oiegu  ${Staticdata.uid}");

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
}
