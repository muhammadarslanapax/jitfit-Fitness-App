import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/web_view/auth/login_screen/login.dart';
import 'package:jetfit/web_view/auth/responsive.dart';
import 'package:jetfit/web_view/auth/upper_components/alreadyhave_account.dart';
import 'package:jetfit/web_view/auth/upper_components/background.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future forgot() async {
    try {
      await auth.sendPasswordResetEmail(email: emailcontroller.text);
      showtoast("password reset sent to mail");
      emailcontroller.clear();
      setState(() {
        isloading = false;
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
          errorMessage = "No internet connection?";
      }
      showtoast(errorMessage!);

      setState(() {
        isloading = false;
      });
    }
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
              mobile: const MobileForgotScreen(),
              desktop: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Forgot".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyThemeData.tertiary20),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: Responsive.isMobile(context)
                                  ? 1
                                  : Responsive.isTablet(context)
                                      ? 1
                                      : 8,
                              child:
                                  SvgPicture.asset("images/icons/signup.svg"),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                      ],
                    ),
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
                                const SizedBox(height: defaultPadding / 2),
                                Hero(
                                  tag: "Forgot",
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyThemeData.tertiary20,
                                        elevation: 0),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        forgot();
                                      }
                                    },
                                    child: Text(
                                      "Forgot".toUpperCase(),
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

TextEditingController emailcontroller = TextEditingController();

bool isloading = false;
String? errorMessage;
var width;
final FirebaseAuth auth = FirebaseAuth.instance;

class MobileForgotScreen extends StatefulWidget {
  const MobileForgotScreen({super.key});

  @override
  State<MobileForgotScreen> createState() => _MobileForgotScreenState();
}

class _MobileForgotScreenState extends State<MobileForgotScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future forgot() async {
    try {
      await auth.sendPasswordResetEmail(email: emailcontroller.text);
      showtoast("password reset sent to mail");
      emailcontroller.clear();
      setState(() {
        isloading = false;
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
          errorMessage = "No internet connection?";
      }
      showtoast(errorMessage!);

      setState(() {
        isloading = false;
      });
    }
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
            Column(
              children: [
                Text(
                  "Forgot".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyThemeData.tertiary20),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: Responsive.isMobile(context)
                          ? 1
                          : Responsive.isTablet(context)
                              ? 1
                              : 8,
                      child: SvgPicture.asset("images/icons/signup.svg"),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                        const SizedBox(height: defaultPadding / 2),
                        Hero(
                          tag: "forgot",
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyThemeData.tertiary20,
                                elevation: 0),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                forgot();
                              }
                            },
                            child: Text(
                              "Forgot".toUpperCase(),
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
