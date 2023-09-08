import 'package:flutter/material.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/setting_controller.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/paypal/subscription/subscription_screen.dart';
import 'package:jetfit/view/screens/profile/profile_screen.dart';
import 'package:jetfit/view/widgets/app_setting_tabs.dart';
import 'package:jetfit/view/widgets/potrait_click_setting_tabs.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var height, width;

  @override
  void initState() {
    Get.put(DashBoardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<SettingController>(initState: (state) {
      Get.put(SettingController());
      SettingController.my.index = 0;
      //  SettingController.my.language = 0;
      // SettingController.my.setLanguagePreference(0) ;
      SettingController.my.getLanguagePreference();

      SettingController.my.ispotraitmodeclick = false;
    }, builder: (obj) {
      return OrientationBuilder(builder: (context, oreentation) {
        return Container(
          height: height,
          width: width,
          color: MyThemeData.background,
          child: Container(
            height: height,
            width: width,
            color: MyThemeData.background,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      oreentation == Orientation.landscape ? 0 : width * 0.05),
              child: oreentation == Orientation.landscape
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: width,
                            color: MyThemeData.background,
                          ),
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
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  l.settings,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.03,
                                  ),
                                ),
                              ),
                              Text(
                                l.appSettings,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: height! * 0.73,
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
                                      InkWell(
                                        onTap: () {
                                          obj.index = 0;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height! * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 0
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
                                                  width: width! * 0.02,
                                                ),
                                                Text(
                                                  l.unitsPreference,
                                                  style: TextStyle(
                                                      color: obj.index == 0
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width! * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        obj.unitspreferencesindex ==
                                                                0
                                                            ? l.imperial
                                                            : l.metric,
                                                        style: TextStyle(
                                                          color: obj.index == 0
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width! * 0.01,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: obj.index == 0
                                                      ? Colors.green
                                                      : MyThemeData
                                                          .onBackground,
                                                  size: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width! * 0.03,
                                                ),
                                              ],
                                            ),
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
                                          height: height! * 0.11,
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
                                                  width: width! * 0.02,
                                                ),
                                                Text(
                                                  l.language,
                                                  style: TextStyle(
                                                      color: obj.index == 1
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width! * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        obj.language == 0
                                                            ? l.englishUS
                                                            : obj.language == 1
                                                                ? l.englishUK
                                                                : obj.language ==
                                                                        2
                                                                    ? l.francais
                                                                    : obj.language ==
                                                                            3
                                                                        ? l.espanol
                                                                        : obj.language == 4
                                                                            ? l.deutsch
                                                                            : '',
                                                        style: TextStyle(
                                                          color: obj.index == 1
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width! * 0.01,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: obj.index == 1
                                                      ? Colors.green
                                                      : MyThemeData
                                                          .onBackground,
                                                  size: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width! * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      //3.
                                      InkWell(
                                        onTap: () {
                                          obj.index = 2;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height! * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 2
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
                                                  width: width! * 0.02,
                                                ),
                                                Text(
                                                  l.videoResolution,
                                                  style: TextStyle(
                                                      color: obj.index == 2
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width! * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        obj.videoresolution == 0
                                                            ? l.auto
                                                            : obj.videoresolution ==
                                                                    1
                                                                ? l.e2160p4K
                                                                : obj.videoresolution ==
                                                                        2
                                                                    ? l.e1440pHD
                                                                    : obj.videoresolution ==
                                                                            3
                                                                        ? l.e1080pHD
                                                                        : obj.videoresolution == 4
                                                                            ? l.e720p
                                                                            : obj.videoresolution == 5
                                                                                ? l.e480p
                                                                                : '',
                                                        style: TextStyle(
                                                          color: obj.index == 2
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width! * 0.01,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: obj.index == 2
                                                      ? Colors.green
                                                      : MyThemeData
                                                          .onBackground,
                                                  size: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width! * 0.03,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                      //4
                                      InkWell(
                                        onTap: () {
                                          obj.index = 3;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height! * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 3
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
                                                  width: width! * 0.02,
                                                ),
                                                Text(
                                                  l.subtitles,
                                                  style: TextStyle(
                                                      color: obj.index == 3
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width! * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        obj.subtitles == true
                                                            ? l.on
                                                            : l.off,
                                                        style: TextStyle(
                                                          color: obj.index == 3
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width! * 0.01,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: obj.index == 3
                                                      ? Colors.green
                                                      : MyThemeData
                                                          .onBackground,
                                                  size: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width! * 0.03,
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
                                          obj.index = 4;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height! * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 4
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
                                                  width: width! * 0.02,
                                                ),
                                                Text(
                                                  l.accountSettings,
                                                  style: TextStyle(
                                                      color: obj.index == 4
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width! * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        l.olivia,
                                                        style: TextStyle(
                                                          color: obj.index == 4
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width! * 0.01,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: obj.index == 4
                                                      ? Colors.green
                                                      : MyThemeData
                                                          .onBackground,
                                                  size: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width! * 0.03,
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
                                          // obj.index = 5;
                                          // obj.update();
                                          // DashBoardController.my.index = 0;
                                          // DashBoardController.my.update();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubscriptionSCreen(),
                                              ));
                                        },
                                        child: Container(
                                          height: height! * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 5
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
                                                  width: width! * 0.02,
                                                ),
                                                Text(
                                                  l.jetFitPremium,
                                                  style: TextStyle(
                                                      color: obj.index == 5
                                                          ? MyThemeData
                                                              .background
                                                          : MyThemeData
                                                              .onBackground,
                                                      fontSize: width! * 0.02,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width!,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        l.e3Months,
                                                        style: TextStyle(
                                                          color: obj.index == 5
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.02,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width! * 0.01,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: obj.index == 5
                                                      ? Colors.green
                                                      : MyThemeData
                                                          .onBackground,
                                                  size: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width! * 0.03,
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
                                          obj.index = 6;
                                          obj.update();
                                        },
                                        child: Container(
                                          height: height! * 0.11,
                                          width: width * 0.38,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 6
                                                  ? MyThemeData.onBackground
                                                  : MyThemeData.onBackground
                                                      .withOpacity(0.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width! * 0.02,
                                                  ),
                                                  Text(
                                                    l.aboutJetFit,
                                                    style: TextStyle(
                                                        color: obj.index == 6
                                                            ? MyThemeData
                                                                .background
                                                            : MyThemeData
                                                                .onBackground,
                                                        fontSize: width! * 0.02,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: width!,
                                                      child: const Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width! * 0.01,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: obj.index == 6
                                                        ? Colors.green
                                                        : MyThemeData
                                                            .onBackground,
                                                    size: width * 0.02,
                                                  ),
                                                  SizedBox(
                                                    width: width! * 0.03,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height! * 0.01,
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
                            child: obj.index == 0
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height * 0.05,
                                      ),
                                      Text(
                                        l.unitsPreferences,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.03,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height! * 0.73,
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
                                                  obj.unitspreferencesindex = 0;
                                                  obj.update();
                                                },
                                                child: Container(
                                                  height: height! * 0.11,
                                                  width: width * 0.38,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                          width: width! * 0.02,
                                                        ),
                                                        Text(
                                                          l.imperial,
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .onBackground,
                                                              fontSize:
                                                                  width! * 0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: width!,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width! * 0.01,
                                                        ),
                                                        obj.unitspreferencesindex ==
                                                                0
                                                            ? Icon(
                                                                Icons.check,
                                                                color: MyThemeData
                                                                    .onBackground,
                                                                size: width *
                                                                    0.03,
                                                              )
                                                            : const SizedBox(),
                                                        SizedBox(
                                                          width: width! * 0.03,
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
                                                  obj.unitspreferencesindex = 1;
                                                  obj.update();
                                                },
                                                child: Container(
                                                  height: height! * 0.11,
                                                  width: width * 0.38,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                          width: width! * 0.02,
                                                        ),
                                                        Text(
                                                          l.metric,
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .onBackground,
                                                              fontSize:
                                                                  width! * 0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: width!,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width! * 0.01,
                                                        ),
                                                        obj.unitspreferencesindex ==
                                                                1
                                                            ? Icon(
                                                                Icons.check,
                                                                color: MyThemeData
                                                                    .onBackground,
                                                                size: width *
                                                                    0.03,
                                                              )
                                                            : const SizedBox(),
                                                        SizedBox(
                                                          width: width! * 0.03,
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
                                        height: height! * 0.01,
                                      ),
                                    ],
                                  )
                                : obj.index == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height * 0.05,
                                          ),
                                          Text(
                                            l.language,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.03,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height! * 0.73,
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
                                                  InkWell(
                                                    onTap: () async {
                                                      obj.language = 0;
                                                      obj.update();
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      obj.setLanguagePreference(
                                                          0);
                                                      MyApp.setLocale(context,
                                                          Locale("en"));
                                                      prefs.setString(
                                                          "local", "en");
                                                      print("object");
                                                    },
                                                    child: Container(
                                                      height: height! * 0.11,
                                                      width: width * 0.38,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: MyThemeData
                                                              .onBackground
                                                              .withOpacity(
                                                                  0.4)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.02,
                                                            ),
                                                            Text(
                                                              l.englishUS,
                                                              style: TextStyle(
                                                                  color: MyThemeData
                                                                      .onBackground,
                                                                  fontSize:
                                                                      width! *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: width!,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.01,
                                                            ),
                                                            obj.language == 0
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: MyThemeData
                                                                        .onBackground,
                                                                    size: width *
                                                                        0.03,
                                                                  )
                                                                : const SizedBox(),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.03,
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
                                                    onTap: () async {
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      obj.setLanguagePreference(
                                                          1);
                                                      MyApp.setLocale(context,
                                                          Locale("en"));
                                                      prefs.setString(
                                                          "local", "en");
                                                      obj.language = 1;
                                                      obj.update();
                                                    },
                                                    child: Container(
                                                      height: height! * 0.11,
                                                      width: width * 0.38,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: MyThemeData
                                                              .onBackground
                                                              .withOpacity(
                                                                  0.4)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.02,
                                                            ),
                                                            Text(
                                                              l.englishUK,
                                                              style: TextStyle(
                                                                  color: MyThemeData
                                                                      .onBackground,
                                                                  fontSize:
                                                                      width! *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: width!,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.01,
                                                            ),
                                                            obj.language == 1
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: MyThemeData
                                                                        .onBackground,
                                                                    size: width *
                                                                        0.03,
                                                                  )
                                                                : const SizedBox(),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.03,
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
                                                    onTap: () async {
                                                      obj.setLanguagePreference(
                                                          2);
                                                      MyApp.setLocale(context,
                                                          Locale("fr"));
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          "local", "fr");

                                                      obj.language = 2;
                                                      obj.update();
                                                    },
                                                    child: Container(
                                                      height: height! * 0.11,
                                                      width: width * 0.38,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: MyThemeData
                                                              .onBackground
                                                              .withOpacity(
                                                                  0.4)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.02,
                                                            ),
                                                            Text(
                                                              l.francais,
                                                              style: TextStyle(
                                                                  color: MyThemeData
                                                                      .onBackground,
                                                                  fontSize:
                                                                      width! *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: width!,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.01,
                                                            ),
                                                            obj.language == 2
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: MyThemeData
                                                                        .onBackground,
                                                                    size: width *
                                                                        0.03,
                                                                  )
                                                                : const SizedBox(),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.03,
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
                                                    onTap: () async {
                                                      obj.setLanguagePreference(
                                                          3);
                                                      MyApp.setLocale(context,
                                                          Locale("es"));

                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          "local", "es");
                                                      obj.language = 3;
                                                      obj.update();
                                                    },
                                                    child: Container(
                                                      height: height! * 0.11,
                                                      width: width * 0.38,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: MyThemeData
                                                              .onBackground
                                                              .withOpacity(
                                                                  0.4)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.02,
                                                            ),
                                                            Text(
                                                              l.espanol,
                                                              style: TextStyle(
                                                                  color: MyThemeData
                                                                      .onBackground,
                                                                  fontSize:
                                                                      width! *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: width!,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.01,
                                                            ),
                                                            obj.language == 3
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: MyThemeData
                                                                        .onBackground,
                                                                    size: width *
                                                                        0.03,
                                                                  )
                                                                : const SizedBox(),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.03,
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
                                                    onTap: () async {
                                                      obj.setLanguagePreference(
                                                          4);
                                                      MyApp.setLocale(context,
                                                          Locale("de"));

                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          "local", "de");
                                                      obj.language = 4;
                                                      obj.update();
                                                    },
                                                    child: Container(
                                                      height: height! * 0.11,
                                                      width: width * 0.38,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: MyThemeData
                                                              .onBackground
                                                              .withOpacity(
                                                                  0.4)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.02,
                                                            ),
                                                            Text(
                                                              l.deutsch,
                                                              style: TextStyle(
                                                                  color: MyThemeData
                                                                      .onBackground,
                                                                  fontSize:
                                                                      width! *
                                                                          0.02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: width!,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.01,
                                                            ),
                                                            obj.language == 4
                                                                ? Icon(
                                                                    Icons.check,
                                                                    color: MyThemeData
                                                                        .onBackground,
                                                                    size: width *
                                                                        0.03,
                                                                  )
                                                                : const SizedBox(),
                                                            SizedBox(
                                                              width:
                                                                  width! * 0.03,
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
                                            height: height! * 0.01,
                                          ),
                                        ],
                                      )
                                    : obj.index == 2
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: height * 0.05,
                                              ),
                                              Text(
                                                l.videoResolution,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.03,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height! * 0.73,
                                                width: width,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: height * 0.03,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          obj.videoresolution =
                                                              0;
                                                          obj.update();
                                                        },
                                                        child: Container(
                                                          height:
                                                              height! * 0.11,
                                                          width: width * 0.38,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: MyThemeData
                                                                  .onBackground
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  l.auto,
                                                                  style: TextStyle(
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      fontSize:
                                                                          width! *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width!,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.01,
                                                                ),
                                                                obj.videoresolution ==
                                                                        0
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        size: width *
                                                                            0.03,
                                                                      )
                                                                    : const SizedBox(),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.03,
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
                                                          obj.videoresolution =
                                                              1;
                                                          obj.update();
                                                        },
                                                        child: Container(
                                                          height:
                                                              height! * 0.11,
                                                          width: width * 0.38,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: MyThemeData
                                                                  .onBackground
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  l.e2160p4K,
                                                                  style: TextStyle(
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      fontSize:
                                                                          width! *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width!,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.01,
                                                                ),
                                                                obj.videoresolution ==
                                                                        1
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        size: width *
                                                                            0.03,
                                                                      )
                                                                    : const SizedBox(),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.03,
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
                                                          obj.videoresolution =
                                                              2;
                                                          obj.update();
                                                        },
                                                        child: Container(
                                                          height:
                                                              height! * 0.11,
                                                          width: width * 0.38,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: MyThemeData
                                                                  .onBackground
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  l.e1440pHD,
                                                                  style: TextStyle(
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      fontSize:
                                                                          width! *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width!,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.01,
                                                                ),
                                                                obj.videoresolution ==
                                                                        2
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        size: width *
                                                                            0.03,
                                                                      )
                                                                    : const SizedBox(),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.03,
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
                                                          obj.videoresolution =
                                                              3;
                                                          obj.update();
                                                        },
                                                        child: Container(
                                                          height:
                                                              height! * 0.11,
                                                          width: width * 0.38,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: MyThemeData
                                                                  .onBackground
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  l.e1080pHD,
                                                                  style: TextStyle(
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      fontSize:
                                                                          width! *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width!,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.01,
                                                                ),
                                                                obj.videoresolution ==
                                                                        3
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        size: width *
                                                                            0.03,
                                                                      )
                                                                    : const SizedBox(),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.03,
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
                                                          obj.videoresolution =
                                                              4;
                                                          obj.update();
                                                        },
                                                        child: Container(
                                                          height:
                                                              height! * 0.11,
                                                          width: width * 0.38,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: MyThemeData
                                                                  .onBackground
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  l.e720p,
                                                                  style: TextStyle(
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      fontSize:
                                                                          width! *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width!,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.01,
                                                                ),
                                                                obj.videoresolution ==
                                                                        4
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        size: width *
                                                                            0.03,
                                                                      )
                                                                    : const SizedBox(),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.03,
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
                                                          obj.videoresolution =
                                                              5;
                                                          obj.update();
                                                        },
                                                        child: Container(
                                                          height:
                                                              height! * 0.11,
                                                          width: width * 0.38,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: MyThemeData
                                                                  .onBackground
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  l.e480p,
                                                                  style: TextStyle(
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      fontSize:
                                                                          width! *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width!,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.01,
                                                                ),
                                                                obj.videoresolution ==
                                                                        5
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        size: width *
                                                                            0.03,
                                                                      )
                                                                    : const SizedBox(),
                                                                SizedBox(
                                                                  width:
                                                                      width! *
                                                                          0.03,
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
                                                height: height! * 0.01,
                                              ),
                                            ],
                                          )
                                        : obj.index == 3
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: height * 0.05,
                                                  ),
                                                  Text(
                                                    l.subtitles,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.03,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height! * 0.73,
                                                    width: width,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                height * 0.03,
                                                          ),
                                                          Container(
                                                            height:
                                                                height! * 0.11,
                                                            width: width * 0.38,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: MyThemeData
                                                                    .onBackground
                                                                    .withOpacity(
                                                                        0.4)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        width! *
                                                                            0.02,
                                                                  ),
                                                                  Text(
                                                                    l.subtitles,
                                                                    style: TextStyle(
                                                                        color: MyThemeData
                                                                            .onBackground,
                                                                        fontSize:
                                                                            width! *
                                                                                0.02,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          width!,
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
                                                                    inactiveThumbColor: Colors
                                                                        .blueGrey
                                                                        .shade600,
                                                                    inactiveTrackColor:
                                                                        Colors
                                                                            .grey
                                                                            .shade400,
                                                                    splashRadius:
                                                                        50.0,
                                                                    // boolean variable value
                                                                    value: obj
                                                                        .subtitles,
                                                                    // changes the state of the switch
                                                                    onChanged:
                                                                        (value) {
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
                                                            height:
                                                                height * 0.03,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              DashBoardController
                                                                  .my.index = 9;
                                                              DashBoardController
                                                                  .my
                                                                  .update();

                                                              DashBoardController
                                                                  .my.index = 4;
                                                            },
                                                            child: Container(
                                                              height: height! *
                                                                  0.11,
                                                              width:
                                                                  width * 0.38,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: MyThemeData
                                                                      .onBackground
                                                                      .withOpacity(
                                                                          0.4)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: width! *
                                                                          0.02,
                                                                    ),
                                                                    Text(
                                                                      l.subtitlesLanguage,
                                                                      style: TextStyle(
                                                                          color: MyThemeData
                                                                              .onBackground,
                                                                          fontSize: width! *
                                                                              0.02,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            width!,
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Text(
                                                                            obj.subtitlelanguage == 0
                                                                                ? l.englishUS
                                                                                : obj.subtitlelanguage == 1
                                                                                    ? l.englishUK
                                                                                    : obj.subtitlelanguage == 2
                                                                                        ? l.francais
                                                                                        : obj.subtitlelanguage == 3
                                                                                            ? l.espanol
                                                                                            : obj.subtitlelanguage == 4
                                                                                                ? l.deutsch
                                                                                                : '',
                                                                            style:
                                                                                TextStyle(
                                                                              color: obj.index == 1 ? MyThemeData.background : MyThemeData.onBackground,
                                                                              fontSize: width! * 0.02,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: width! *
                                                                          0.01,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_outlined,
                                                                      color: MyThemeData
                                                                          .onBackground,
                                                                      size: width *
                                                                          0.02,
                                                                    ),
                                                                    SizedBox(
                                                                      width: width! *
                                                                          0.02,
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
                                                    height: height! * 0.01,
                                                  ),
                                                ],
                                              )
                                            : obj.index == 4
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: height * 0.05,
                                                      ),
                                                      Text(
                                                        l.accountSettings,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * 0.03,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height! * 0.73,
                                                        width: width,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: height *
                                                                    0.03,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  DashBoardController
                                                                      .my
                                                                      .updattokan(
                                                                          '');
                                                                  obj.logoutfunction(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height! *
                                                                          0.11,
                                                                  width: width *
                                                                      0.38,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: MyThemeData
                                                                          .onBackground
                                                                          .withOpacity(
                                                                              0.4)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.02,
                                                                        ),
                                                                        Text(
                                                                          Staticdata
                                                                              .userModel!
                                                                              .name!,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.onBackground,
                                                                              fontSize: width! * 0.02,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                width!,
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Text(
                                                                                l.switchAccount,
                                                                                style: TextStyle(
                                                                                  color: MyThemeData.onBackground,
                                                                                  fontSize: width! * 0.015,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.01,
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .arrow_forward_ios_outlined,
                                                                          color:
                                                                              MyThemeData.onBackground,
                                                                          size: width *
                                                                              0.02,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.03,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const ProfileScreen(),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height! *
                                                                          0.11,
                                                                  width: width *
                                                                      0.38,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: MyThemeData
                                                                          .onBackground
                                                                          .withOpacity(
                                                                              0.4)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.02,
                                                                        ),
                                                                        Text(
                                                                          l.profile,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.onBackground,
                                                                              fontSize: width! * 0.02,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                width!,
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: Text(
                                                                                l.switchAccount,
                                                                                style: TextStyle(
                                                                                  color: MyThemeData.onBackground,
                                                                                  fontSize: width! * 0.015,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.01,
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .arrow_forward_ios_outlined,
                                                                          color:
                                                                              MyThemeData.onBackground,
                                                                          size: width *
                                                                              0.02,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.03,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  DashBoardController
                                                                      .my
                                                                      .updattokan(
                                                                          '');
                                                                  obj.logoutfunction(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height! *
                                                                          0.11,
                                                                  width: width *
                                                                      0.38,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: MyThemeData
                                                                          .onBackground
                                                                          .withOpacity(
                                                                              0.4)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width! * 0.02,
                                                                        ),
                                                                        Text(
                                                                          l.logOut,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.onBackground,
                                                                              fontSize: width! * 0.02,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                width!,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    0.05,
                                                              ),
                                                              Text(
                                                                l.moreAccountSettings,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height! * 0.01,
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                          ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.05,
                              ),
                              Text(
                                l.settings,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.05,
                                ),
                              ),
                              Container(
                                height: height * 0.03,
                              ),
                              Text(
                                l.appSettings,
                                style: TextStyle(
                                  fontSize: width * 0.025,
                                  color: Colors.white,
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
                                        InkWell(
                                          onTap: () {
                                            obj.index = 0;
                                            obj.ispotraitmodeclick = true;
                                            obj.update();
                                          },
                                          child: PotraitWidgetSettingTabs(
                                            height: height,
                                            width: width,
                                            myIndex: 0,
                                            objindex: obj.index,
                                            textconditionIndex:
                                                obj.unitspreferencesindex,
                                            text: l.unitsPreferences,
                                            value0: l.imperial,
                                            value1: l.metric,
                                            value2: '',
                                            value3: '',
                                            value4: '',
                                            value5: '',
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        //2
                                        InkWell(
                                          onTap: () {
                                            obj.index = 1;
                                            obj.ispotraitmodeclick = true;
                                            obj.update();
                                          },
                                          child: PotraitWidgetSettingTabs(
                                              height: height,
                                              myIndex: 1,
                                              objindex: obj.index,
                                              text: l.language,
                                              value0: l.englishUS,
                                              value1: l.englishUS,
                                              value2: l.francais,
                                              value3: l.espanol,
                                              value4: l.deutsch,
                                              value5: '',
                                              textconditionIndex: obj.language,
                                              width: width),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        //3.
                                        InkWell(
                                          onTap: () {
                                            obj.index = 2;
                                            obj.ispotraitmodeclick = true;
                                            obj.update();
                                          },
                                          child: PotraitWidgetSettingTabs(
                                              height: height,
                                              myIndex: 2,
                                              objindex: obj.index,
                                              text: l.videoResolution,
                                              value0: l.auto,
                                              value1: l.e2160p4K,
                                              value2: l.e1440pHD,
                                              value3: l.e1080pHD,
                                              value4: l.e720p,
                                              value5: l.e480p,
                                              textconditionIndex:
                                                  obj.videoresolution,
                                              width: width),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        //4
                                        InkWell(
                                          onTap: () {
                                            obj.index = 3;
                                            obj.ispotraitmodeclick = true;
                                            obj.update();
                                          },
                                          child: Container(
                                            height: height! * 0.075,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: obj.index == 3
                                                    ? MyThemeData.onBackground
                                                    : MyThemeData.onBackground
                                                        .withOpacity(0.4)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width! * 0.02,
                                                  ),
                                                  Text(
                                                    l.subtitles,
                                                    style: TextStyle(
                                                        color: obj.index == 3
                                                            ? MyThemeData
                                                                .background
                                                            : MyThemeData
                                                                .onBackground,
                                                        fontSize:
                                                            width! * 0.037,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: width!,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          obj.subtitles == true
                                                              ? l.on
                                                              : l.off,
                                                          style: TextStyle(
                                                            color: obj.index ==
                                                                    3
                                                                ? MyThemeData
                                                                    .background
                                                                : MyThemeData
                                                                    .onBackground,
                                                            fontSize:
                                                                width! * 0.033,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width! * 0.01,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: obj.index == 3
                                                        ? Colors.green
                                                        : MyThemeData
                                                            .onBackground,
                                                    size: width * 0.05,
                                                  ),
                                                  SizedBox(
                                                    width: width! * 0.03,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        //5
                                        InkWell(
                                          onTap: () {
                                            obj.index = 4;
                                            obj.ispotraitmodeclick = true;
                                            obj.update();
                                          },
                                          child: PotraitWidgetSettingTabs(
                                              height: height,
                                              myIndex: 4,
                                              objindex: obj.index,
                                              text: l.accountSettings,
                                              value0: l.profileManagement,
                                              value1: l.olivia,
                                              value2: l.logOut,
                                              value3: "",
                                              value4: "",
                                              value5: '',
                                              textconditionIndex:
                                                  obj.accountsettings,
                                              width: width),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        //6
                                        InkWell(
                                          onTap: () {
                                            // obj.index = 5;
                                            // obj.ispotraitmodeclick = true;
                                            // obj.update();
                                            // DashBoardController.my.index = 0;
                                            // DashBoardController.my.update();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubscriptionSCreen(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: height! * 0.075,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: obj.index == 5
                                                  ? MyThemeData.onBackground
                                                  : MyThemeData.onBackground
                                                      .withOpacity(0.4),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width! * 0.02,
                                                  ),
                                                  Text(
                                                    l.jetFitPremium,
                                                    style: TextStyle(
                                                        color: obj.index == 5
                                                            ? MyThemeData
                                                                .background
                                                            : MyThemeData
                                                                .onBackground,
                                                        fontSize:
                                                            width! * 0.037,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: width!,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          l.e3Months,
                                                          style: TextStyle(
                                                            color: obj.index ==
                                                                    5
                                                                ? MyThemeData
                                                                    .background
                                                                : MyThemeData
                                                                    .onBackground,
                                                            fontSize:
                                                                width! * 0.033,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width! * 0.01,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: obj.index == 5
                                                        ? Colors.green
                                                        : MyThemeData
                                                            .onBackground,
                                                    size: width * 0.05,
                                                  ),
                                                  SizedBox(
                                                    width: width! * 0.03,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        //7
                                        InkWell(
                                          onTap: () {
                                            obj.index = 6;
                                            obj.update();
                                          },
                                          child: Container(
                                            height: height! * 0.075,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: obj.index == 6
                                                    ? MyThemeData.onBackground
                                                    : MyThemeData.onBackground
                                                        .withOpacity(0.4)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: width! * 0.02,
                                                    ),
                                                    Text(
                                                      l.aboutJetFit,
                                                      style: TextStyle(
                                                          color: obj.index == 6
                                                              ? MyThemeData
                                                                  .background
                                                              : MyThemeData
                                                                  .onBackground,
                                                          fontSize:
                                                              width! * 0.037,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: width!,
                                                        child: const Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width! * 0.01,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      color: obj.index == 6
                                                          ? Colors.green
                                                          : MyThemeData
                                                              .onBackground,
                                                      size: width * 0.05,
                                                    ),
                                                    SizedBox(
                                                      width: width! * 0.03,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height! * 0.01,
                              ),
                            ],
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
                                  color:
                                      MyThemeData.background.withOpacity(0.3),
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
                                    height: height! * 0.6,
                                    width: width! * 0.8,
                                    decoration: BoxDecoration(
                                        color: MyThemeData.surfaceVarient,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          obj.index == 0
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      height: height * 0.03,
                                                    ),
                                                    Text(
                                                      l.unitsPreferences,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.05,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.45,
                                                      width: width,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                height * 0.03,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              obj.unitspreferencesindex =
                                                                  0;
                                                              obj.ispotraitmodeclick =
                                                                  false;
                                                              obj.update();
                                                            },
                                                            child:
                                                                IsClicksettingTabs(
                                                              height: height,
                                                              width: width,
                                                              myIndex: 0,
                                                              objconditionIndex:
                                                                  obj.unitspreferencesindex,
                                                              text: l.imperial,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.03,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              obj.unitspreferencesindex =
                                                                  1;
                                                              obj.ispotraitmodeclick =
                                                                  false;
                                                              obj.update();
                                                            },
                                                            child:
                                                                IsClicksettingTabs(
                                                              height: height,
                                                              width: width,
                                                              myIndex: 1,
                                                              objconditionIndex:
                                                                  obj.unitspreferencesindex,
                                                              text: l.metric,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height! * 0.01,
                                                    ),
                                                  ],
                                                )
                                              : obj.index == 1
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          height: height * 0.02,
                                                        ),
                                                        Text(
                                                          l.language,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.05,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.5,
                                                          width: width,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          prefs =
                                                                          await SharedPreferences
                                                                              .getInstance();

                                                                      obj.setLanguagePreference(
                                                                          0);
                                                                      MyApp.setLocale(
                                                                          context,
                                                                          Locale(
                                                                              "en"));
                                                                      prefs.setString(
                                                                          "local",
                                                                          "en");

                                                                      obj.ispotraitmodeclick =
                                                                          false;
                                                                      obj.update();
                                                                    },
                                                                    child: IsClicksettingTabs(
                                                                        height:
                                                                            height,
                                                                        text: l
                                                                            .englishUS,
                                                                        myIndex:
                                                                            0,
                                                                        objconditionIndex: obj
                                                                            .language,
                                                                        width:
                                                                            width)),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      SharedPreferences
                                                                          prefs =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      obj.setLanguagePreference(
                                                                          1);
                                                                      MyApp.setLocale(
                                                                          context,
                                                                          Locale(
                                                                              "en"));
                                                                      prefs.setString(
                                                                          "local",
                                                                          "en");

                                                                      obj.ispotraitmodeclick =
                                                                          false;
                                                                      obj.update();
                                                                    },
                                                                    child: IsClicksettingTabs(
                                                                        height:
                                                                            height,
                                                                        text: l
                                                                            .englishUS,
                                                                        myIndex:
                                                                            1,
                                                                        objconditionIndex: obj
                                                                            .language,
                                                                        width:
                                                                            width)),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    obj.setLanguagePreference(
                                                                        2);
                                                                    MyApp.setLocale(
                                                                        context,
                                                                        Locale(
                                                                            "fr"));
                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    prefs.setString(
                                                                        "local",
                                                                        "fr");

                                                                    obj.ispotraitmodeclick =
                                                                        false;
                                                                    obj.update();
                                                                  },
                                                                  child: IsClicksettingTabs(
                                                                      height:
                                                                          height,
                                                                      text: l
                                                                          .francais,
                                                                      myIndex:
                                                                          2,
                                                                      objconditionIndex: obj
                                                                          .language,
                                                                      width:
                                                                          width),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    obj.setLanguagePreference(
                                                                        3);
                                                                    MyApp.setLocale(
                                                                        context,
                                                                        Locale(
                                                                            "es"));

                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    prefs.setString(
                                                                        "local",
                                                                        "es");

                                                                    obj.ispotraitmodeclick =
                                                                        false;
                                                                    obj.update();
                                                                  },
                                                                  child: IsClicksettingTabs(
                                                                      height:
                                                                          height,
                                                                      text: l
                                                                          .espanol,
                                                                      myIndex:
                                                                          3,
                                                                      objconditionIndex: obj
                                                                          .language,
                                                                      width:
                                                                          width),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    obj.setLanguagePreference(
                                                                        4);
                                                                    MyApp.setLocale(
                                                                        context,
                                                                        Locale(
                                                                            "de"));

                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    prefs.setString(
                                                                        "local",
                                                                        "de");
                                                                    obj.ispotraitmodeclick =
                                                                        false;
                                                                    obj.update();
                                                                  },
                                                                  child: IsClicksettingTabs(
                                                                      height:
                                                                          height,
                                                                      text: l
                                                                          .deutsch,
                                                                      myIndex:
                                                                          4,
                                                                      objconditionIndex: obj
                                                                          .language,
                                                                      width:
                                                                          width),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height! * 0.01,
                                                        ),
                                                      ],
                                                    )
                                                  : obj.index == 2
                                                      ? Column(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  height * 0.03,
                                                            ),
                                                            Text(
                                                              l.videoResolution,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.05,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.5,
                                                              width: width,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          obj.videoresolution =
                                                                              0;
                                                                          obj.ispotraitmodeclick =
                                                                              false;
                                                                          obj.update();
                                                                        },
                                                                        child: IsClicksettingTabs(
                                                                            height:
                                                                                height,
                                                                            text: l
                                                                                .auto,
                                                                            myIndex:
                                                                                0,
                                                                            objconditionIndex:
                                                                                obj.videoresolution,
                                                                            width: width)),
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          obj.videoresolution =
                                                                              1;
                                                                          obj.ispotraitmodeclick =
                                                                              false;
                                                                          obj.update();
                                                                        },
                                                                        child: IsClicksettingTabs(
                                                                            height:
                                                                                height,
                                                                            text: l
                                                                                .e2160p4K,
                                                                            myIndex:
                                                                                1,
                                                                            objconditionIndex:
                                                                                obj.videoresolution,
                                                                            width: width)),
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        obj.videoresolution =
                                                                            2;
                                                                        obj.ispotraitmodeclick =
                                                                            false;
                                                                        obj.update();
                                                                      },
                                                                      child: IsClicksettingTabs(
                                                                          height:
                                                                              height,
                                                                          text: l
                                                                              .e1440pHD,
                                                                          myIndex:
                                                                              2,
                                                                          objconditionIndex: obj
                                                                              .videoresolution,
                                                                          width:
                                                                              width),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        obj.videoresolution =
                                                                            3;
                                                                        obj.ispotraitmodeclick =
                                                                            false;
                                                                        obj.update();
                                                                      },
                                                                      child: IsClicksettingTabs(
                                                                          height:
                                                                              height,
                                                                          text: l
                                                                              .e1080pHD,
                                                                          myIndex:
                                                                              3,
                                                                          objconditionIndex: obj
                                                                              .videoresolution,
                                                                          width:
                                                                              width),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        obj.videoresolution =
                                                                            4;
                                                                        obj.ispotraitmodeclick =
                                                                            false;
                                                                        obj.update();
                                                                      },
                                                                      child: IsClicksettingTabs(
                                                                          height:
                                                                              height,
                                                                          text: l
                                                                              .e720p,
                                                                          myIndex:
                                                                              4,
                                                                          objconditionIndex: obj
                                                                              .videoresolution,
                                                                          width:
                                                                              width),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        obj.videoresolution =
                                                                            5;
                                                                        obj.ispotraitmodeclick =
                                                                            false;
                                                                        obj.update();
                                                                      },
                                                                      child: IsClicksettingTabs(
                                                                          height:
                                                                              height,
                                                                          text: l
                                                                              .e480p,
                                                                          myIndex:
                                                                              5,
                                                                          objconditionIndex: obj
                                                                              .videoresolution,
                                                                          width:
                                                                              width),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: height! *
                                                                  0.01,
                                                            ),
                                                          ],
                                                        )
                                                      : obj.index == 3
                                                          ? Column(
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      height *
                                                                          0.03,
                                                                ),
                                                                Text(
                                                                  l.subtitles,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        width *
                                                                            0.05,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height! *
                                                                          0.4,
                                                                  width: width,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.03,
                                                                      ),
                                                                      Container(
                                                                        height: height! *
                                                                            0.06,
                                                                        width: width *
                                                                            0.7,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color: MyThemeData.onBackground.withOpacity(0.4)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: width! * 0.02,
                                                                              ),
                                                                              Text(
                                                                                l.subtitles,
                                                                                style: TextStyle(color: MyThemeData.onBackground, fontSize: width! * 0.04, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  width: width!,
                                                                                ),
                                                                              ),
                                                                              Switch(
                                                                                // thumb color (round icon)
                                                                                activeColor: const Color(0xff005140),

                                                                                activeTrackColor: const Color(0xff48DDB8),
                                                                                inactiveThumbColor: Colors.blueGrey.shade600,
                                                                                inactiveTrackColor: Colors.grey.shade400,
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
                                                                        height: height *
                                                                            0.03,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          DashBoardController
                                                                              .my
                                                                              .index = 9;
                                                                          DashBoardController
                                                                              .my
                                                                              .update();

                                                                          DashBoardController
                                                                              .my
                                                                              .index = 4;
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              height! * 0.06,
                                                                          width:
                                                                              width * 0.7,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: MyThemeData.onBackground.withOpacity(0.4)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: width! * 0.02,
                                                                                ),
                                                                                Text(
                                                                                  l.subtitlesLanguage,
                                                                                  style: TextStyle(color: MyThemeData.onBackground, fontSize: width! * 0.04, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Expanded(
                                                                                  child: SizedBox(
                                                                                    width: width!,
                                                                                    child: Align(
                                                                                      alignment: Alignment.centerRight,
                                                                                      child: Text(
                                                                                        obj.subtitlelanguage == 0
                                                                                            ? l.englishUS
                                                                                            : obj.subtitlelanguage == 1
                                                                                                ? l.englishUK
                                                                                                : obj.subtitlelanguage == 2
                                                                                                    ? l.francais
                                                                                                    : obj.subtitlelanguage == 3
                                                                                                        ? l.espanol
                                                                                                        : obj.subtitlelanguage == 4
                                                                                                            ? l.deutsch
                                                                                                            : '',
                                                                                        style: TextStyle(
                                                                                          color: obj.index == 1 ? MyThemeData.background : MyThemeData.onBackground,
                                                                                          fontSize: width! * 0.03,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: width! * 0.01,
                                                                                ),
                                                                                Icon(
                                                                                  Icons.arrow_forward_ios_outlined,
                                                                                  color: MyThemeData.onBackground,
                                                                                  size: width * 0.05,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: width! * 0.02,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height! *
                                                                          0.01,
                                                                ),
                                                              ],
                                                            )
                                                          : obj.index == 4
                                                              ? Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                    ),
                                                                    Text(
                                                                      l.accountSettings,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            width *
                                                                                0.05,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height! *
                                                                              0.4,
                                                                      width:
                                                                          width,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              DashBoardController.my.updattokan('');
                                                                              obj.logoutfunction(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: height! * 0.06,
                                                                              width: width * 0.7,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyThemeData.onBackground.withOpacity(0.4)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: width! * 0.02,
                                                                                    ),
                                                                                    Text(
                                                                                      Staticdata.userModel!.name!,
                                                                                      style: TextStyle(color: MyThemeData.onBackground, fontSize: width! * 0.04, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: SizedBox(
                                                                                        width: width!,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Text(
                                                                                            l.switchAccount,
                                                                                            style: TextStyle(
                                                                                              color: MyThemeData.onBackground,
                                                                                              fontSize: width! * 0.032,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: width! * 0.01,
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.arrow_forward_ios_outlined,
                                                                                      color: MyThemeData.onBackground,
                                                                                      size: width * 0.03,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: width! * 0.02,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => const ProfileScreen(),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: height! * 0.06,
                                                                              width: width * 0.7,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyThemeData.onBackground.withOpacity(0.4)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: width! * 0.02,
                                                                                    ),
                                                                                    Text(
                                                                                      l.profile,
                                                                                      style: TextStyle(color: MyThemeData.onBackground, fontSize: width! * 0.04, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: SizedBox(
                                                                                        width: width!,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              DashBoardController.my.updattokan('');
                                                                              obj.logoutfunction(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: height! * 0.06,
                                                                              width: width * 0.7,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyThemeData.onBackground.withOpacity(0.4)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: width! * 0.02,
                                                                                    ),
                                                                                    Text(
                                                                                      l.logOut,
                                                                                      style: TextStyle(color: MyThemeData.onBackground, fontSize: width! * 0.04, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: SizedBox(
                                                                                        width: width!,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(20.0),
                                                                            child:
                                                                                Text(
                                                                              l.moreAccountSettings,
                                                                              style: TextStyle(
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          height! *
                                                                              0.01,
                                                                    ),
                                                                  ],
                                                                )
                                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
            ),
          ),
        );
      });
    });
  }
}
