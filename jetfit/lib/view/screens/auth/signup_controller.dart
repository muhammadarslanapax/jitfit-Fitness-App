import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/auth/login_screen.dart';

import '../../../web_view/auth/signup_screen/signup.dart';

class SignUpController extends GetxController {
  static SignUpController get my => Get.find();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool password = false;
  bool isLoading = true;
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  String errorMessage = '';

  void hidepassword() {
    password = !password;
    update();
  }

  Future signup(BuildContext context) async {
    try {
      isLoading = true;
      update();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      if (userCredential.user != null) {
        // getToken();
        showtoast("Successfully Signup");

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginAppScreen()));
        //  print('we' + id.toString());
        postdatatoDB(userCredential.user!.uid);
        isLoading = false;
        update();
      }
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

      showtoast(errorMessage);
      isLoading = false;
      update();
    }
  }

// post datatoDB
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void postdatatoDB(String id) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    UserModel model = UserModel(
        createdAt: time,
        isOnline: false,
        lastActive: time,
        tokan: '',
        email: emailcontroller.text,
        password: passwordcontroller.text,
        name: namecontroller.text,
        id: id,
        imageURL: '',
        role: 'free user',
        status: "user");
    await firebaseFirestore.collection('User').doc(id).set(model.toMap());
  }
}
