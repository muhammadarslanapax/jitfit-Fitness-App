import 'package:flutter/material.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/training_controller.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/chat_screen/list.dart';
import 'package:jetfit/view/screens/favourite/favourite_screen.dart';
import 'package:jetfit/view/screens/home01/home_01.dart';
import 'package:jetfit/view/screens/search/search.dart';
import 'package:jetfit/view/screens/subtitles.dart';
import 'package:jetfit/view/screens/trainigng_screen.dart';
import 'package:get/get.dart';
import 'package:jetfit/web_view/home_screen/dashboard_screen/dashboard_controller.dart';

import 'setting_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var height, width;

  @override
  void initState() {
    Get.put(DashBoardController());
    Get.put(DashboardController());
    DashboardController.to.getcataories();
    print("staticdata ${Staticdata.uid}");
    if (Staticdata.uid == null) {
    } else {
      DashBoardController.my.getusermodel(Staticdata.uid!);
      DashBoardController.my.getSelfInfo();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<DashBoardController>(initState: (state) {
        Get.put(DashBoardController());
        Get.put(TrainingController());
        DashBoardController.my.index = 1;
        DashBoardController.my.getVideosFromFirebase();
        Future.delayed(Duration.zero, () async {
          TrainingController.to.instructorMenuItems =
              await DashBoardController.my.getinstructorfromdb();
        });
      }, builder: (obj) {
        return OrientationBuilder(builder: (context, oreentation) {
          return Stack(
            children: [
              obj.index == 0
                  ? const VideoSearchScreen()
                  : obj.index == 1
                      ? const Home01Screen()
                      :
                      //2
                      obj.index == 2
                          ? const TrainingScreen()
                          :
                          //3
                          obj.index == 3
                              ? const FavouriteScreen()
                              :
                              //4
                              obj.index == 4
                                  ? const SettingScreen()
                                  :
                                  //5
                                  // obj.index == 4
                                  //     ? const Home02Screen()
                                  //     :
                                  //6
                                  // obj.index == 6
                                  //     ? const ChallengeTabsScreen()
                                  //     :
                                  //7
                                  // obj.index == 7
                                  //     ? ChallengeScreen()
                                  //     :

                                  // obj.index == 8
                                  //     ? RemoveFav()
                                  //     :

                                  obj.index == 9
                                      ? const SubtitlesScreen()
                                      : const SizedBox(),
              oreentation == Orientation.landscape
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: height,
                        width: width * 0.12,
                        color: MyThemeData.background,
                        child: Center(
                          child: SizedBox(
                            height: height * 0.7,
                            width: width * 0.09,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 0;
                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 0
                                      ? Container(
                                          height: height * 0.11,
                                          width: width * 0.07,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/search.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/search.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    obj.index = 1;

                                    obj.update();
                                  },
                                  child: obj.index == 1
                                      ? Container(
                                          height: height * 0.11,
                                          width: width * 0.07,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/home.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/home.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 2;

                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 2
                                      ? Container(
                                          height: height * 0.11,
                                          width: width * 0.07,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/gymicon.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/gymicon.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 3;

                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 3
                                      ? Container(
                                          height: height * 0.11,
                                          width: width * 0.07,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/heart.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/heart.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 4;

                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 4
                                      ? Container(
                                          height: height * 0.11,
                                          width: width * 0.07,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/settings.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/settings.png"),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: height * 0.08,
                        width: width,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white24, // Upper border color
                              width: 1, // Upper border width
                            ),
                          ),
                          color: MyThemeData.background,
                        ),
                        child: Center(
                          child: SizedBox(
                            height: height * 0.1,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 0;

                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 0
                                      ? Container(
                                          height: height * 0.05,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/search.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/search.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    obj.index = 1;

                                    obj.update();
                                  },
                                  child: obj.index == 1
                                      ? Container(
                                          height: height * 0.05,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/home.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/home.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 2;

                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 2
                                      ? Container(
                                          height: height * 0.05,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/gymicon.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/gymicon.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 3;

                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 3
                                      ? Container(
                                          height: height * 0.05,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/heart.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/heart.png"),
                                        ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (Staticdata.uid == null) {
                                      showtoast("Open your new Profile");
                                    } else {
                                      obj.index = 4;
                                      obj.update();
                                    }
                                  },
                                  child: obj.index == 4
                                      ? Container(
                                          height: height * 0.05,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            color: MyThemeData.tertiary80
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Image(
                                            image: AssetImage(
                                                "images/home/settings.png"),
                                          ),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              "images/home/settings.png"),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              obj.index == 4
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 70, right: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Card(
                          elevation: 5,
                          shadowColor: MyThemeData.onSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: FloatingActionButton(
                            backgroundColor: MyThemeData.background,
                            child: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Inbox(),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          );
        });
      }),
    );
  }
}
