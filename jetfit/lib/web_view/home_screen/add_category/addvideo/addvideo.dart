import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/home_screen/add_category/add_playlist/add_playlist_controller.dart';
import 'package:jetfit/web_view/home_screen/add_category/addvideo/add_video_controller.dart';
import 'package:jetfit/web_view/home_screen/add_category/video_player.dart';
import 'package:video_player/video_player.dart';

class AddVideo extends StatefulWidget {
  const AddVideo({super.key});

  @override
  State<AddVideo> createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  GlobalKey<FormState> videoformKey = GlobalKey<FormState>();
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<AddVideoController>(initState: (state) {
        Get.put(AddVideoController());
        print(
            "AddCtagoryController.my.instructormenuItems ${AddCtagoryController.my.instructormenuItems}|");
        AddVideoController.my.initstatefunctions();
      }, builder: (obj) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: width * 0.05),
                  width: width,
                  height: height * 0.1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ADD NEW VIDEO",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: height * 0.85,
                    width: width,
                    child: Form(
                      key: videoformKey,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                              child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.04,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          lableTextname("Category Type"),
                                          Container(
                                            width: width * 0.25,
                                            height: height * 0.07,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: MyThemeData.greyColor,
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.02),
                                              underline: Container(),
                                              value: obj.catagoryselectedValue,
                                              onChanged: (String? newValue) {
                                                obj.catagoryselectedValue =
                                                    newValue!;
                                                obj.update();
                                              },
                                              items: obj.catagorytypeitems.map<
                                                  DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          value,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.1,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ),
                                          lableTextname("Video Type"),
                                          Container(
                                            width: width * 0.25,
                                            height: height * 0.07,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: MyThemeData.greyColor,
                                              ),
                                            ),
                                            child: DropdownButton<String>(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.02),
                                              underline: Container(),
                                              value: obj.typeselectedvalue,
                                              onChanged: (String? newValue) {
                                                obj.typeselectedvalue =
                                                    newValue!;
                                                obj.update();
                                              },
                                              items: obj.typeitems.map<
                                                  DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          value,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.1,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ),
                                          obj.typeselectedvalue == "Exclusive"
                                              ? lableTextname("Price")
                                              : Container(
                                                  color: Colors.cyan,
                                                ),
                                          obj.typeselectedvalue == "Exclusive"
                                              ? SizedBox(
                                                  width: width * 0.25,
                                                  child: Textformfield(
                                                    controller: obj
                                                        .videopricecontroller,
                                                    abscureText: false,
                                                    keyboardtype:
                                                        TextInputType.name,
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.cyan,
                                                ),
                                          lableTextname("Set the filter tags"),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                lableTextname("Difficulty"),
                                                Container(
                                                  width: width * 0.15,
                                                  height: height * 0.07,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color:
                                                          MyThemeData.greyColor,
                                                    ),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.02),
                                                    underline: Container(),
                                                    value: obj
                                                        .difficultyselectedvalue,
                                                    onChanged:
                                                        (String? newValue) {
                                                      obj.difficultyselectedvalue =
                                                          newValue!;
                                                      obj.update();
                                                    },
                                                    items: obj
                                                        .difficultymenuItems
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                lableTextname("Class Type"),
                                                Container(
                                                  width: width * 0.15,
                                                  height: height * 0.07,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color:
                                                          MyThemeData.greyColor,
                                                    ),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.02),
                                                    underline: Container(),
                                                    value: obj
                                                        .classtypeselectedvalue,
                                                    onChanged:
                                                        (String? newValue) {
                                                      obj.classtypeselectedvalue =
                                                          newValue!;
                                                      obj.update();
                                                    },
                                                    items: obj
                                                        .classtypemenuItems
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                lableTextname("Instructor"),
                                                Container(
                                                  width: width * 0.15,
                                                  height: height * 0.07,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color:
                                                          MyThemeData.greyColor,
                                                    ),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.02),
                                                    underline: Container(),
                                                    value: obj
                                                        .instructorselectedvalue,
                                                    onChanged:
                                                        (String? newValue) {
                                                      obj.instructorselectedvalue =
                                                          newValue!;
                                                      obj.update();
                                                    },
                                                    items: obj
                                                        .instructormenuItems
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                lableTextname("Video Language"),
                                                Container(
                                                  width: width * 0.15,
                                                  height: height * 0.07,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 2,
                                                      color:
                                                          MyThemeData.greyColor,
                                                    ),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.02),
                                                    underline: Container(),
                                                    value: obj
                                                        .videolanguageselectedvalue,
                                                    onChanged:
                                                        (String? newValue) {
                                                      obj.videolanguageselectedvalue =
                                                          newValue!;
                                                      obj.update();
                                                    },
                                                    items: obj
                                                        .videolanguagemenuItems
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                obj.pickVideo();
                                              },
                                              child: obj.videofile == null
                                                  ? Container(
                                                      width: width * 0.25,
                                                      height: height * 0.18,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Image(
                                                            height:
                                                                height * 0.1,
                                                            width: width * 0.2,
                                                            image: const AssetImage(
                                                                'images/upload.png'),
                                                          ),
                                                          lableTextname(
                                                            "upload Video",
                                                          ),
                                                        ],
                                                      ))
                                                  : obj.playlistloading == true
                                                      ? Container(
                                                          width: width * 0.25,
                                                          height: height * 0.18,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 2,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child:
                                                                SpinkitFlutter
                                                                    .spinkit,
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Container(
                                                            width: width * 0.25,
                                                            height:
                                                                height * 0.18,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.1),
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    Colors.grey,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: obj.videoooourl ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : VideoPlayerWidget(
                                                                      videoURl: obj
                                                                          .videoooourl!,
                                                                      videoID: obj
                                                                          .videoID!),
                                                            ),
                                                          ),
                                                        )),
                                          lableTextname("Video Name"),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Textformfield(
                                              controller:
                                                  obj.videonamecontroller,
                                              abscureText: false,
                                              validation: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Video name';
                                                }
                                                return null; // input is valid
                                              },
                                              keyboardtype: TextInputType.name,
                                            ),
                                          ),
                                          lableTextname("Video Description"),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Textformfield(
                                              maxline: 4,
                                              controller: obj
                                                  .videodescriptioncontroller,
                                              abscureText: false,
                                              validation: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Video Description';
                                                }
                                                return null; // input is valid
                                              },
                                              keyboardtype: TextInputType.name,
                                            ),
                                          ),
                                          lableTextname(
                                              "Duration timeline for video"),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Textformfield(
                                              controller: obj
                                                  .categorydurationtimelinecontroller,
                                              abscureText: false,
                                              validation: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Duration';
                                                }
                                                return null; // input is valid
                                              },
                                              keyboardtype: TextInputType.name,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          WebButton(
                                            onPressed: () {
                                              if (obj.videofile != null &&
                                                  videoformKey.currentState!
                                                      .validate() &&
                                                  obj.playlistloading ==
                                                      false) {
                                                obj.uploadplaylistToDB(
                                                    obj.videoooourl!,
                                                    obj.videoID!);
                                                obj.update();
                                              } else {
                                                showtoast("fulfill all fields");
                                              }
                                            },
                                            text: 'Upload Video',
                                            color: MyThemeData.background,
                                            width: width * 0.25,
                                          ),
                                          SizedBox(
                                            height: height * 0.06,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                //////////////////////////////
                              ],
                            ),
                          )),
                          obj.uploadplaylistloading == true
                              ? Container(
                                  width: width,
                                  height: height,
                                  color: Colors.black.withOpacity(0.1),
                                  child: Center(
                                    child: SpinkitFlutter.spinkit,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
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
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoURl;
  final String videoID;

  const VideoPlayerWidget(
      {super.key, required this.videoURl, required this.videoID});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // void updateseconds() async {
  //   await firebaseFirestore.collection("videos").doc(widget.videoID).update({
  //     'duration':
  //         '${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}'
  //   });
  //   print(
  //       "seconds   : '${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}'");
  // }

  @override
  void initState() {
    Get.put(AddCtagoryController());
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURl));
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
            // updateseconds();
            return AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(_videoPlayerController!),
                  if (!_isVideoPlaying)
                    Center(
                      child: InkWell(
                        onTap: () {
                          AddCtagoryController.my.isvideoplayclick = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoPlayerScreen(videooo: widget.videoURl),
                              ));
                          AddCtagoryController.my.update();
                        },
                        child: const Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else {
            return SizedBox(
              width: width * 0.1,
              height: height * 0.12,
              child: Center(
                child: SpinkitFlutter.spinkit,
              ),
            );
          }
        });
  }
}
