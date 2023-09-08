import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/auth/forgot_screen.dart';
import 'package:jetfit/view/screens/auth/login_controller.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jetfit/view/screens/auth/signup_screen.dart';

class LoginAppScreen extends StatefulWidget {
  const LoginAppScreen({super.key});

  @override
  State<LoginAppScreen> createState() => _LoginAppScreenState();
}

class _LoginAppScreenState extends State<LoginAppScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyThemeData.surface,
      // putting provider
      body: OrientationBuilder(builder:(context, orientation) {
        return GetBuilder<LoginController>(initState: (state) {
          Get.put(LoginController());
          LoginController.my.emailcontroller.clear();
          LoginController.my.passwordcontroller.clear();
        }, builder: (value) {
          return orientation == Orientation.portrait
              ?portrait(value)
              :landscape(value);
        });

      }, )
    );
  }

  Widget portrait(value){
    return Form(
      key: formKey,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.15,
                  ),
                  // welcomee text
                  Text(
                    "Hi, Welcome Back! 👋",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  // email field with validation
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Center(
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.033,
                        ),
                        autofillHints: const [AutofillHints.email],
                        onEditingComplete: () =>
                            TextInput.finishAutofillContext(),
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        controller: value.emailcontroller,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(
                              20.0, 10.0, 20.0, 10.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: MyThemeData.background,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.red, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'example@gmail.com',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: width * 0.033,
                          ),
                        ),
                        validator: (String? v) {
                          if (v!.isEmpty) {
                            return 'Please enter your E-mail';
                          }
                          if (!value.emailRegex.hasMatch(v)) {
                            return 'Please enter valid Email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // passeword field with validation
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Center(
                      child: SizedBox(
                        width: width * 0.85,
                        child: Center(
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.033,
                            ),
                            autofillHints: const [AutofillHints.password],
                            onEditingComplete: () =>
                                TextInput.finishAutofillContext(),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: value.passwordcontroller,
                            onChanged: (value) {},
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 10.0),
                              filled: true,
                              fillColor: MyThemeData.background,
                              border: InputBorder.none,
                              hintText: 'password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: width * 0.033,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  value.password
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                  size: width * 0.045,
                                ),
                                onPressed: () {
                                  value.hidepassword();
                                },
                              ),
                            ),
                            obscureText: value.password,
                            obscuringCharacter: '*',
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter Password';
                              } else {
                                if (value.length < 6) {
                                  return ("Password Must be more than 5 characters");
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotAppScreen(),
                          ));
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  // login button
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        value.signinapp(context);
                      } else {
                        showtoast("invalid");
                      }
                    },
                    child: Container(
                        height: 40,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            color: MyThemeData.whitecolor,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: MyThemeData.background,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.035),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  // or with
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.white,
                        height: height * 0.001,
                        width: width * 0.3,
                      ),
                      Text(
                        "Or With",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.035,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: height * 0.001,
                        width: width * 0.3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // diffrent auth buttons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.19,
                          decoration: BoxDecoration(
                              color: MyThemeData.background,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              )),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  value.signInWithGoogle(context);
                                },
                                child: const Image(
                                    image:
                                    AssetImage("images/google.png"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.035,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SignupAppScreen(),
                              ));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          value.isLoading == true
              ? Container(
            height: height,
            width: width,
            color: Colors.white.withOpacity(0.1),
            child: const Center(
              child: SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          )
              : const SizedBox()
        ],
      ),
    );
  }
  Widget landscape(value){
    return Form(
      key: formKey,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  // welcomee text
                  Text(
                    "Hi, Welcome Back! 👋",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  // email field with validation
                  Container(
                    height: height*0.1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.25),
                      child: Center(
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.033,
                          ),
                          autofillHints: const [AutofillHints.email],
                          onEditingComplete: () =>
                              TextInput.finishAutofillContext(),
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          controller: value.emailcontroller,
                          autofocus: false,
                          decoration: InputDecoration(

                            border: InputBorder.none,
                            filled: true,
                            fillColor: MyThemeData.background,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText: 'example@gmail.com',
                            hintStyle: TextStyle(

                              color: Colors.grey,
                              fontSize: width * 0.020,

                            ),
                          ),
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Please enter your E-mail';
                            }
                            if (!value.emailRegex.hasMatch(v)) {
                              return 'Please enter valid Email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // passeword field with validation
                  Container(
                    height: height*0.1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.25),
                      child: Center(
                        child: SizedBox(
                          width: width * 0.85,
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.033,
                              ),
                              autofillHints: const [AutofillHints.password],
                              onEditingComplete: () =>
                                  TextInput.finishAutofillContext(),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              controller: value.passwordcontroller,
                              onChanged: (value) {},
                              autofocus: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: MyThemeData.background,
                                border: InputBorder.none,
                                hintText: 'password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.022,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    value.password
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                    size: width * 0.028,
                                  ),
                                  onPressed: () {
                                    value.hidepassword();
                                  },
                                ),
                              ),
                              obscureText: value.password,
                              obscuringCharacter: '*',
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
                                } else {
                                  if (value.length < 6) {
                                    return ("Password Must be more than 5 characters");
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotAppScreen(),
                          ));
                    },
                    child: Container(
                      width: width*0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.015,
                            ),
                          ),
                        ],
                      ),
                    )
                  ),

                  // login button
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        value.signinapp(context);
                      } else {
                        showtoast("invalid");
                      }
                    },
                    child: Container(
                        height: 27 ,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            color: MyThemeData.whitecolor,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: MyThemeData.background,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.025),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.045,
                  ),
                  // or with
                  Container(
                    width: width*0.65,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.white,
                          height: height * 0.001,
                          width: width * 0.1,
                        ),
                        Text(
                          "Or With",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.020,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: height * 0.001,
                          width: width * 0.1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // diffrent auth buttons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              color: MyThemeData.background,
                              borderRadius: BorderRadius.circular(8),
                              ),
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  value.signInWithGoogle(context);
                                },
                                child: const Image(
                                    image:
                                    AssetImage("images/google.png"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.010,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.025,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SignupAppScreen(),
                              ));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.026,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          value.isLoading == true
              ? Container(
            height: height,
            width: width,
            color: Colors.white.withOpacity(0.1),
            child: const Center(
              child: SpinKitCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          )
              : const SizedBox()
        ],
     ),
);}
}
