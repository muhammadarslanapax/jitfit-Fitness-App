import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/utilis.dart';

import '../../../web_view/auth/login_screen/login.dart';

class ForgotController extends GetxController {
  static ForgotController get my => Get.find();

  bool isLoading = false;

  TextEditingController emailcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void forgot(BuildContext context) async {
    isLoading = true;
    update();

    try {
      await _auth.sendPasswordResetEmail(
        email: emailcontroller.text,
      );
      isLoading = false;
      update();
      // });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Invalid Email!";
          break;
        case "wrong-password":
          errorMessage = "Wrong Password";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "No internet connection?";
      }

      showtoast(errorMessage!);
      isLoading = false;
      update();
    }
  }
}
