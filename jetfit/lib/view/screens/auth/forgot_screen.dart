import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/utilis/theme_data.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jetfit/view/screens/auth/forgot_controller.dart';

class ForgotAppScreen extends StatefulWidget {
  const ForgotAppScreen({super.key});

  @override
  State<ForgotAppScreen> createState() => _ForgotAppScreenState();
}

class _ForgotAppScreenState extends State<ForgotAppScreen> {
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
      body: OrientationBuilder(builder: (context, orientation) {
        return GetBuilder<ForgotController>(initState: (state) {
          Get.put(ForgotController());
          ForgotController.my.emailcontroller.clear();
        }, builder: (value) {
          return Form(
            key: formKey,
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  child: orientation == Orientation.portrait
                      ? Column(
                          children: [
                            SizedBox(
                              height: height * 0.15,
                            ),
                            // welcomee text
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.055,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.1,
                            ),
                            Text(
                              "Password reset sent to your email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                            // email field with validation
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your E-mail';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.06,
                            ),
                            // passeword field with validation
                            // login button
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  value.forgot(context);
                                } else {
                                  showtoast("invalid");
                                }
                              },
                              child: Container(
                                  height: height * 0.06,
                                  width: width * 0.8,
                                  decoration: BoxDecoration(
                                      color: MyThemeData.whitecolor,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Center(
                                    child: Text(
                                      "Forgot",
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
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: height * 0.15,
                            ),
                            // welcomee text
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Text(
                              "Password reset sent to your email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.018,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.10,
                            ),
                            // email field with validation
                            Container(
                              height: height * 0.12,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.25,
                                ),
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
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 15),
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
                                        fontSize: width * 0.022,
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your E-mail';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.1,
                            ),
                            // passeword field with validation
                            // login button
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  value.forgot(context);
                                } else {
                                  showtoast("invalid");
                                }
                              },
                              child: Container(
                                  height: height * 0.09,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                      color: MyThemeData.whitecolor,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Center(
                                    child: Text(
                                      "Forgot",
                                      style: TextStyle(
                                          color: MyThemeData.background,
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.025),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                          ],
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
        });
      }),
    );
  }
}
