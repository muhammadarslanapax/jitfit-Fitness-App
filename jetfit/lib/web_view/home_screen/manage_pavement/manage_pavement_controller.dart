import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/utilis.dart';

class ManagePavementController extends GetxController {
  static ManagePavementController get my => Get.find();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController searchusercontroller = TextEditingController();

  TextEditingController amountController = TextEditingController();
  final List<Payment> payments = [
    Payment("Payment #1", 100),
    Payment("Payment #2", 200),
    Payment("Payment #3", 150),
  ];
  String getFormattedTime(BuildContext context, DateTime time) {
    return TimeOfDay.fromDateTime(time).format(context);
  }

  UserModel? userModel;
  void updateuser(String userID) async {
    update();
    final CollectionReference subscriptionsCollection =
        FirebaseFirestore.instance.collection('subscriptions');
    if (selectedvalue == "free user") {
      try {
        subscriptionsCollection
            .where('userId', isEqualTo: userID)
            .where('activity', isEqualTo: "activate")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            value.docs.forEach((element) {
              element.reference.update({'activity': 'deactivate'}).then((_) {
                print("Updated 'activity' to 'deactivate'");
              }).catchError((error) {
                print("Error updating 'activity': $error");
              });
            });
          }
        });
      } catch (e) {
        print('Error checking and updating subscription status: $e');
      }
    }

    await firebaseFirestore.collection("User").doc(userID).update(
      {
        'role': selectedvalue,
      },
    );
    showtoast("successfully saved");
    is_edit_user_click = false;
    update();
  }

  void edituserclick(UserModel model) async {
    is_edit_user_click = true;
    userModel = model;

    selectedvalue = model.role;

    update();
  }

  void checkdailyUser(UserModel usersmodel) async {
    final CollectionReference subscriptionsCollection =
        FirebaseFirestore.instance.collection('subscriptions');

    try {
      Timestamp currentTime = Timestamp.now();
      subscriptionsCollection
          .where('userId', isEqualTo: usersmodel.id)
          .where('activity', isEqualTo: "activate")
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((element) {
            Timestamp subscriptionEndTime = element['subscriptionEndTime'];
            if (subscriptionEndTime.toDate().isBefore(currentTime.toDate())) {
              print("Subscription has expired. Updating...");
              element.reference.update({'activity': 'deactivate'}).then((_) {
                print("Updated 'activity' to 'deactivate'");

                firebaseFirestore.collection("User").doc(usersmodel.id).update(
                  {
                    'role': "free user",
                  },
                );
              }).catchError((error) {
                print("Error updating 'activity': $error");
              });
            }
          });
        } else {
          print("No active subscriptions found for user ${usersmodel.id}");
        }
      });
    } catch (e) {
      print('Error checking and updating subscription status: $e');
    }
  }

  String? selectedvalue;
  List<String> menuItems = [
    "free user",
    "premium user",
  ];
  XFile? profileImage;
  //   void pickImage(UserModel model) async {
  //   imageloading = true;
  //   update();
  //   profileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (profileImage != null) {
  //     imagebytes = await profileImage!.readAsBytes();
  //     updateprofilepicture(model);
  //   } else {
  //     imageloading = false;
  //     update();
  //   }
  // }
  String name = '';
  bool is_edit_user_click = false;
  bool is_edit_pavement_click = false;
}

class Payment {
  final String description;
  final double amount;

  Payment(this.description, this.amount);
}
