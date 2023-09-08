import 'package:flutter/material.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/auth/login_screen.dart';
import 'package:jetfit/view/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../web_view/auth/login_screen/login.dart';

class ProfileSelector extends StatefulWidget {
  List<UserModel> userModels = [];
  ProfileSelector({super.key, required this.userModels});

  @override
  State<ProfileSelector> createState() => _ProfileSelectorState();
}

class _ProfileSelectorState extends State<ProfileSelector> {
  double? height, width;
  void addloginDataToSf() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', Staticdata.uid!);
  }

  Future getusermodel(
    String uid,
  ) async {
    Staticdata.uid = uid;
    firebaseFirestore.collection("User").doc(uid).get().then((value) {
      if (value.data() == null) {
        showtoast("Invalid Signin !");
      } else {
        setState(() {
          Staticdata.userModel = UserModel.fromMap(value.data()!);
          Staticdata.uid = Staticdata.userModel!.id!;
          print(" Staticdata.userModel ${Staticdata.userModel}");
        });
      }
    });
  }

  @override
  void initState() {
    if (widget.userModels.length == 4) {
      widget.userModels.removeAt(0);
    }
    print("userModel ${widget.userModels}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(builder: (context, oreentation) {
        return Container(
          height: height,
          width: width,
          color: MyThemeData.surface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              oreentation == Orientation.portrait
                  ? SizedBox(
                      height: height! * 0.05,
                    )
                  : const SizedBox(),
              Text(
                "Who's working out today?",
                style: TextStyle(
                  fontSize: oreentation == Orientation.portrait
                      ? width! * 0.04
                      : width! * 0.03,
                  color: MyThemeData.whitecolor,
                ),
              ),
              SizedBox(
                height: height! * 0.1,
              ),
              SizedBox(
                  height: oreentation == Orientation.portrait
                      ? height! * 0.25
                      : height! * 0.45,
                  width: oreentation == Orientation.portrait
                      ? width
                      : width! * 0.7,
                  child: widget.userModels.isNotEmpty
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                widget.userModels.length == 1 ? 1 : 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: widget.userModels.length,
                          itemBuilder: (context, index) {
                            bool isSecondItem = index == 1;
                            Orientation currentOrientation =
                                MediaQuery.of(context).orientation;
                            double imageSize = isSecondItem
                                ? currentOrientation == Orientation.portrait
                                    ? height! *
                                        0.125 // Increased size for the image in portrait mode
                                    : width! *
                                        0.15 // Increased size for the image in landscape mode
                                : currentOrientation == Orientation.portrait
                                    ? height! * 0.08
                                    : width! *
                                        0.08; // Default size for the image in landscape mode

                            double textSize = isSecondItem
                                ? currentOrientation == Orientation.portrait
                                    ? 20.0 // Increased text size for the second item in portrait mode
                                    : 24.0 // Increased text size for the second item in landscape mode
                                : 16.0; // Default text size for other items

                            return InkWell(
                              onTap: () async {
                                await getusermodel(widget.userModels[index].id!)
                                    .then((value) {
                                  addloginDataToSf();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DashBoard(),
                                      ));
                                  showtoast(
                                      "Login as ${widget.userModels[index].name}");
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: imageSize,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: widget.userModels[index]
                                                      .imageURL ==
                                                  null ||
                                              widget.userModels[index]
                                                      .imageURL ==
                                                  ''
                                          ? const DecorationImage(
                                              image:
                                                  AssetImage("images/man.png"))
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(widget
                                                  .userModels[index].imageURL!),
                                            ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.userModels[index].name.toString(),
                                      style: TextStyle(
                                        color: MyThemeData.whitecolor,
                                        fontSize:
                                            textSize, // Apply the calculated text size
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                          'No user Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ))),
              SizedBox(
                height: height! * 0.1,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginAppScreen(),
                      ));
                },
                child: oreentation == Orientation.portrait
                    ? Container(
                        height: height! * 0.05,
                        width: width! * 0.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: MyThemeData.onSurfaceVarient)),
                        child: Text(
                          "sign in with a different user",
                          style: TextStyle(color: MyThemeData.onSurface),
                        ),
                      )
                    : Container(
                        height: height! * 0.1,
                        width: width! * 0.3,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: MyThemeData.onSurfaceVarient)),
                        child: Text(
                          "sign in with a different user",
                          style: TextStyle(color: MyThemeData.onSurface),
                        ),
                      ),
              )
            ],
          ),
        );
      }),
    );
  }
}
