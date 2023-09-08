import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/favourite_controller.dart';
import 'package:jetfit/utilis/static_data.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/cover_player/cover_player.dart';
import 'package:jetfit/view/screens/favourite/playlist/playlist_view.dart';
import 'package:jetfit/view/screens/auth/login_screen.dart';
import 'package:jetfit/view/widgets/exclusive_card.dart';
import 'package:jetfit/view/widgets/premium_card.dart';
import 'package:jetfit/web_view/home_screen/manage_profile/manage_profile_controller.dart';
import 'package:video_player/video_player.dart';

import 'package:jetfit/view/screens/home01/home01_controller.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:shimmer/shimmer.dart';

class Home01Screen extends StatefulWidget {
  const Home01Screen({super.key});

  @override
  State<Home01Screen> createState() => _Home01ScreenState();
}

class _Home01ScreenState extends State<Home01Screen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var height, width;

  @override
  void initState() {
    Get.put(DashBoardController());
    Get.put(Home01Controller());
    Home01Controller.my.getcatagories();
    Home01Controller.my.getVisit();
    Get.put(FavouriteController());
    Home01Controller.my.ispremuimclick = false;
    Home01Controller.my.isexclusiveclick = false;
    // Home01Controller.my.checkuserpremiumstatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: OrientationBuilder(builder: (context, orientation) {
        Home01Controller.my.getcatagories();
        return GetBuilder<Home01Controller>(builder: (obj) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: orientation == Orientation.portrait
                          ? 0
                          : width * 0.12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.07),
                      obj.value == null
                          ? Center(
                              child: Container(
                                  height: orientation == Orientation.portrait
                                      ? height * 0.27
                                      : height * 0.6,
                                  width: orientation == Orientation.portrait
                                      ? width * 0.95
                                      : width * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: IntroductionVideoPlayer()),
                            )
                          : orientation == Orientation.portrait
                              ? Center(
                                  child: Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      height: height * 0.27,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF9FAFB),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      width: width * 0.95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: height * 0.37,
                                            width: width * 0.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * 0.05,
                                                ),
                                                Text(
                                                  l.myJFamily,
                                                  style: TextStyle(
                                                      fontSize: width * 0.04),
                                                ),
                                                Text(
                                                  l.acrobaticGames,
                                                  style: TextStyle(
                                                    color: MyThemeData.error30,
                                                    fontSize: width * 0.03,
                                                  ),
                                                ),
                                                Text(
                                                  l.meisterklasse,
                                                  style: TextStyle(
                                                      fontSize: width * 0.03),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    obj.value = null;
                                                    obj.update();
                                                  },
                                                  child: Container(
                                                    height: height * 0.05,
                                                    width: width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              'images/home/pause.png'),
                                                        ),
                                                        FittedBox(
                                                          child: Text(
                                                            l.startIntro,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.56,
                                            width: width * 0.35,
                                            child: const Image(
                                              image: AssetImage(
                                                'images/home/persons.png',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      height: height * 0.6,
                                      width: width * 0.85,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF9FAFB),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: height * 0.6,
                                            width: width * 0.35,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * 0.05,
                                                ),
                                                Text(
                                                  l.myJFamily,
                                                ),
                                                Text(
                                                  l.acrobaticGames,
                                                  style: TextStyle(
                                                    color: MyThemeData.error30,
                                                    fontSize: width * 0.03,
                                                  ),
                                                ),
                                                Text(
                                                  l.meisterklasse,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    obj.value = null;
                                                    obj.update();
                                                  },
                                                  child: Container(
                                                    height: height * 0.09,
                                                    width: width * 0.15,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              'images/home/pause.png'),
                                                        ),
                                                        Text(
                                                          l.startIntro,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.56,
                                            width: width * 0.4,
                                            child: const Image(
                                              image: AssetImage(
                                                  'images/home/persons.png'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                      Staticdata.uid == null
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                                horizontal: width * 0.05,
                              ),
                              child: Text(
                                l.learnFunSkills,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: orientation == Orientation.landscape
                                      ? width * 0.027
                                      : width * 0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : SizedBox(),
                      Staticdata.uid == null
                          ? SizedBox(
                              height: orientation == Orientation.landscape
                                  ? height * 0.3
                                  : height *
                                      0.16, // Adjust the height as needed
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: firebaseFirestore
                                      .collection("category")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data == null
                                          ? Center(
                                              child:
                                                  WhiteSpinkitFlutter.spinkit,
                                            )
                                          : snapshot.data!.docs.isEmpty
                                              ? Center(
                                                  child: Text(l.noCategories))
                                              : Container(
                                                  height: height,
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        CategoryModel model =
                                                            CategoryModel(
                                                          playlistType: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "playlistType"),
                                                          classType: snapshot
                                                              .data!.docs[index]
                                                              .get("classType"),
                                                          dificulty: snapshot
                                                              .data!.docs[index]
                                                              .get("dificulty"),
                                                          instructor: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "instructor"),
                                                          videoLanguage: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "videoLanguage"),
                                                          categoryDescription:
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "categoryDescription"),
                                                          categoryID: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryID"),
                                                          categoryName: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryName"),
                                                          categoryType: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryType"),
                                                          thumbnailimageURL:
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "thumbnailimageURL"),
                                                          categoryTimeline: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryTimeline"),
                                                        );

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              obj.catindex =
                                                                  index;
                                                              showtoast(l
                                                                  .openProfile);
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Card(
                                                                  elevation: 5,
                                                                  shadowColor:
                                                                      MyThemeData
                                                                          .onSurface,
                                                                  color: Colors
                                                                      .transparent,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? height *
                                                                            0.4
                                                                        : height *
                                                                            0.15,
                                                                    width: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? width *
                                                                            0.4
                                                                        : width *
                                                                            0.7,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              2,
                                                                          color: obj.catindex == index
                                                                              ? Colors.white
                                                                              : Colors.transparent),
                                                                      color: Colors
                                                                          .transparent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(model
                                                                            .thumbnailimageURL
                                                                            .toString()),
                                                                      ),
                                                                    ),
                                                                    foregroundDecoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black38,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? height *
                                                                            0.4
                                                                        : height *
                                                                            0.15,
                                                                    width: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? width *
                                                                            0.4
                                                                        : width *
                                                                            0.7,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            model.categoryName.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: orientation == Orientation.landscape ? width * 0.023 : width * 0.04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            model.categoryDescription.toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.white60,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }));
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Center(
                                        child: WhiteSpinkitFlutter.spinkit,
                                      );
                                    }
                                  }),
                            )
                          : SizedBox(),
                      Staticdata.uid == null
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                  horizontal:
                                      orientation == Orientation.landscape
                                          ? width * 0.02
                                          : width * 0.05),
                              child: Text(
                                l.categories,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: orientation == Orientation.landscape
                                      ? width * 0.027
                                      : width * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                      Staticdata.uid == null
                          ? SizedBox(
                              height: height * 0.1,
                            )
                          : SizedBox(),
                      Staticdata.uid == null
                          ? Center(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginAppScreen(),
                                      ));
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  l.openProfile,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          : SizedBox(),
                      Staticdata.uid == null
                          ? SizedBox()
                          : SizedBox(
                              height: orientation == Orientation.landscape
                                  ? height * 0.3
                                  : height *
                                      0.16, // Adjust the height as needed
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: firebaseFirestore
                                      .collection("category")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data == null
                                          ? Center(
                                              child:
                                                  WhiteSpinkitFlutter.spinkit,
                                            )
                                          : snapshot.data!.docs.isEmpty
                                              ? Center(
                                                  child: Text(l.noCategories))
                                              : Container(
                                                  height: height,
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        CategoryModel model =
                                                            CategoryModel(
                                                          playlistType: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "playlistType"),
                                                          classType: snapshot
                                                              .data!.docs[index]
                                                              .get("classType"),
                                                          dificulty: snapshot
                                                              .data!.docs[index]
                                                              .get("dificulty"),
                                                          instructor: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "instructor"),
                                                          videoLanguage: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "videoLanguage"),
                                                          categoryDescription:
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "categoryDescription"),
                                                          categoryID: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryID"),
                                                          categoryName: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryName"),
                                                          categoryType: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryType"),
                                                          thumbnailimageURL:
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "thumbnailimageURL"),
                                                          categoryTimeline: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "categoryTimeline"),
                                                        );

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              obj.catindex =
                                                                  index;
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        PlaylistView(
                                                                            model:
                                                                                model),
                                                                  ));
                                                              obj.onCategoryTap(
                                                                  model
                                                                      .categoryID!);
                                                              obj.update();
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Card(
                                                                  elevation: 5,
                                                                  shadowColor:
                                                                      MyThemeData
                                                                          .onSurface,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? height *
                                                                            0.4
                                                                        : height *
                                                                            0.15,
                                                                    width: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? width *
                                                                            0.4
                                                                        : width *
                                                                            0.7,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        _buildShimmer(
                                                                      height: orientation ==
                                                                              Orientation
                                                                                  .landscape
                                                                          ? height *
                                                                              0.4
                                                                          : height *
                                                                              0.15,
                                                                      width: orientation ==
                                                                              Orientation
                                                                                  .landscape
                                                                          ? width *
                                                                              0.4
                                                                          : width *
                                                                              0.7,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Card(
                                                                  elevation: 5,
                                                                  shadowColor:
                                                                      MyThemeData
                                                                          .onSurface,
                                                                  color: Colors
                                                                      .transparent,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? height *
                                                                            0.4
                                                                        : height *
                                                                            0.15,
                                                                    width: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? width *
                                                                            0.4
                                                                        : width *
                                                                            0.7,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              2,
                                                                          color: obj.catindex == index
                                                                              ? Colors.white
                                                                              : Colors.transparent),
                                                                      color: Colors
                                                                          .transparent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(model
                                                                            .thumbnailimageURL
                                                                            .toString()),
                                                                      ),
                                                                    ),
                                                                    foregroundDecoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black38,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? height *
                                                                            0.4
                                                                        : height *
                                                                            0.15,
                                                                    width: orientation ==
                                                                            Orientation
                                                                                .landscape
                                                                        ? width *
                                                                            0.4
                                                                        : width *
                                                                            0.7,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            model.categoryName.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: orientation == Orientation.landscape ? width * 0.023 : width * 0.04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            model.categoryDescription.toString(),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.white60,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }));
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Center(
                                        child: WhiteSpinkitFlutter.spinkit,
                                      );
                                    }
                                  }),
                            ),
                      Staticdata.uid == null
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                  horizontal:
                                      orientation == Orientation.landscape
                                          ? width * 0.02
                                          : width * 0.05),
                              child: Text(
                                l.recommendedForYou,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: orientation == Orientation.landscape
                                      ? width * 0.027
                                      : width * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                      Staticdata.uid == null
                          ? SizedBox()
                          : FutureBuilder<List<VideossModel>>(
                              future: DashBoardController.my
                                  .getVideosFromFirebase(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: width,
                                    height: height,
                                    color: Colors.black.withOpacity(0.1),
                                    child: Center(
                                      child: WhiteSpinkitFlutter.spinkit,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return Container();
                                } else {
                                  return Padding(
                                    padding: orientation == Orientation.portrait
                                        ? EdgeInsets.only(left: 8)
                                        : EdgeInsets.only(left: width * 0.01),
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      key: UniqueKey(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      gridDelegate: orientation ==
                                              Orientation.portrait
                                          ? SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 15,
                                              mainAxisExtent: 180,
                                              mainAxisSpacing: 2,
                                            )
                                          : SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 27,
                                              mainAxisSpacing: 1,
                                              mainAxisExtent: 200,
                                              crossAxisCount: 3,
                                            ),
                                      itemBuilder: (context, index) {
                                        VideossModel model =
                                            snapshot.data![index];
                                        return Stack(
                                          children: [
                                            ShimmerCard(
                                                height: height,
                                                width: width,
                                                orientation: orientation),
                                            SizedBox(
                                              height: height,
                                              width: width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Card(
                                                    elevation: 5,
                                                    color: Colors.transparent,
                                                    shadowColor:
                                                        MyThemeData.onSurface,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    child: Container(
                                                      height: orientation ==
                                                              Orientation
                                                                  .portrait
                                                          ? height! * 0.13
                                                          : height! * 0.27,
                                                      width: orientation ==
                                                              Orientation
                                                                  .portrait
                                                          ? width
                                                          : width! * 0.5,
                                                      foregroundDecoration:
                                                          BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: CoverPlayer(
                                                        ishomecontroller: true,
                                                        issearchcontroller:
                                                            false,
                                                        istrainignCOntroller:
                                                            false,
                                                        isvideomodel: true,
                                                        videoModal: model,
                                                        isIcon: true,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      model.videoName!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: MyThemeData
                                                              .whitecolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      '${model.duration} | intensity *',
                                                      style: TextStyle(
                                                          color: MyThemeData
                                                              .whitecolor),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      '${model.viewers!.length} views',
                                                      style: TextStyle(
                                                        color: MyThemeData
                                                            .greyColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }
                              }),
                      SizedBox(
                        height: height * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
              obj.ispremuimclick || obj.isexclusiveclick
                  ? InkWell(
                      onTap: () {
                        obj.ispremuimclick = false;
                        obj.isexclusiveclick = false;
                        obj.update();
                      },
                      child: Container(
                        height: height,
                        width: width,
                        color: MyThemeData.background.withOpacity(0.3),
                      ),
                    )
                  : const SizedBox(),
              obj.ispremuimclick == false
                  ? SizedBox()
                  : PremiumContentWidget(
                      isPremiumClick: obj.ispremuimclick,
                      orientation: Orientation.portrait,
                      videossModel: obj.videossModel!,
                      controller: obj,
                    ),
              obj.isexclusiveclick == false
                  ? SizedBox()
                  : ExclusiveCardWidget(
                      isexclusiveclick: obj.isexclusiveclick,
                      orientation: Orientation.portrait,
                      videossModel: obj.videossModel!,
                      controller: obj,
                    ),
            ],
          );
        });
      }),
    );
  }
}

class IntroductionVideoPlayer extends StatefulWidget {
  const IntroductionVideoPlayer({Key? key}) : super(key: key);

  @override
  State<IntroductionVideoPlayer> createState() =>
      _IntroductionVideoPlayerState();
}

class _IntroductionVideoPlayerState extends State<IntroductionVideoPlayer> {
  VideoPlayerController? videoplayerController;
  Future<void>? _initializeVideoPlayerFuture;
  VideoModel? model;
  bool isclick = false;
  bool _disposed = false;
  String? time;
  Future<VideoModel> introductionvideo() async {
    await FirebaseFirestore.instance
        .collection("introvideo")
        .doc('1')
        .get()
        .then((value) {
      model = VideoModel.fromMap(value.data()!);
      print("model $model");
    });
    return model!;
  }

  void _disposeControllers() {
    videoplayerController?.dispose();
  }

  @override
  void initState() {
    Get.put(DashBoardController());
    Get.put(Home01Controller());
    introductionvideo().then((value) {
      videoplayerController =
          VideoPlayerController.networkUrl(Uri.parse(value.videoURL!));
      _initializeVideoPlayerFuture =
          videoplayerController!.initialize().then((value) {
        if (videoplayerController != null) {
          videoplayerController!.play();

          videoplayerController!.addListener(() {
            _updateVideoPosition();
          });
        }
      });
    });

    super.initState();
  }

  void _updateVideoPosition() {
    if (_disposed) return; // Check if widget is disposed
    if (mounted) {
      setState(() {
        time =
            '${videoplayerController!.value.position.inMinutes}:${(videoplayerController!.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${videoplayerController!.value.duration.inMinutes}:${(videoplayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}';
      });

      if (videoplayerController!.value.position >=
          videoplayerController!.value.duration) {
        Home01Controller.my.setVisit();
      }
    }
  }

  @override
  void dispose() {
    videoplayerController?.removeListener(_updateVideoPosition);
    _disposeControllers();
    _disposed = true;
    super.dispose();
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return OrientationBuilder(builder: (context, orientation) {
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    isclick = !isclick;
                    print(isclick);
                  });
                }
              },
              child: Container(
                height: orientation == Orientation.portrait
                    ? height * 0.27
                    : height * 0.6,
                width: orientation == Orientation.portrait
                    ? width * 0.95
                    : width * 0.85,
                child: Stack(
                  children: [
                    videoplayerController!.value.isInitialized
                        ? Align(
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio:
                                  videoplayerController!.value.aspectRatio,
                              child: VideoPlayer(videoplayerController!),
                            ),
                          )
                        : Center(child: WhiteSpinkitFlutter.spinkit),
                    isclick == false
                        ? SizedBox()
                        : Container(
                            height: orientation == Orientation.portrait
                                ? height * 0.27
                                : height * 0.6,
                            width: orientation == Orientation.portrait
                                ? width * 0.9
                                : width,
                            color: MyThemeData.background.withOpacity(0.3),
                          ),
                    isclick == false
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: VideoProgressIndicator(
                                colors: VideoProgressColors(
                                    playedColor: Colors.white),
                                videoplayerController!,
                                allowScrubbing: true,
                              ),
                            ),
                          ),
                    isclick == false
                        ? SizedBox()
                        : Center(
                            child: IconButton(
                              icon: Icon(
                                videoplayerController!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    videoplayerController!.value.isPlaying
                                        ? videoplayerController!.pause()
                                        : videoplayerController!.play();
                                  });
                                }
                              },
                            ),
                          ),
                    isclick == false
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                time.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: const [0.4, 0.5, 0.6],
                      colors: [
                        Colors.grey[200]!,
                        Colors.grey[300]!,
                        Colors.grey[200]!,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    });
  }
}

class ShimmerCard extends StatelessWidget {
  final double height;
  final double width;
  final Orientation orientation;

  ShimmerCard({
    required this.height,
    required this.width,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: MyThemeData.onSurface, // You should provide the actual value
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height:
            orientation == Orientation.portrait ? height * 0.13 : height * 0.27,
        width: orientation == Orientation.portrait ? width : width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: _buildShimmer(
          height: orientation == Orientation.portrait
              ? height * 0.13
              : height * 0.27,
          width: orientation == Orientation.portrait ? width : width * 0.5,
        ),
      ),
    );
  }
}

Widget _buildShimmer({required height, required width}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.4, 0.5, 0.6],
          colors: [
            Colors.grey[200]!,
            Colors.grey[300]!,
            Colors.grey[200]!,
          ],
        ),
      ),
    ),
  );
}
