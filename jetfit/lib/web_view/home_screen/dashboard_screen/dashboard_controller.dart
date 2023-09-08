// // ignore_for_file: file_names, avoid_print, unnecessary_brace_in_string_interps, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jetfit/models/instructor_mdel.dart';
import 'package:jetfit/models/add_category.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();
  final FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
  late String student = '', admin = '', course = '';
  RxMap<String, double> dataMap = RxMap<String, double>();
  bool isAvgDataInitialized = false;
  List<String> premiumDocs = [];
  List<String> publicDocs = [];
  List<String> exclusiveDocs = [];
  List<PlayListModel> premiumDocsList = [];
  List<PlayListModel> publicDocsList = [];
  List<PlayListModel> exclusiveDocsList = [];

  List<String> WorkoutDocs = [];
  List<String> ChallengesDocs = [];
  List<String> RoutinesDocs = [];
  List<String> SeriesDocs = [];
  List<PlayListModel> WorkoutDocsList = [];
  List<PlayListModel> ChallengesDocsList = [];
  List<PlayListModel> RoutinesDocsList = [];
  List<PlayListModel> SeriesDocsList = [];
  List<String> instructorlist = [
    'John',
    "Jim",
    'Jet',
    'Junia',
    'Java',
  ];

  List<PlayListModel> trainingList = [];

  void postinstructiorlist() async {
    await firebaseFirestore.collection('instructors').get().then((value) {
      if (value.docs.isEmpty) {
        for (int i = 0; i <= instructorlist.length; i++) {
          String id = const Uuid().v4();
          InstructorModel model = InstructorModel(
            id: id,
            name: instructorlist[i],
          );
          firebaseFirestore
              .collection("instructors")
              .doc(id)
              .set(model.toMap());
        }
      }
    });

    update();
  }

  void getcataories() async {
    await firebasefirestore
        .collection("category")
        .where('playlistType', isEqualTo: 'Premium')
        .get()
        .then((value) {
      premiumDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        premiumDocs.add(model.categoryID!);
      }
    });
    await firebasefirestore
        .collection("category")
        .where('playlistType', isEqualTo: 'Public')
        .get()
        .then((value) {
      publicDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        publicDocs.add(model.categoryID!);
      }
    });
    await firebasefirestore
        .collection("category")
        .where('playlistType', isEqualTo: 'Exclusive')
        .get()
        .then((value) {
      exclusiveDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        exclusiveDocs.add(model.categoryID!);
      }
    });

    ///////////////////////////////////////////////////////////
    ///////////////////////////
    premiumDocsList.clear();
    for (var u in premiumDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          premiumDocsList.add(model);
        }
      });
    }
    exclusiveDocsList.clear();
    for (var u in exclusiveDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          exclusiveDocsList.add(model);
        }
      });
    }
    publicDocsList.clear();
    for (var u in publicDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          publicDocsList.add(model);
        }
      });
    }

    await firebasefirestore
        .collection("category")
        .where('categoryType', isEqualTo: 'Workout')
        .get()
        .then((value) {
      WorkoutDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        WorkoutDocs.add(model.categoryID!);
      }
    });

    await firebasefirestore
        .collection("category")
        .where('categoryType', isEqualTo: 'Challenges')
        .get()
        .then((value) {
      ChallengesDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        ChallengesDocs.add(model.categoryID!);
      }
    });
    await firebasefirestore
        .collection("category")
        .where('categoryType', isEqualTo: 'Routines')
        .get()
        .then((value) {
      RoutinesDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        RoutinesDocs.add(model.categoryID!);
      }
    });

    await firebasefirestore
        .collection("category")
        .where('categoryType', isEqualTo: 'Series')
        .get()
        .then((value) {
      SeriesDocs.clear();
      for (var element in value.docs) {
        CategoryModel model = CategoryModel.fromMap(element.data());
        SeriesDocs.add(model.categoryID!);
      }
    });

    WorkoutDocsList.clear();
    for (var u in WorkoutDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          WorkoutDocsList.add(model);
        }
      });
    }
    ChallengesDocsList.clear();
    for (var u in ChallengesDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          ChallengesDocsList.add(model);
        }
      });
    }
    RoutinesDocsList.clear();
    for (var u in RoutinesDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          RoutinesDocsList.add(model);
        }
      });
    }
    SeriesDocsList.clear();
    for (var u in SeriesDocs) {
      await firebasefirestore
          .collection("category")
          .doc(u)
          .collection("playlist")
          .get()
          .then((value) {
        for (var element in value.docs) {
          PlayListModel model = PlayListModel.fromMap(element.data());
          SeriesDocsList.add(model);
        }
      });
    }
    print("olednoein ${premiumDocsList.length}");
    print("olednoein ${publicDocsList.length}");
    print("olednoein ${exclusiveDocsList.length}");

    trainingList.clear();
    trainingList.addAll(WorkoutDocsList);
    trainingList.addAll(ChallengesDocsList);
    trainingList.addAll(RoutinesDocsList);
    trainingList.addAll(SeriesDocsList);
    trainingList.addAll(premiumDocsList);
    trainingList.addAll(exclusiveDocsList);
    trainingList.addAll(premiumDocsList);
    print("trainingList ${trainingList.length}");
    generatepiechart();
    update();
  }

  List<String> menuItems = [
    "Workout",
    "Challenges",
    "Routines",
    "Series",
  ];

  void generatepiechart() async {
    dataMap[menuItems[0]] = WorkoutDocsList.length.toDouble();
    dataMap[menuItems[1]] = ChallengesDocsList.length.toDouble();
    dataMap[menuItems[2]] = RoutinesDocsList.length.toDouble();
    dataMap[menuItems[3]] = SeriesDocsList.length.toDouble();
  }
}
