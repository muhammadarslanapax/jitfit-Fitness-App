import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/paypal/subscription/subscription_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../web_view/auth/login_screen/login.dart';

class LoginController extends GetxController {
  static LoginController get my => Get.find();
  bool isLoading = false;

  User? loginUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool password = false;

  void hidepassword() {
    password = !password;
    update();
  }

  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  void signinapp(BuildContext context) async {
    isLoading = true;
    update();
    UserCredential userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);

      Staticdata.uid = userCredential.user!.uid;
      if (userCredential.user != null) {
        print(userCredential.user!.uid);
        firebaseFirestore
            .collection("User")
            .doc(Staticdata.uid)
            .get()
            .then((value) {
          update();
          if (value.data() == null) {
            showtoast("Invalid Signin !");
            isLoading = false;
            update();
          } else {
            Staticdata.userModel = UserModel.fromMap(value.data()!);
            String status = Staticdata.userModel!.status!;
            if (status == "user") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubscriptionSCreen()));
              addloginDataToSf();
            } else {
              showtoast("Invalid Signin !");
            }
          }
        });
        isLoading = false;
        update();
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
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
          errorMessage = "An undefined Error happened.";
      }
      showtoast(errorMessage!);

      isLoading = false;
      update();
    }
    update();
  }

  static Future<bool> userExists(String id) async {
    return (await firebaseFirestore.collection('User').doc(id).get()).exists;
  }

  Future<User> signInWithGoogle(context) async {
    isLoading = true;
    update();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    try {
      UserCredential authResult = await auth.signInWithCredential(credential);
      loginUser = authResult.user;
      if (loginUser != null) {
        final time = DateTime.now().millisecondsSinceEpoch.toString();
        Staticdata.uid = loginUser!.uid;
        update();
        UserModel model = UserModel(
            tokan: '',
            createdAt: time,
            isOnline: false,
            lastActive: time,
            email: loginUser!.email,
            password: "12345",
            name: loginUser!.displayName,
            id: loginUser!.uid,
            imageURL: loginUser!.photoURL,
            role: 'free user',
            status: "user");

        if ((await userExists(loginUser!.uid))) {
          Staticdata.userModel = model;
          showtoast("Sucess sign in");
          addloginDataToSf();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SubscriptionSCreen()));
        } else {
          await firebaseFirestore
              .collection('User')
              .doc(loginUser!.uid)
              .set(model.toMap());
          Staticdata.userModel = model;
          showtoast("Sucess sign up");
          addloginDataToSf();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SubscriptionSCreen()));
        }
      }
      isLoading = false;
      update();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Fluttertoast.showToast(
          msg: "account-exists-with-different-credential",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(
          msg: "invalid-credential",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      isLoading = false;
      update();
    }
    return loginUser!;
  }

  void addloginDataToSf() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', Staticdata.uid!);
  }
}
