import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/cover_player/cover_player.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/view/screens/dashboard.dart';

class ChallengeTabsScreen extends StatefulWidget {
  CategoryModel model;
  ChallengeTabsScreen({
    super.key,
    required this.model,
  });

  @override
  State<ChallengeTabsScreen> createState() => _ChallengeTabsScreenState();
}

class _ChallengeTabsScreenState extends State<ChallengeTabsScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Videos"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoard(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          children: [
            Container(
                height: height,
                width: width,
                color: MyThemeData.background,
                child: orientation == Orientation.portrait
                    ? Padding(
                        padding: EdgeInsets.only(bottom: height * 0.07),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(left: width * 0.1),
                            //   child: Row(
                            //     children: [
                            //       const Text(
                            //         "Challenge details",
                            //         style: TextStyle(
                            //           color: Colors.grey,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         width: width * 0.01,
                            //       ),
                            //       const Image(
                            //         image: AssetImage(
                            //             'images/training/arrowback.png'),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: height * 0.03,
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: width * 0.1),
                            //   child: Text(
                            //     "Weekly plan",
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: width * 0.055,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: height * 0.03,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Text(
                            //       "Week 1: Meet the basics",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.03,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     Text(
                            //       "Week 2: Get your footing",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.03,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: height * 0.02,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Text(
                            //       "Week 3: Expand your style",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.03,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     Text(
                            //       "Week 4: Challenge yourself",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.03,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            // SizedBox(
                            //   height: height * 0.02,
                            // ),
                            Expanded(
                              child: Container(
                                  height: height,
                                  width: width,
                                  color: MyThemeData.background,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("category")
                                            .doc(widget.model.categoryID)
                                            .collection("playlist")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? snapshot.data != null
                                                  ? snapshot.data!.docs.isEmpty
                                                      ? const Center(
                                                          child: Text(
                                                            "No video",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      : GridView.builder(
                                                          itemCount: snapshot
                                                              .data!
                                                              .docs
                                                              .length,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            mainAxisExtent: 180,
                                                            crossAxisSpacing:
                                                                20,
                                                            mainAxisSpacing: 0,
                                                          ),
                                                          itemBuilder:
                                                              (context, index) {
                                                            PlayListModel
                                                                model =
                                                                PlayListModel(
                                                              duration: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "duration"),
                                                              categoryID: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "categoryID"),
                                                              videoDescription:
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "videoDescription"),
                                                              videoID: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "videoID"),
                                                              videoName: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "videoName"),
                                                              videoURL: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "videoURL"),
                                                              viewers: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "viewers"),
                                                            );
                                                            return Stack(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      height,
                                                                  width: width,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Card(
                                                                        elevation:
                                                                            5,
                                                                        color: Colors
                                                                            .transparent,
                                                                        shadowColor:
                                                                            MyThemeData.onSurface,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            // Navigator.push(
                                                                            //     context,
                                                                            //     MaterialPageRoute(
                                                                            //       builder: (context) => VideoPlayerScreen(videooo: model),
                                                                            //     ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                height * 0.13,
                                                                            width:
                                                                                width,
                                                                            foregroundDecoration:
                                                                                BoxDecoration(
                                                                              color: Colors.black.withOpacity(0.2),
                                                                              borderRadius: BorderRadius.circular(
                                                                                10,
                                                                              ),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child:
                                                                                CoverPlayer(
                                                                              ishomecontroller: false,
                                                                              issearchcontroller: false,
                                                                              istrainignCOntroller: false,
                                                                              isvideomodel: false,
                                                                              isIcon: true,
                                                                              playListModel: model,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 8.0),
                                                                        child:
                                                                            Text(
                                                                          model
                                                                              .videoName!,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.whitecolor,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 8.0),
                                                                        child:
                                                                            Text(
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          '${model.videoDescription} | intensity *',
                                                                          style:
                                                                              TextStyle(color: MyThemeData.whitecolor),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 8.0),
                                                                        child:
                                                                            Text(
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          '${model.viewers!.length} views',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                MyThemeData.greyColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          })
                                                  : Center(
                                                      child: WhiteSpinkitFlutter
                                                          .spinkit,
                                                    )
                                              : Center(
                                                  child: WhiteSpinkitFlutter
                                                      .spinkit,
                                                );
                                        }),
                                  )),
                            ),
                            // SizedBox(
                            //   height: height * 0.1,
                            // ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.04, top: height * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.07,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: width * 0.02),
                              child: Row(
                                children: [
                                  const Text(
                                    "Available Videos",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: height * 0.07,
                            // ),
                            // Text(
                            //   "Weekly plan",
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: width * 0.027,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: height * 0.05,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Column(
                            //       children: [
                            //         Text(
                            //           "Week 1: Meet the basics",
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: width * 0.017,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: height * 0.01,
                            //         ),
                            //         Container(
                            //           decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius:
                            //                   BorderRadius.circular(50)),
                            //           height: height * 0.005,
                            //           width: width * 0.04,
                            //         ),
                            //       ],
                            //     ),
                            //     Text(
                            //       "Week 2: Get your footing",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.017,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     Text(
                            //       "Week 3: Expand your style",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.017,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //     Text(
                            //       "Week 4: Challenge yourself",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: width * 0.017,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: height * 0.17,
                            ),

                            Expanded(
                                child: SizedBox(
                              height: height,
                              width: width,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("category")
                                      .doc(widget.model.categoryID)
                                      .collection("playlist")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? snapshot.data != null
                                            ? snapshot.data!.docs.isEmpty
                                                ? const Center(
                                                    child: Text(
                                                      "No video",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: snapshot
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      PlayListModel model =
                                                          PlayListModel(
                                                        duration: snapshot
                                                            .data!.docs[index]
                                                            .get("duration"),
                                                        categoryID: snapshot
                                                            .data!.docs[index]
                                                            .get("categoryID"),
                                                        videoDescription: snapshot
                                                            .data!.docs[index]
                                                            .get(
                                                                "videoDescription"),
                                                        videoID: snapshot
                                                            .data!.docs[index]
                                                            .get("videoID"),
                                                        videoName: snapshot
                                                            .data!.docs[index]
                                                            .get("videoName"),
                                                        videoURL: snapshot
                                                            .data!.docs[index]
                                                            .get("videoURL"),
                                                        viewers: snapshot
                                                            .data!.docs[index]
                                                            .get("viewers"),
                                                      );
                                                      return Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.02),
                                                        child: Stack(
                                                          children: [
                                                            SizedBox(
                                                              height: height,
                                                              width:
                                                                  width * 0.3,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Card(
                                                                    elevation:
                                                                        5,
                                                                    color: MyThemeData
                                                                        .background,
                                                                    shadowColor:
                                                                        MyThemeData
                                                                            .onSurface,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.27,
                                                                      width:
                                                                          width *
                                                                              0.3,
                                                                      foregroundDecoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          CoverPlayer(
                                                                        ishomecontroller:
                                                                            false,
                                                                        issearchcontroller:
                                                                            false,
                                                                        istrainignCOntroller:
                                                                            false,
                                                                        isvideomodel:
                                                                            false,
                                                                        isIcon:
                                                                            true,
                                                                        playListModel:
                                                                            model,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      model
                                                                          .videoName!,
                                                                      style: TextStyle(
                                                                          color: MyThemeData
                                                                              .whitecolor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    '${model.videoDescription} | intensity *',
                                                                    style: TextStyle(
                                                                        color: MyThemeData
                                                                            .whitecolor),
                                                                  ),
                                                                  Text(
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    '${model.viewers!.length} views',
                                                                    style:
                                                                        TextStyle(
                                                                      color: MyThemeData
                                                                          .greyColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    })
                                            : Center(
                                                child:
                                                    WhiteSpinkitFlutter.spinkit,
                                              )
                                        : Center(
                                            child: WhiteSpinkitFlutter.spinkit,
                                          );
                                  }),
                            )),
                            SizedBox(
                              height: height * 0.23,
                            ),
                          ],
                        ),
                      )),
          ],
        );
      }),
    );
  }
}
