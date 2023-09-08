import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/web_view/auth/forgot_screen/forgot.dart';
import 'package:jetfit/web_view/auth/login_screen/component/login_screen_top_img.dart';
import 'package:jetfit/web_view/auth/responsive.dart';
import 'package:jetfit/web_view/auth/signup_screen/signup.dart';
import 'package:jetfit/web_view/auth/upper_components/alreadyhave_account.dart';
import 'package:jetfit/web_view/auth/upper_components/background.dart';
import 'package:jetfit/web_view/home_screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void signin() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      var user = _auth.currentUser;
      Staticdata.uid = user!.uid;
      await firebaseFirestore
          .collection("Admin")
          .doc(Staticdata.uid)
          .get()
          .then((value) {
        setState(() {
          if (value.data() == null) {
            showtoast("Invalid Signin !");
            addloginDataToSf();
            setState(() {
              isloading = false;
            });
          } else {
            AdminwebModel adminmodel = AdminwebModel.fromMap(value.data()!);
            String status = adminmodel.status!;
            if (status == "admin") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminHome()));
              showtoast("succesfully signin");

              addloginDataToSf();
              setState(() {
                isloading = false;
              });
            }
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "Invalid Email!";
          break;
        case "wrong-password":
          errorMessage = "Wrong Password";
          break;
        case "user-not-found":
          errorMessage = "User with this h email doesn't exist.";
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
          errorMessage = "Something went wrong";
      }

      showtoast(errorMessage!);
      setState(() {
        isloading = false;
      });
    }
  }

  void addloginDataToSf() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', Staticdata.uid!);
  }

  @override
  void initState() {
    emailcontroller.clear();
    passcontroller.clear();
    namecontroller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(
          child: SingleChildScrollView(
            child: Responsive(
              mobile: const MobileLoginScreen(),
              desktop: Row(
                children: [
                  const Expanded(
                    child: LoginScreenTopImage(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: emailcontroller,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: MyThemeData.tertiary20,
                                  onSaved: (email) {},
                                  decoration: InputDecoration(
                                    hintText: "E-mail",
                                    prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
                                      child: Icon(
                                        Icons.person,
                                        color: MyThemeData.tertiary20,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter E-mail';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: passcontroller,
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    cursorColor: MyThemeData.tertiary20,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Password';
                                      } else if (value.length < 6) {
                                        return 'Password must be 6 character long';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Your password",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(
                                            defaultPadding),
                                        child: Icon(
                                          Icons.lock,
                                          color: MyThemeData.tertiary20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                Hero(
                                  tag: "login_btn",
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyThemeData.tertiary20,
                                        elevation: 0),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        signin();
                                      }
                                    },
                                    child: Text(
                                      "Login".toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                AlreadyHaveAnAccountCheck(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SignUpScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: defaultPadding),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const ForgotScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Forgot".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyThemeData.tertiary20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isloading == true
            ? Container(
                height: height,
                width: width,
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: SpinkitFlutter.spinkit,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
var height, width;
bool isloading = false;

String? errorMessage;
final FirebaseAuth _auth = FirebaseAuth.instance;

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void signin() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      var user = _auth.currentUser;
      Staticdata.uid = user!.uid;
      await firebaseFirestore
          .collection("Admin")
          .doc(Staticdata.uid)
          .get()
          .then((value) {
        setState(() {
          if (value.data() == null) {
            showtoast("Invalid Signin !");

            addloginDataToSf();
            setState(() {
              isloading = false;
            });
          } else {
            AdminwebModel adminmodel = AdminwebModel.fromMap(value.data()!);
            String status = adminmodel.status!;
            if (status == "admin") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AdminHome()));
              showtoast("succesfully signin");

              addloginDataToSf();
              setState(() {
                isloading = false;
              });
            }
          }
        });
      });
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
          errorMessage = "Something went wrong";
      }

      showtoast(errorMessage!);
      setState(() {
        isloading = false;
      });
    }
  }

  void addloginDataToSf() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', Staticdata.uid!);
  }

  @override
  void initState() {
    emailcontroller.clear();
    passcontroller.clear();
    namecontroller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LoginScreenTopImage(),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: MyThemeData.tertiary20,
                          onSaved: (email) {},
                          decoration: InputDecoration(
                            hintText: "E-mail",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Icon(
                                Icons.person,
                                color: MyThemeData.tertiary20,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter E-mail';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: passcontroller,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            cursorColor: MyThemeData.tertiary20,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Icon(
                                  Icons.lock,
                                  color: MyThemeData.tertiary20,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              } else if (value.length < 6) {
                                return 'Password must be 6 character long';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Hero(
                          tag: "login_btn",
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyThemeData.tertiary20,
                                elevation: 0),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isloading = false;
                                });
                                signin();
                              }
                            },
                            child: Text(
                              "Login".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        AlreadyHaveAnAccountCheck(
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignUpScreen();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Forgot".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyThemeData.tertiary20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
        isloading == true
            ? Container(
                height: height,
                width: width,
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: SpinkitFlutter.spinkit,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
