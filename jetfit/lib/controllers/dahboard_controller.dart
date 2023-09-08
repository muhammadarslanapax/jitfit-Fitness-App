import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/instructor_mdel.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/models/add_category.dart';

import '../web_view/home_screen/dashboard_screen/dashboard_controller.dart';

class DashBoardController extends GetxController {
  static DashBoardController get my => Get.find();
  bool isIconclick = false;
  int index = 0;
  Future<List<VideossModel>> getVideosFromFirebase() async {
    final QuerySnapshot videoDocs =
        await FirebaseFirestore.instance.collection('videos').get();

    final videoList = videoDocs.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final viewers = data['viewers'] as List<dynamic>?;

      final viewersList = viewers?.map((viewer) => viewer.toString()).toList();

      return VideossModel(
        price: data['price'],
        videoURL: data['videoURL'],
        videotype: data['videotype'],
        videoID: data['videoID'],
        catagorytpe: data['catagorytpe'],
        videoName: data['videoName'],
        videoDescription: data['videoDescription'],
        duration: data['duration'],
        dificulty: data['dificulty'],
        classType: data['classType'],
        instructor: data['instructor'],
        videoLanguage: data['videoLanguage'],
        viewers: viewersList,
      );
    }).toList();

    videoList.sort(
        (a, b) => (b.viewers?.length ?? 0).compareTo(a.viewers?.length ?? 0));
    return videoList;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future signin(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = auth.currentUser;
    Staticdata.uid = user!.uid;
  }

  Future getusermodel(
    String uid,
  ) async {
    firebaseFirestore.collection("User").doc(uid).get().then((value) {
      if (value.data() == null) {
        showtoast("Invalid Signin !");
      } else {
        Staticdata.userModel = UserModel.fromMap(value.data()!);

        if (Staticdata.userModel!.role == "free user") {
          Staticdata.ispremium = false;
        } else {
          Staticdata.ispremium = true;
        }
        final CollectionReference subscriptionsCollection =
            FirebaseFirestore.instance.collection('subscriptions');

        try {
          Timestamp currentTime = Timestamp.now();

          subscriptionsCollection
              .where('userId', isEqualTo: uid)
              .where('activity', isEqualTo: "activate")
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              value.docs.forEach((element) {
                Timestamp subscriptionEndTime = element['subscriptionEndTime'];
                if (subscriptionEndTime
                    .toDate()
                    .isBefore(currentTime.toDate())) {
                  print("Subscription has expired. Updating...");
                  element.reference
                      .update({'activity': 'deactivate'}).then((_) {
                    print("Updated 'activity' to 'deactivate'");
                  }).catchError((error) {
                    print("Error updating 'activity': $error");
                  });
                }
              });
            } else {
              print("No active subscriptions found for user $uid");
            }
          });
        } catch (e) {
          print('Error checking and updating subscription status: $e');
        }
      }

      // if (Staticdata.uid != null) {
      // if (value.data()!["password"] == "google") {
      // } else {
      //   DashBoardController.my
      //       .signin(value.data()!["email"], value.data()!["password"]);

      // FirebaseAuth auth = FirebaseAuth.instance;

      SystemChannels.lifecycle.setMessageHandler((message) {
        // log('Message: $message');

        if (Staticdata.uid != null) {
          if (message.toString().contains('resume')) {
            DashBoardController.my.updateActiveStatus(true);
          }
          if (message.toString().contains('pause')) {
            DashBoardController.my.updateActiveStatus(false);
          }
        }

        return Future.value(message);
      });

      print("qfelfhowiehfqowih ${Staticdata.userModel}");
    });
  }

  List<InstructorModel> instructormodellist = [];

  Future<List<String>> getinstructorfromdb() async {
    List<String> list = [];

    instructormodellist.clear();

    await FirebaseFirestore.instance
        .collection("instructors")
        .get()
        .then((value) {
      for (var element in value.docs) {
        InstructorModel model = InstructorModel.fromMap(element.data());
        instructormodellist.add(model);
      }

      for (var n in instructormodellist) {
        list.add(n.name!);
      }
    });
    return list;
  }

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  static Future<String> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        Staticdata.userModel!.tokan = t;
        log('Push Token: $t');
      }
    });
    return Staticdata.userModel!.tokan!;
  }

  Future<void> updateActiveStatus(
    bool isOnline,
  ) async {
    firebaseFirestore.collection('User').doc(Staticdata.uid).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString(),
      'tokan': Staticdata.userModel!.tokan,
    });
  }

  Future<void> updattokan(String tokan) async {
    firebaseFirestore.collection('User').doc(Staticdata.uid).update({
      'tokan': tokan,
    });
  }

  Future<void> getSelfInfo() async {
    await firebaseFirestore
        .collection('User')
        .doc(Staticdata.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        String token = await getFirebaseMessagingToken();
        updateActiveStatus(true);
        updattokan(token);
      }
    });
  }
}
