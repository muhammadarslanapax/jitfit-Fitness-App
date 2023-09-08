import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/web_view/auth/login_screen/login.dart';
import 'package:jetfit/web_view/auth/responsive.dart';
import 'package:jetfit/web_view/auth/signup_screen/component/signup_back_img.dart';
import 'package:jetfit/web_view/auth/upper_components/alreadyhave_account.dart';
import 'package:jetfit/web_view/auth/upper_components/background.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController passcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();

bool isloading = false;
String? errorMessage;
var width;
final FirebaseAuth auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future signup() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      if (userCredential.user != null) {
        // getToken();

        Fluttertoast.showToast(
          msg: "Successfully Signup",
          backgroundColor: MyThemeData.tertiary20,
          fontSize: 16.0,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_LONG,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
        //  print('we' + id.toString());
        postdatatoDB(userCredential.user!.uid);
        setState(() {
          isloading = false;
        });
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
      Fluttertoast.showToast(
        msg: errorMessage!,
        backgroundColor: Colors.red,
        fontSize: 16.0,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
      setState(() {
        isloading = false;
      });
    }
  }

// post datatoDB
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void postdatatoDB(String id) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    AdminwebModel model = AdminwebModel(
        createdAt: time,
        isOnline: false,
        lastActive: time,
        tokan: '',
        email: emailcontroller.text,
        password: passcontroller.text,
        name: namecontroller.text,
        id: id,
        status: "admin");
    await firebaseFirestore.collection('Admin').doc(id).set(model.toMap());
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
    var height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Background(
          child: SingleChildScrollView(
            child: Responsive(
              mobile: const MobileSignupScreen(),
              desktop: Row(
                children: [
                  const Expanded(
                    child: SignUpScreenTopImage(),
                  ),
                  Expanded(
                    child: Column(
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
                                  controller: namecontroller,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: MyThemeData.tertiary20,
                                  decoration: InputDecoration(
                                    hintText: "Name",
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
                                      return 'Please enter Name';
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
                                    controller: emailcontroller,
                                    textInputAction: TextInputAction.done,
                                    cursorColor: MyThemeData.tertiary20,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(
                                            defaultPadding),
                                        child: Icon(
                                          Icons.email,
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
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: passcontroller,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: MyThemeData.tertiary20,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
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
                                const SizedBox(height: defaultPadding / 2),
                                Hero(
                                  tag: "signup",
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyThemeData.tertiary20,
                                        elevation: 0),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        signup();
                                      }
                                    },
                                    child: Text(
                                      "Signup".toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                AlreadyHaveAnAccountCheck(
                                  login: false,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoginScreen();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        // SocalSignUp()
                      ],
                    ),
                  )
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

class MobileSignupScreen extends StatefulWidget {
  const MobileSignupScreen({super.key});

  @override
  State<MobileSignupScreen> createState() => _MobileSignupScreenState();
}

class _MobileSignupScreenState extends State<MobileSignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future signup() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      if (userCredential.user != null) {
        // getToken();

        Fluttertoast.showToast(
          msg: "Successfully Signup",
          backgroundColor: MyThemeData.tertiary20,
          fontSize: 16.0,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_LONG,
        );
        //  print('we' + id.toString());
        postdatatoDB(userCredential.user!.uid);
        setState(() {
          isloading = false;
        });
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
      Fluttertoast.showToast(
        msg: errorMessage!,
        backgroundColor: Colors.red,
        fontSize: 16.0,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
      setState(() {
        isloading = false;
      });
    }
  }

// post datatoDB
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void postdatatoDB(String id) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    AdminwebModel model = AdminwebModel(
        createdAt: time,
        isOnline: false,
        lastActive: time,
        tokan: '',
        email: emailcontroller.text,
        password: passcontroller.text,
        name: namecontroller.text,
        id: id,
        status: "admin");
    await firebaseFirestore.collection('Admin').doc(id).set(model.toMap());
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
    var height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SignUpScreenTopImage(),
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
                          controller: namecontroller,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: MyThemeData.tertiary20,
                          onSaved: (email) {},
                          decoration: InputDecoration(
                            hintText: "Name",
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
                              return 'Please enter Name';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: TextFormField(
                            controller: emailcontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: MyThemeData.tertiary20,
                            onSaved: (email) {},
                            decoration: InputDecoration(
                              hintText: "E-mail",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Icon(
                                  Icons.email,
                                  color: MyThemeData.tertiary20,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your E-mail';
                              }
                              return null;
                            },
                          ),
                        ),
                        TextFormField(
                          controller: passcontroller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        const SizedBox(height: defaultPadding / 2),
                        Hero(
                          tag: "signup",
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyThemeData.tertiary20,
                                elevation: 0),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                signup();
                              }
                            },
                            child: Text(
                              "Signup".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            // const SocalSignUp()
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
