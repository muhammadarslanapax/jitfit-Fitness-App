import 'package:flutter/material.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/setting_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/widgets/app_setting_tabs.dart';
import 'package:jetfit/view/widgets/potrait_click_setting_tabs.dart';
import 'package:get/get.dart';

class SubtitlesScreen extends StatefulWidget {
  const SubtitlesScreen({super.key});

  @override
  State<SubtitlesScreen> createState() => _SubtitlesScreenState();
}

class _SubtitlesScreenState extends State<SubtitlesScreen> {
  var height, width;

  @override
  void initState() {
    Get.put(DashBoardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<SettingController>(initState: (state) {
      Get.put(SettingController());
      SettingController.my.index = 0;
      SettingController.my.ispotraitmodeclick = false;
    }, builder: (obj) {
      return OrientationBuilder(builder: (context, oreentation) {
        return Container(
          height: height,
          width: width,
          color: MyThemeData.background,
          child: oreentation == Orientation.landscape
              ? Row(
                  children: [
                    Container(
                      width: width * 0.12,
                    ),
                    Container(
                      height: height,
                      width: width * 0.42,
                      color: MyThemeData.background,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.05,
                          ),
                          Text(
                            "Subtitles",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.73,
                            width: width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  //1
                                  Container(
                                    height: height * 0.11,
                                    width: width * 0.38,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyThemeData.onBackground
                                            .withOpacity(0.4)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Text(
                                            "Subtitles",
                                            style: TextStyle(
                                                color: MyThemeData.onBackground,
                                                fontSize: width * 0.02,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              width: width!,
                                            ),
                                          ),
                                          Switch(
                                            // thumb color (round icon)
                                            activeColor:
                                                const Color(0xff005140),

                                            activeTrackColor:
                                                const Color(0xff48DDB8),
                                            inactiveThumbColor:
                                                Colors.blueGrey.shade600,
                                            inactiveTrackColor:
                                                Colors.grey.shade400,
                                            splashRadius: 50.0,
                                            // boolean variable value
                                            value: obj.subtitles,
                                            // changes the state of the switch
                                            onChanged: (value) {
                                              obj.subtitles = value;
                                              obj.update();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  //2
                                  InkWell(
                                    onTap: () {
                                      obj.index = 1;
                                      obj.update();
                                    },
                                    child: Container(
                                      height: height * 0.11,
                                      width: width * 0.38,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: obj.index == 1
                                              ? MyThemeData.onBackground
                                              : MyThemeData.onBackground
                                                  .withOpacity(0.4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            Text(
                                              "Subtitles language",
                                              style: TextStyle(
                                                  color: obj.index == 1
                                                      ? MyThemeData.background
                                                      : MyThemeData
                                                          .onBackground,
                                                  fontSize: width * 0.02,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                width: width!,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    obj.subtitlelanguage == 0
                                                        ? "English (US)"
                                                        : obj.subtitlelanguage ==
                                                                1
                                                            ? "English (UK)"
                                                            : obj.subtitlelanguage ==
                                                                    2
                                                                ? "Français"
                                                                : obj.subtitlelanguage ==
                                                                        3
                                                                    ? "Española"
                                                                    : obj.subtitlelanguage ==
                                                                            4
                                                                        ? "Deutsch"
                                                                        : '',
                                                    style: TextStyle(
                                                      color: obj.index == 1
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width * 0.02,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: obj.index == 1
                                                  ? Colors.green
                                                  : MyThemeData.onBackground,
                                              size: width * 0.02,
                                            ),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height,
                      width: width * 0.46,
                      color: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.05,
                              ),
                              Text(
                                "Subtitles language",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.03,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.73,
                                width: width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          obj.subtitlelanguage = 0;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyThemeData.onBackground
                                                  .withOpacity(0.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "English (US)",
                                                  style: TextStyle(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      fontSize: width * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                obj.subtitlelanguage == 0
                                                    ? Icon(
                                                        Icons.check,
                                                        color: MyThemeData
                                                            .onBackground,
                                                        size: width * 0.03,
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          obj.subtitlelanguage = 1;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyThemeData.onBackground
                                                  .withOpacity(0.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "English (UK)",
                                                  style: TextStyle(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      fontSize: width * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                obj.subtitlelanguage == 1
                                                    ? Icon(
                                                        Icons.check,
                                                        color: MyThemeData
                                                            .onBackground,
                                                        size: width * 0.03,
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          obj.subtitlelanguage = 2;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyThemeData.onBackground
                                                  .withOpacity(0.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "Français",
                                                  style: TextStyle(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      fontSize: width * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                obj.subtitlelanguage == 2
                                                    ? Icon(
                                                        Icons.check,
                                                        color: MyThemeData
                                                            .onBackground,
                                                        size: width * 0.03,
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          obj.subtitlelanguage = 3;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyThemeData.onBackground
                                                  .withOpacity(0.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "Española",
                                                  style: TextStyle(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      fontSize: width * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                obj.subtitlelanguage == 3
                                                    ? Icon(
                                                        Icons.check,
                                                        color: MyThemeData
                                                            .onBackground,
                                                        size: width * 0.03,
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          obj.subtitlelanguage = 4;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyThemeData.onBackground
                                                  .withOpacity(0.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "Deutsch",
                                                  style: TextStyle(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      fontSize: width * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                obj.subtitlelanguage == 4
                                                    ? Icon(
                                                        Icons.check,
                                                        color: MyThemeData
                                                            .onBackground,
                                                        size: width * 0.03,
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  width: width * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        obj.ispotraitmodeclick = false;
                        obj.update();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.07,
                            ),
                            Text(
                              "Subtitles",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.05,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: height,
                                width: width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      //1
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.4,
                                            width: width,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.03,
                                                  ),
                                                  Container(
                                                    height: height * 0.07,
                                                    width: width * 0.9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: MyThemeData
                                                            .onBackground
                                                            .withOpacity(0.4)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: width * 0.02,
                                                          ),
                                                          Text(
                                                            "Subtitles",
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .onBackground,
                                                                fontSize:
                                                                    width *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: width!,
                                                            ),
                                                          ),
                                                          Switch(
                                                            // thumb color (round icon)
                                                            activeColor:
                                                                const Color(
                                                                    0xff005140),

                                                            activeTrackColor:
                                                                const Color(
                                                                    0xff48DDB8),
                                                            inactiveThumbColor:
                                                                Colors.blueGrey
                                                                    .shade600,
                                                            inactiveTrackColor:
                                                                Colors.grey
                                                                    .shade400,
                                                            splashRadius: 50.0,
                                                            // boolean variable value
                                                            value:
                                                                obj.subtitles,
                                                            // changes the state of the switch
                                                            onChanged: (value) {
                                                              obj.subtitles =
                                                                  value;
                                                              obj.update();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.03,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      obj.ispotraitmodeclick =
                                                          true;
                                                      obj.update();
                                                    },
                                                    child: PotraitWidgetSettingTabs(
                                                        height: height,
                                                        myIndex: 0,
                                                        objindex: obj.index,
                                                        text:
                                                            "Subtitles language",
                                                        value0: "English (US)",
                                                        value1: 'English (UK)',
                                                        value2: 'Français',
                                                        value3: 'Española',
                                                        value4: 'Deutsch',
                                                        value5: '',
                                                        textconditionIndex: obj
                                                            .subtitlelanguage,
                                                        width: width),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    obj.ispotraitmodeclick
                        ? InkWell(
                            onTap: () {
                              obj.ispotraitmodeclick = false;
                              obj.update();
                            },
                            child: Container(
                              height: height,
                              width: width,
                              color: MyThemeData.background.withOpacity(0.3),
                            ),
                          )
                        : const SizedBox(),
                    obj.ispotraitmodeclick
                        ? Align(
                            alignment: Alignment.center,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 10,
                              shadowColor: MyThemeData.onSurface,
                              child: Container(
                                height: height * 0.6,
                                width: width * 0.8,
                                decoration: BoxDecoration(
                                    color: MyThemeData.surfaceVarient,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.05,
                                    ),
                                    Text(
                                      "Subtitles language",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.05,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.48,
                                      width: width,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                obj.subtitlelanguage = 0;
                                                obj.ispotraitmodeclick = false;
                                                obj.update();
                                              },
                                              child: IsClicksettingTabs(
                                                  height: height,
                                                  text: "English (US)",
                                                  myIndex: 0,
                                                  objconditionIndex:
                                                      obj.subtitlelanguage,
                                                  width: width)),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                obj.subtitlelanguage = 1;
                                                obj.ispotraitmodeclick = false;
                                                obj.update();
                                              },
                                              child: IsClicksettingTabs(
                                                  height: height,
                                                  text: "English (UK)",
                                                  myIndex: 1,
                                                  objconditionIndex:
                                                      obj.subtitlelanguage,
                                                  width: width)),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                obj.subtitlelanguage = 2;
                                                obj.ispotraitmodeclick = false;
                                                obj.update();
                                              },
                                              child: IsClicksettingTabs(
                                                  height: height,
                                                  text: "Français",
                                                  myIndex: 2,
                                                  objconditionIndex:
                                                      obj.subtitlelanguage,
                                                  width: width)),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                obj.subtitlelanguage = 3;
                                                obj.ispotraitmodeclick = false;
                                                obj.update();
                                              },
                                              child: IsClicksettingTabs(
                                                  height: height,
                                                  text: "Española",
                                                  myIndex: 3,
                                                  objconditionIndex:
                                                      obj.subtitlelanguage,
                                                  width: width)),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                obj.subtitlelanguage = 4;
                                                obj.ispotraitmodeclick = false;
                                                obj.update();
                                              },
                                              child: IsClicksettingTabs(
                                                  height: height,
                                                  text: "Deutsch",
                                                  myIndex: 4,
                                                  objconditionIndex:
                                                      obj.subtitlelanguage,
                                                  width: width)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
        );
      });
    });
  }
}
