import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/favourite_controller.dart';
import 'package:jetfit/controllers/training_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/favourite/playlist/playlist_view.dart';
import 'package:jetfit/view/screens/cover_player/cover_player.dart';
import 'package:jetfit/view/screens/home01/home01_controller.dart';
import 'package:jetfit/view/screens/home01/home_01.dart';
import 'package:jetfit/view/widgets/exclusive_card.dart';
import 'package:jetfit/view/widgets/premium_card.dart';
import 'package:jetfit/web_view/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  var height, width;
  String selectedDifficulty = "Easy";
  String selectedClassType = "Solo";
  String selectedVideoLanguage = "German";
  String selectedinstructor = "John";
  bool sort = true;
  // Lists for filter options
  List<String> difficultyMenuItems = ["Easy", "Hard", "Medium"];
  List<String> classTypeMenuItems = ["Solo", "Duo", "Group"];
  List<String> videoLanguageMenuItems = ["German", "English", "Russian"];
  Duration parseDuration(String durationString) {
    final match = RegExp(r'(\d+) min').firstMatch(durationString);
    if (match != null) {
      final minutes = int.parse(match.group(1)!);
      return Duration(minutes: minutes);
    }
    return Duration.zero;
  }

  // Function to reset filter values
  void resetFilters() {
    setState(() {
      selectedDifficulty = "Easy";
      selectedClassType = "Solo";
      selectedVideoLanguage = "German";
      selectedinstructor = "John";
    });
  }

  String selectedSortOption = "Newest";

  void sortby() {
    setState(() {
      selectedSortOption = "Newest";
    });
  }

  @override
  void initState() {
    sort = true;
    sortby();
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
          return GetBuilder<TrainingController>(initState: (state) {
            Get.put(TrainingController());
            Get.put(DashboardController());
            Get.put(FavouriteController());
            TrainingController.to.isFilterOpen = false;
            TrainingController.to.isSortOpen = false;
            TrainingController.to.isclick = false;
            DashboardController.to.getcataories();
            TrainingController.to.fetchplaylistmodel();
            TrainingController.to.isexclusiveclick = false;
            TrainingController.to.ispremuimclick = false;
          }, builder: (obj) {
            return SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      obj.sortFilter(false);
                      obj.openFilter(false);
                    },
                    child: Container(
                      height: height,
                      width: width,
                      color: MyThemeData.background,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height! * 0.05,
                              ),
                              orientation == Orientation.portrait
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: height! * 0.1,
                                      // color: Colors.red,
                                      width: width,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width! * 0.12,
                                          ),
                                          obj.index == 0
                                              ? Container(
                                                  height: height,
                                                  width: width! * 0.15,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text(l.workout),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width! * 0.01,
                                                      right: width! * 0.01),
                                                  child: Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            obj.changePage(0);
                                                          },
                                                          child: Text(
                                                            l.workout,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))),
                                                ),
                                          obj.index == 1
                                              ? Container(
                                                  height: height,
                                                  width: width! * 0.15,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text(l.series),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width! * 0.01,
                                                      right: width! * 0.01),
                                                  child: Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            obj.changePage(1);
                                                          },
                                                          child: Text(
                                                            l.series,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))),
                                                ),
                                          obj.index == 2
                                              ? Container(
                                                  height: height,
                                                  width: width! * 0.15,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text(l.challenges),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width! * 0.01,
                                                      right: width! * 0.01),
                                                  child: Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            obj.changePage(2);
                                                            DashBoardController
                                                                .my.index = 6;
                                                            DashBoardController
                                                                .my
                                                                .update();

                                                            DashBoardController
                                                                .my.index = 2;
                                                          },
                                                          child: Text(
                                                            l.challenges,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))),
                                                ),
                                          obj.index == 3
                                              ? Container(
                                                  height: height,
                                                  width: width! * 0.15,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: MyThemeData
                                                          .onBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Text(l.routines),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width! * 0.01,
                                                      right: width! * 0.01),
                                                  child: Center(
                                                      child: InkWell(
                                                          onTap: () {
                                                            obj.changePage(3);
                                                          },
                                                          child: Text(
                                                            l.routines,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))),
                                                ),
                                          SizedBox(
                                            width: width! * 0.4,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    obj.openFilter(false);
                                                    obj.isSortOpen
                                                        ? obj.sortFilter(false)
                                                        : obj.sortFilter(true);
                                                    setState(() {
                                                      sort = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: height,
                                                    width: width! * 0.16,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: MyThemeData
                                                                .onSurface),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Text(
                                                      "${l.sortBy}: ${selectedSortOption}",
                                                      style: TextStyle(
                                                          color: MyThemeData
                                                              .onSurfaceVarient),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    obj.sortFilter(false);
                                                    obj.isFilterOpen
                                                        ? obj.openFilter(false)
                                                        : obj.openFilter(true);
                                                    setState(() {
                                                      sort = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: height,
                                                    width: width! * 0.12,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: MyThemeData
                                                                .onSurface),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Text(
                                                      l.filters,
                                                      style: TextStyle(
                                                          color: MyThemeData
                                                              .onSurfaceVarient),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                              orientation == Orientation.portrait
                                  ? SizedBox(
                                      height: height! * 0.05,
                                      width: width,
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                obj.index = 0;
                                                resetFilters();
                                                obj.update();
                                              },
                                              child: buildTab(
                                                  0, "Workout", obj.index)),
                                          InkWell(
                                              onTap: () {
                                                resetFilters();
                                                obj.index = 1;
                                                obj.update();
                                              },
                                              child: buildTab(
                                                  1, "Series", obj.index)),
                                          InkWell(
                                              onTap: () {
                                                resetFilters();
                                                obj.index = 2;
                                                obj.update();
                                              },
                                              child: buildTab(
                                                  2, "Challenges", obj.index)),
                                          InkWell(
                                              onTap: () {
                                                resetFilters();
                                                obj.index = 3;
                                                obj.update();
                                              },
                                              child: buildTab(
                                                  3, "Routines", obj.index)),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: orientation == Orientation.portrait
                                    ? height! * 0.02
                                    : 0,
                              ),
                              orientation == Orientation.portrait
                                  ? SizedBox(
                                      height: height! * 0.05,
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              obj.openFilter(false);
                                              obj.isSortOpen
                                                  ? obj.sortFilter(false)
                                                  : obj.sortFilter(true);
                                              setState(() {
                                                sort = true;
                                              });
                                            },
                                            child: Container(
                                              height: height,
                                              width: width! * 0.4,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: MyThemeData
                                                          .onSurface),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Text(
                                                "${l.sortBy}:  ${selectedSortOption}",
                                                style: TextStyle(
                                                    color: MyThemeData
                                                        .onSurfaceVarient),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width! * 0.02,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              obj.sortFilter(false);
                                              obj.isFilterOpen
                                                  ? obj.openFilter(false)
                                                  : obj.openFilter(true);
                                              setState(() {
                                                sort = false;
                                              });
                                            },
                                            child: Container(
                                              height: height,
                                              width: width! * 0.2,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: MyThemeData
                                                          .onSurface),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Text(
                                                l.filters,
                                                style: TextStyle(
                                                    color: MyThemeData
                                                        .onSurfaceVarient),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: orientation == Orientation.portrait
                                    ? height! * 0.02
                                    : 0,
                              ),

                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("category")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: width,
                                        height: height * 0.7,
                                        child: Center(
                                          child: WhiteSpinkitFlutter.spinkit,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Container();
                                      // return Center(
                                      //     child: Text("No Categories"));
                                    } else {
                                      List<DocumentSnapshot> filteredDocuments =
                                          [];
                                      print("sort ${sort}");
                                      if (sort == true) {
                                        // First, filter documents by the selected category
                                        List<DocumentSnapshot>
                                            categoryFilteredDocuments =
                                            snapshot.data!.docs.where((doc) {
                                          final videoData = doc.data()
                                              as Map<String, dynamic>;
                                          bool categoryMatch = obj
                                                  .categories[obj.index]
                                                  .isEmpty ||
                                              videoData['categoryType'] ==
                                                  obj.categories[obj.index];
                                          return categoryMatch;
                                        }).toList();

                                        if (selectedSortOption == 'Shortest' ||
                                            selectedSortOption == 'Longest') {
                                          // Sort documents by duration for 'Shortest' or 'Longest' within the category
                                          categoryFilteredDocuments
                                              .sort((a, b) {
                                            final durationA = parseDuration((a
                                                        .data()
                                                    as Map<String, dynamic>)[
                                                'categoryTimeline']);
                                            final durationB = parseDuration((b
                                                        .data()
                                                    as Map<String, dynamic>)[
                                                'categoryTimeline']);

                                            // Compare based on the selected sort option
                                            return selectedSortOption ==
                                                    'Shortest'
                                                ? durationA.compareTo(durationB)
                                                : durationB
                                                    .compareTo(durationA);
                                          });
                                        } else {
                                          // Handle 'Easiest', 'Hardest', or 'Newest' sorting within the category
                                          categoryFilteredDocuments
                                              .sort((a, b) {
                                            final videoDataA = a.data()
                                                as Map<String, dynamic>;
                                            final videoDataB = b.data()
                                                as Map<String, dynamic>;

                                            // Define a map to assign sorting order for each difficulty level
                                            Map<String, int> difficultyOrder = {
                                              'Easy': 1,
                                              'Newest': 2,
                                              'Hard': 3,
                                            };

                                            // Compare based on the selected sort option and the difficulty order
                                            int result = difficultyOrder[
                                                    videoDataA['dificulty']]!
                                                .compareTo(difficultyOrder[
                                                    videoDataB['dificulty']]!);

                                            // If the difficulties are the same, sort by the 'createdAt' timestamp in descending order (newest first)
                                            if (result == 0) {
                                              final timestampA =
                                                  videoDataA['createdAt'] ?? 0;
                                              final timestampB =
                                                  videoDataB['createdAt'] ?? 0;
                                              result = timestampB
                                                  .compareTo(timestampA);
                                            }

                                            return result;
                                          });
                                        }

                                        // Assign the sorted/filtered documents to the final list
                                        filteredDocuments =
                                            categoryFilteredDocuments;
                                      } else {
                                        filteredDocuments =
                                            snapshot.data!.docs.where((doc) {
                                          final videoData = doc.data()
                                              as Map<String, dynamic>;
                                          print(
                                              "cattypeplaylist ${videoData['categoryType']}");

                                          // Check if the document matches the selected category
                                          bool categoryMatch = obj
                                                  .categories[obj.index]
                                                  .isEmpty ||
                                              videoData['categoryType'] ==
                                                  obj.categories[obj.index];

                                          // Check if the document matches the selected difficulty
                                          bool difficultyMatch =
                                              selectedDifficulty.isEmpty ||
                                                  videoData['dificulty'] ==
                                                      selectedDifficulty;

                                          // Check if the document matches the selected class type
                                          bool classTypeMatch =
                                              selectedClassType.isEmpty ||
                                                  videoData['classType'] ==
                                                      selectedClassType;

                                          // Check if the document matches the selected video language
                                          bool languageMatch =
                                              selectedVideoLanguage.isEmpty ||
                                                  videoData['videoLanguage'] ==
                                                      selectedVideoLanguage;

                                          // Check if the document matches the selected instructor
                                          bool instructorMatch =
                                              selectedinstructor.isEmpty ||
                                                  videoData['instructor'] ==
                                                      selectedinstructor;

                                          // Combine all conditions
                                          return categoryMatch &&
                                              difficultyMatch &&
                                              classTypeMatch &&
                                              languageMatch &&
                                              instructorMatch;
                                        }).toList();
                                      }

                                      if (filteredDocuments.isEmpty) {
                                        // return Center(
                                        //     child: Text("No Categories"));
                                        return Container();
                                      }

                                      return Padding(
                                        padding:
                                            orientation == Orientation.portrait
                                                ? const EdgeInsets.only(left: 8)
                                                : EdgeInsets.only(
                                                    left: width * 0.12),
                                        child: GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          key: UniqueKey(),
                                          shrinkWrap: true,
                                          itemCount: filteredDocuments.length,
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
                                            CategoryModel model = CategoryModel(
                                              playlistType:
                                                  filteredDocuments[index]
                                                      .get("playlistType"),
                                              classType:
                                                  filteredDocuments[index]
                                                      .get("classType"),
                                              dificulty:
                                                  filteredDocuments[index]
                                                      .get("dificulty"),
                                              instructor:
                                                  filteredDocuments[index]
                                                      .get("instructor"),
                                              videoLanguage:
                                                  filteredDocuments[index]
                                                      .get("videoLanguage"),
                                              categoryDescription:
                                                  filteredDocuments[index].get(
                                                      "categoryDescription"),
                                              categoryID:
                                                  filteredDocuments[index]
                                                      .get("categoryID"),
                                              categoryName:
                                                  filteredDocuments[index]
                                                      .get("categoryName"),
                                              categoryType:
                                                  filteredDocuments[index]
                                                      .get("categoryType"),
                                              thumbnailimageURL:
                                                  filteredDocuments[index]
                                                      .get("thumbnailimageURL"),
                                              categoryTimeline:
                                                  filteredDocuments[index]
                                                      .get("categoryTimeline"),
                                            );

                                            return Stack(
                                              children: [
                                                ShimmerCard(
                                                    height: height,
                                                    width: width,
                                                    orientation: orientation),
                                                SizedBox(
                                                  height: orientation ==
                                                          Orientation.portrait
                                                      ? height
                                                      : width,
                                                  width: orientation ==
                                                          Orientation.portrait
                                                      ? width
                                                      : height,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PlaylistView(
                                                                        model:
                                                                            model),
                                                              ));
                                                        },
                                                        child: Card(
                                                          elevation: 5,
                                                          color: MyThemeData
                                                              .background,
                                                          shadowColor:
                                                              MyThemeData
                                                                  .onSurface,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Container(
                                                            height: orientation ==
                                                                    Orientation
                                                                        .portrait
                                                                ? height! * 0.13
                                                                : height! *
                                                                    0.27,
                                                            width: orientation ==
                                                                    Orientation
                                                                        .portrait
                                                                ? width
                                                                : width! * 0.5,
                                                            foregroundDecoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    NetworkImage(
                                                                  model
                                                                      .thumbnailimageURL!,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: StreamBuilder<
                                                                      QuerySnapshot>(
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'category')
                                                                      .doc(model
                                                                          .categoryID)
                                                                      .collection(
                                                                          'playlist')
                                                                      .snapshots(),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      return Container(
                                                                        height: height *
                                                                            0.03,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.grey,
                                                                          borderRadius: BorderRadius.only(
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10)),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 12),
                                                                              child: Text(
                                                                                '${snapshot.data!.docs.length ?? 0} videos',
                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return Center(
                                                                        child: WhiteSpinkitFlutter
                                                                            .spinkit,
                                                                      );
                                                                    }
                                                                  }),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          model.categoryName!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .whitecolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          '${model.categoryTimeline} | intensity *',
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .whitecolor),
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
                              ///////////// videos gettt
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("videos")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                          // width: width,
                                          // height: height,
                                          // color: Colors.black.withOpacity(0.1),
                                          // child: Center(
                                          //   child: WhiteSpinkitFlutter.spinkit,
                                          // ),
                                          );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Container();
                                      // return Center(
                                      //     child: Text("No Categories"));
                                    } else {
                                      List<DocumentSnapshot> filteredDocuments =
                                          [];
                                      print("sort ${sort}");
                                      if (sort == true) {
                                        List<DocumentSnapshot>
                                            categoryFilteredDocuments =
                                            snapshot.data!.docs.where((doc) {
                                          final videoData = doc.data()
                                              as Map<String, dynamic>;
                                          bool categoryMatch = obj
                                                  .categories[obj.index]
                                                  .isEmpty ||
                                              videoData['catagorytpe'] ==
                                                  obj.categories[obj.index];
                                          return categoryMatch;
                                        }).toList();

                                        if (selectedSortOption == 'Shortest' ||
                                            selectedSortOption == 'Longest') {
                                          categoryFilteredDocuments
                                              .sort((a, b) {
                                            final durationA = parseDuration(
                                                (a.data() as Map<String,
                                                    dynamic>)['duration']);
                                            final durationB = parseDuration(
                                                (b.data() as Map<String,
                                                    dynamic>)['duration']);
                                            return selectedSortOption ==
                                                    'Shortest'
                                                ? durationA.compareTo(durationB)
                                                : durationB
                                                    .compareTo(durationA);
                                          });
                                        } else {
                                          categoryFilteredDocuments
                                              .sort((a, b) {
                                            final videoDataA = a.data()
                                                as Map<String, dynamic>;
                                            final videoDataB = b.data()
                                                as Map<String, dynamic>;

                                            Map<String, int> difficultyOrder = {
                                              'Easy': 1,
                                              'New': 2,
                                              'Hard': 3,
                                            };

                                            int result = difficultyOrder[
                                                    videoDataA['dificulty']]!
                                                .compareTo(difficultyOrder[
                                                    videoDataB['dificulty']]!);

                                            if (result == 0) {
                                              final timestampA =
                                                  videoDataA['createdAt'] ?? 0;
                                              final timestampB =
                                                  videoDataB['createdAt'] ?? 0;
                                              result = timestampB
                                                  .compareTo(timestampA);
                                            }

                                            return result;
                                          });
                                        }

                                        filteredDocuments =
                                            categoryFilteredDocuments;
                                      } else {
                                        filteredDocuments =
                                            snapshot.data!.docs.where((doc) {
                                          final videoData = doc.data()
                                              as Map<String, dynamic>;

                                          bool categoryMatch = obj
                                                  .categories[obj.index]
                                                  .isEmpty ||
                                              videoData['catagorytpe'] ==
                                                  obj.categories[obj.index];
                                          bool difficultyMatch =
                                              selectedDifficulty.isEmpty ||
                                                  videoData['dificulty'] ==
                                                      selectedDifficulty;

                                          bool classTypeMatch =
                                              selectedClassType.isEmpty ||
                                                  videoData['classType'] ==
                                                      selectedClassType;

                                          bool languageMatch =
                                              selectedVideoLanguage.isEmpty ||
                                                  videoData['videoLanguage'] ==
                                                      selectedVideoLanguage;
                                          bool instructorMatch =
                                              selectedinstructor.isEmpty ||
                                                  videoData['instructor'] ==
                                                      selectedinstructor;

                                          return categoryMatch &&
                                              difficultyMatch &&
                                              classTypeMatch &&
                                              languageMatch &&
                                              instructorMatch;
                                        }).toList();
                                      }
                                      if (filteredDocuments.isEmpty) {
                                        // return Center(
                                        //     child: Text("No Categories"));
                                        return Container();
                                      }
                                      return Padding(
                                        padding:
                                            orientation == Orientation.portrait
                                                ? const EdgeInsets.only(left: 8)
                                                : EdgeInsets.only(
                                                    left: width * 0.12),
                                        child: GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          key: UniqueKey(),
                                          shrinkWrap: true,
                                          itemCount: filteredDocuments.length,
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
                                            VideossModel model = VideossModel(
                                              price: filteredDocuments[index]
                                                  .get("price"),
                                              catagorytpe:
                                                  filteredDocuments[index]
                                                      .get("catagorytpe"),
                                              classType:
                                                  filteredDocuments[index]
                                                      .get("classType"),
                                              dificulty:
                                                  filteredDocuments[index]
                                                      .get("dificulty"),
                                              duration: filteredDocuments[index]
                                                  .get("duration"),
                                              instructor:
                                                  filteredDocuments[index]
                                                      .get("instructor"),
                                              videoDescription:
                                                  filteredDocuments[index]
                                                      .get("videoDescription"),
                                              videoID: filteredDocuments[index]
                                                  .get("videoID"),
                                              videoLanguage:
                                                  filteredDocuments[index]
                                                      .get("videoLanguage"),
                                              videoName:
                                                  filteredDocuments[index]
                                                      .get("videoName"),
                                              videoURL: filteredDocuments[index]
                                                  .get("videoURL"),
                                              videotype:
                                                  filteredDocuments[index]
                                                      .get("videotype"),
                                              viewers: filteredDocuments[index]
                                                  .get("viewers"),
                                            );

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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Card(
                                                        elevation: 5,
                                                        color:
                                                            Colors.transparent,
                                                        shadowColor: MyThemeData
                                                            .onSurface,
                                                        shape: RoundedRectangleBorder(
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
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: CoverPlayer(
                                                            ishomecontroller:
                                                                false,
                                                            issearchcontroller:
                                                                false,
                                                            istrainignCOntroller:
                                                                true,
                                                            videoModal: model,
                                                            isIcon: true,
                                                            isvideomodel: true,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          model.videoName!,
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .whitecolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          '${model.duration!} | intensity *',
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .whitecolor),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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

                              orientation == Orientation.portrait
                                  ? SizedBox(
                                      height:
                                          orientation == Orientation.portrait
                                              ? height! * 0.08
                                              : width * 0.08)
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  obj.isSortOpen
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: orientation == Orientation.portrait
                                  ? height! * 0.1
                                  : 0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: orientation == Orientation.portrait
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                        color: MyThemeData.surfaceVarient,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    l.sortBy,
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      sortby();
                                                    },
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Text(
                                                        l.reset,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                            buildSortOption("Newest"),
                                            buildSortOption("Easiest"),
                                            buildSortOption("Hardest"),
                                            buildSortOption("Shortest"),
                                            buildSortOption("Longest"),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 10,
                                    shadowColor: MyThemeData.onSurface,
                                    child: Container(
                                      height: height!,
                                      width: width! * 0.4,
                                      decoration: BoxDecoration(
                                        color: MyThemeData.surfaceVarient,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              height: height! * 0.07,
                                              width: width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    l.sortBy,
                                                    style: TextStyle(
                                                        fontSize: width! * 0.02,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      sortby();
                                                    },
                                                    child: Container(
                                                      height: height,
                                                      width: width! * 0.15,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: MyThemeData
                                                              .outline,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Text(
                                                        l.reset,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            buildSortOptionlandscape("Newest"),
                                            buildSortOptionlandscape("Easiest"),
                                            buildSortOptionlandscape("Hardest"),
                                            buildSortOptionlandscape(
                                                "Shortest"),
                                            buildSortOptionlandscape("Longest"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      : const SizedBox(),
                  obj.isFilterOpen
                      ? InkWell(
                          onTap: () {
                            obj.isFilterOpen = false;
                            obj.update();
                          },
                          child: Container(
                              height: height,
                              width: width,
                              color: MyThemeData.background.withOpacity(0.2)),
                        )
                      : SizedBox(),
                  ///////////sort
                  obj.isFilterOpen
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: orientation == Orientation.portrait
                              ? Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 10,
                                  shadowColor: MyThemeData.onSurface,
                                  child: Container(
                                    height: height! * 0.6,
                                    width: width! * 0.7,
                                    decoration: BoxDecoration(
                                      color: MyThemeData.surfaceVarient,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                l.filters,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color?>(Colors.grey),
                                                ),
                                                onPressed: resetFilters,
                                                child: Text(
                                                  l.clear,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.person_3_outlined,
                                            color: MyThemeData.onSurface,
                                          ),
                                          title: Text(
                                            l.instructor,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          trailing: DropdownButton<String>(
                                            dropdownColor:
                                                MyThemeData.surfaceVarient,
                                            value: selectedinstructor,
                                            underline:
                                                Container(), // Removes the underline
                                            items: obj.instructorMenuItems
                                                .map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        MyThemeData.greyColor,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedinstructor = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.speed,
                                            color: MyThemeData.onSurface,
                                          ),
                                          title: Text(
                                            l.difficulty,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          trailing: DropdownButton<String>(
                                            dropdownColor:
                                                MyThemeData.surfaceVarient,
                                            value: selectedDifficulty,
                                            underline:
                                                Container(), // Removes the underline
                                            items: difficultyMenuItems
                                                .map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        MyThemeData.greyColor,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedDifficulty = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.fitness_center,
                                            color: MyThemeData.onSurface,
                                          ),
                                          title: Text(
                                            l.classType,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          trailing: DropdownButton<String>(
                                            dropdownColor:
                                                MyThemeData.surfaceVarient,
                                            value: selectedClassType,
                                            underline:
                                                Container(), // Removes the underline
                                            items: classTypeMenuItems
                                                .map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        MyThemeData.greyColor,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedClassType = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.language,
                                            color: MyThemeData.onSurface,
                                          ),
                                          title: Text(
                                            l.language,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          trailing: DropdownButton<String>(
                                            dropdownColor:
                                                MyThemeData.surfaceVarient,
                                            value: selectedVideoLanguage,
                                            underline:
                                                Container(), // Removes the underline
                                            items: videoLanguageMenuItems
                                                .map((String item) {
                                              return DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        MyThemeData.greyColor,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedVideoLanguage = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 10,
                                  shadowColor: MyThemeData.onSurface,
                                  child: Container(
                                    height: height!,
                                    width: width! * 0.5,
                                    decoration: BoxDecoration(
                                      color: MyThemeData.surfaceVarient,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  l.filters,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color?>(
                                                                Colors.grey),
                                                  ),
                                                  onPressed: resetFilters,
                                                  child: Text(
                                                    l.clear,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.person_3_outlined,
                                                      color:
                                                          MyThemeData.onSurface,
                                                    ),
                                                    title: Text(
                                                      l.instructor,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing:
                                                        DropdownButton<String>(
                                                      dropdownColor: MyThemeData
                                                          .surfaceVarient,
                                                      value: selectedinstructor,
                                                      underline:
                                                          Container(), // Removes the underline
                                                      items: obj
                                                          .instructorMenuItems
                                                          .map((String item) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedinstructor =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.speed,
                                                      color:
                                                          MyThemeData.onSurface,
                                                    ),
                                                    title: Text(
                                                      l.difficulty,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing:
                                                        DropdownButton<String>(
                                                      dropdownColor: MyThemeData
                                                          .surfaceVarient,
                                                      value: selectedDifficulty,
                                                      underline:
                                                          Container(), // Removes the underline
                                                      items: difficultyMenuItems
                                                          .map((String item) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedDifficulty =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.fitness_center,
                                                      color:
                                                          MyThemeData.onSurface,
                                                    ),
                                                    title: Text(
                                                      l.classType,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing:
                                                        DropdownButton<String>(
                                                      dropdownColor: MyThemeData
                                                          .surfaceVarient,
                                                      value: selectedClassType,
                                                      underline:
                                                          Container(), // Removes the underline
                                                      items: classTypeMenuItems
                                                          .map((String item) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedClassType =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.language,
                                                      color:
                                                          MyThemeData.onSurface,
                                                    ),
                                                    title: Text(
                                                      l.language,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing:
                                                        DropdownButton<String>(
                                                      dropdownColor: MyThemeData
                                                          .surfaceVarient,
                                                      value:
                                                          selectedVideoLanguage,
                                                      underline:
                                                          Container(), // Removes the underline
                                                      items:
                                                          videoLanguageMenuItems
                                                              .map((String
                                                                  item) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedVideoLanguage =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      : const SizedBox(),

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
              ),
            );
          });
        }));
  }

  Widget buildSortOption(String option) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.15,
              alignment: Alignment.center,
              child: Radio(
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                activeColor: Colors.white,
                value: option,
                groupValue: selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    selectedSortOption = value.toString();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSortOptionlandscape(String option) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: width! * 0.02),
            Text(
              option,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(width: width! * 0.1),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.15,
              alignment: Alignment.center,
              child: Radio(
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                activeColor: Colors.white,
                value: option,
                groupValue: selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    selectedSortOption = value.toString();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTab(int tabIndex, String title, int selectedIndex) {
    final isSelected = tabIndex == selectedIndex;
    return GetBuilder<TrainingController>(initState: (state) {
      Get.put(TrainingController());
    }, builder: (obj) {
      return Container(
        width: width! * 0.21,
        child: isSelected
            ? Container(
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            : TextButton(
                onPressed: () {
                  obj.changePage(tabIndex);
                },
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      );
    });
  }
}

class TrainingVideoPlayer extends StatefulWidget {
  final PlayListModel playListModel;

  const TrainingVideoPlayer({super.key, required this.playListModel});

  @override
  _TrainingVideoPlayerState createState() => _TrainingVideoPlayerState();
}

class _TrainingVideoPlayerState extends State<TrainingVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.playListModel.videoURL!));
    _initializeVideoPlayerFuture =
        _videoPlayerController!.initialize().then((_) {
      setState(
          () {}); // Ensure the player is initialized before calling setState
    });
    _videoPlayerController!.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    if (_videoPlayerController!.value.isPlaying) {
      setState(() {
        _isVideoPlaying = true;
      });
    } else {
      setState(() {
        _isVideoPlaying = false;
      });
    }
  }

  Widget lableTextname(String title) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.015, bottom: height * 0.01),
      child: Text(
        title,
        style: TextStyle(
            color: MyThemeData.background, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder<TrainingController>(initState: (state) {
      Get.put(TrainingController());
    }, builder: (obj) {
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(
                      _videoPlayerController!,
                    ),
                    if (!_isVideoPlaying)
                      Center(
                        child: InkWell(
                          onTap: () {
                            obj.videoclickModel(widget.playListModel);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => HomeVideoPlayerScreen(
                            //       videooo: widget.playListModel,
                            //     ),
                            //   ),
                            // );
                          },
                          child: const Icon(
                            Icons.play_arrow,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    //   Align(
                    //     alignment: Alignment.bottomRight,
                    //     child: Container(
                    //       height: height * 0.03,
                    //       width: width * 0.05,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(20),
                    //         color: Colors.black,
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           '${_videoPlayerController!.value.position.inMinutes}:${(_videoPlayerController!.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                    //           style:
                    //               const TextStyle(color: Colors.white, fontSize: 12),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox(
              width: width * 0.1,
              height: height * 0.12,
              child: Center(
                child: WhiteSpinkitFlutter.spinkit,
              ),
            );
          }
        },
      );
    });
  }
}

class TrainingCoverVideo extends StatefulWidget {
  final VideossModel playListModel;

  const TrainingCoverVideo({super.key, required this.playListModel});

  @override
  _TrainingCoverVideoState createState() => _TrainingCoverVideoState();
}

class _TrainingCoverVideoState extends State<TrainingCoverVideo> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(Home01Controller());
    Get.put(TrainingController());
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.playListModel.videoURL!));
    _initializeVideoPlayerFuture =
        _videoPlayerController!.initialize().then((_) {
      setState(
          () {}); // Ensure the player is initialized before calling setState
    });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(
                _videoPlayerController!,
              ),
            ),
          );
        } else {
          return SizedBox(
            width: width * 0.1,
            height: height * 0.12,
            child: Center(
              child: WhiteSpinkitFlutter.spinkit,
            ),
          );
        }
      },
    );
  }
}
