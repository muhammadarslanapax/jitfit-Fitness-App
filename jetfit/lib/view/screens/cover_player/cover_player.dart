import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/favourite_controller.dart';
import 'package:jetfit/controllers/training_controller.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/challenge/challenge_screen.dart';
import 'package:jetfit/view/screens/home01/home01_controller.dart';
import 'package:jetfit/view/screens/search/search_controller.dart';
import 'package:jetfit/web_view/home_screen/manage_profile/manage_profile_controller.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:video_player/video_player.dart';

class CoverPlayer extends StatefulWidget {
  PlayListModel? playListModel;
  final bool? isIcon;
  final bool? istrainignCOntroller;
  final bool? issearchcontroller;
  final bool? ishomecontroller;
  final VideossModel? videoModal;
  bool? isvideomodel;

  CoverPlayer(
      {super.key,
      this.playListModel,
      this.isIcon = true,
      required this.isvideomodel,
      required this.istrainignCOntroller,
      required this.issearchcontroller,
      required this.ishomecontroller,
      this.videoModal});

  @override
  _CoverPlayerState createState() => _CoverPlayerState();
}

class _CoverPlayerState extends State<CoverPlayer> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(Home01Controller());
    Get.put(DashBoardController());
    Get.put(FavouriteController());
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        widget.isvideomodel == true
            ? widget.videoModal!.videoURL!
            : widget.playListModel!.videoURL!));
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

  void _disposeControllers() {
    _videoPlayerController!.dispose();
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
    _disposeControllers();
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
                              // print(
                              //     "uiuegrwyiegruwey  ${widget.istrainignCOntroller}");
                              // print(
                              //     "uiuegrwyiegruwey  ${widget.issearchcontroller}");
                              if (widget.isvideomodel == true) {
///////////////////////////

                                if (widget.istrainignCOntroller!) {
                                  if (widget.videoModal!.videotype! ==
                                      "Premium") {
                                    if (Staticdata.ispremium!) {
                                      Home01Controller.my.singlevideoview(
                                        widget.videoModal!.videoID!,
                                        Staticdata.uid!,
                                      );
                                      Staticdata.videoModal = widget.videoModal;
                                      Staticdata.isvideomodel = true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChallengeScreen(
                                                    videoModel:
                                                        widget.videoModal!),
                                          ));
                                    } else {
                                      TrainingController.to.premiumClickModel(
                                          widget.videoModal!);
                                    }
                                  } else if (widget.videoModal!.videotype! ==
                                      "Exclusive") {
                                    // exclusive logic here
                                    TrainingController.to.exclusiveClickModel(
                                        widget.videoModal!);
                                  } else {
                                    Home01Controller.my.singlevideoview(
                                      widget.videoModal!.videoID!,
                                      Staticdata.uid!,
                                    );
                                    Staticdata.videoModal = widget.videoModal;
                                    Staticdata.isvideomodel = true;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChallengeScreen(
                                              videoModel: widget.videoModal!),
                                        ));
                                  }

/////////////////////////////////////////////////
                                } else if (widget.ishomecontroller!) {
                                  print(
                                      "uiuegrwyiegruwey  ${widget.ishomecontroller}");
                                  if (widget.videoModal!.videotype! ==
                                      "Premium") {
                                    if (Staticdata.ispremium!) {
                                      Home01Controller.my.singlevideoview(
                                        widget.videoModal!.videoID!,
                                        Staticdata.uid!,
                                      );
                                      Staticdata.videoModal = widget.videoModal;
                                      Staticdata.isvideomodel = true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChallengeScreen(
                                                    videoModel:
                                                        widget.videoModal!),
                                          ));
                                    } else {
                                      Home01Controller.my.premiumClickModel(
                                          widget.videoModal!);
                                    }
                                  } else if (widget.videoModal!.videotype! ==
                                      "Exclusive") {
                                    // exclusive logic here
                                    Home01Controller.my.exclusiveClickModel(
                                        widget.videoModal!);
                                  } else {
                                    Home01Controller.my.singlevideoview(
                                      widget.videoModal!.videoID!,
                                      Staticdata.uid!,
                                    );
                                    Staticdata.videoModal = widget.videoModal;
                                    Staticdata.isvideomodel = true;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChallengeScreen(
                                              videoModel: widget.videoModal!),
                                        ));
                                  }

/////////////////////////////////////////////////
                                } else if (widget.issearchcontroller!) {
                                  if (widget.videoModal!.videotype! ==
                                      "Premium") {
                                    if (Staticdata.ispremium!) {
                                      Home01Controller.my.singlevideoview(
                                        widget.videoModal!.videoID!,
                                        Staticdata.uid!,
                                      );
                                      Staticdata.videoModal = widget.videoModal;
                                      Staticdata.isvideomodel = true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChallengeScreen(
                                                    videoModel:
                                                        widget.videoModal!),
                                          ));
                                    } else {
                                      VideoSearchController.instance
                                          .premiumClickModel(
                                              widget.videoModal!);
                                    }
                                  } else if (widget.videoModal!.videotype! ==
                                      "Exclusive") {
                                    // exclusive logic here
                                    VideoSearchController.instance
                                        .exclusiveClickModel(
                                            widget.videoModal!);
                                  } else {
                                    Home01Controller.my.singlevideoview(
                                      widget.videoModal!.videoID!,
                                      Staticdata.uid!,
                                    );
                                    Staticdata.videoModal = widget.videoModal;
                                    Staticdata.isvideomodel = true;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChallengeScreen(
                                              videoModel: widget.videoModal!),
                                        ));
                                  }
                                }

/////////////////////////////////////// end
                              } else {
                                Home01Controller.my.videoview(
                                  widget.playListModel!.categoryID!,
                                  widget.playListModel!.videoID!,
                                  Staticdata.uid!,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(
                                          videooo: widget.playListModel),
                                    ));
                              }

                              print('object');
                            },
                            child: widget.isIcon == true
                                ? Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : SizedBox()),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return widget.isIcon == true
                ? Container()
                : Center(child: WhiteSpinkitFlutter.spinkit);
          }
        },
      );
    });
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
class VideoPlayerScreen extends StatefulWidget {
  final videooo;

  const VideoPlayerScreen({super.key, required this.videooo});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  var height, width;

  VideoPlayerController? videoplayerController;
  VideoPlayerController? videoThumbnailController;
  Future<void>? _initializeVideoPlayerFuture;
  VideoModel? model;
  bool isclick = false;
  bool playaudio = false;
  String? time;
  String? uRL;

  Future<VideoModel> video() async {
    setState(() {
      model = VideoModel.fromMap(widget.videooo.toMap());
      print("model $model");
    });
    return model!;
  }

  void _disposeControllers() {
    videoplayerController?.dispose();
    videoThumbnailController!.dispose();
  }

  @override
  void initState() {
    Get.put(DashBoardController());
    video().then((value) {
      videoplayerController =
          VideoPlayerController.networkUrl(Uri.parse(value.videoURL!));

      videoThumbnailController =
          VideoPlayerController.networkUrl(Uri.parse(value.videoURL!));
      videoThumbnailController!.initialize().then((_) {
        setState(() {
          // Ensure the first frame is shown for the video thumbnail
          videoThumbnailController!.setVolume(0.0);
          videoThumbnailController!.play();
        });
      });

      _initializeVideoPlayerFuture =
          videoplayerController!.initialize().then((value) {
        setState(() {
          videoplayerController!.play();
        });
        videoplayerController!.addListener(() {
          setState(() {
            time =
                '${videoplayerController!.value.position.inMinutes}:${(videoplayerController!.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${videoplayerController!.value.duration.inMinutes}:${(videoplayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}';
          });
        });
      });
    });
    super.initState();
  }

  void _restartVideo() {
    if (videoplayerController!.value.isInitialized) {
      if (videoplayerController!.value.isPlaying) {
        // Pause and seek to the beginning if the video is playing
        videoplayerController!.pause();
        videoplayerController!.seekTo(Duration.zero);
      } else {
        // If not playing, just seek to the beginning
        videoplayerController!.seekTo(Duration.zero);
      }
      videoplayerController!.play(); // Play the video
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (videoplayerController != null &&
                videoplayerController!.value.isPlaying ||
            videoThumbnailController != null &&
                videoThumbnailController!.value.isPlaying) {
          videoplayerController!.pause();
          videoThumbnailController!.pause();
        }
        return true;
      },
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: [
                Container(
                    height: height,
                    width: width,
                    color: MyThemeData.background,
                    child: orientation == Orientation.portrait
                        ? Stack(
                            children: [
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          isclick = !isclick;
                                          print(isclick);
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          playaudio == true
                                              ? Center(
                                                  child: Container(
                                                    height: height * 0.25,
                                                    width: width * 0.6,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: AspectRatio(
                                                          aspectRatio:
                                                              videoThumbnailController!
                                                                  .value
                                                                  .aspectRatio,
                                                          child: VideoPlayer(
                                                              videoThumbnailController!),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: AspectRatio(
                                                    aspectRatio:
                                                        videoplayerController!
                                                            .value.aspectRatio,
                                                    child: VideoPlayer(
                                                        videoplayerController!),
                                                  ),
                                                ),
                                          isclick == false
                                              ? SizedBox()
                                              : Container(
                                                  height: height,
                                                  width: width,
                                                  color: MyThemeData.background
                                                      .withOpacity(0.3),
                                                ),
                                          playaudio == true
                                              ? SizedBox()
                                              : isclick == false
                                                  ? SizedBox()
                                                  : Center(
                                                      child: IconButton(
                                                        icon: Icon(
                                                          videoplayerController!
                                                                  .value
                                                                  .isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                          color: Colors.white,
                                                          size: 40,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (videoplayerController!
                                                                .value
                                                                .isPlaying) {
                                                              videoplayerController!
                                                                  .pause();
                                                            } else {
                                                              videoplayerController!
                                                                  .play();
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                        child: WhiteSpinkitFlutter.spinkit);
                                  }
                                },
                              ),
                              isclick == false
                                  ? SizedBox()
                                  : Padding(
                                      padding:
                                          EdgeInsets.only(bottom: height * 0.1),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          height: height * 0.1,
                                          width: width * 0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.videooo.videoName
                                                        .toString(),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.04),
                                                  ),
                                                  Text(
                                                    widget.videooo
                                                        .videoDescription
                                                        .toString(),
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  playaudio == true
                                                      ? Expanded(
                                                          child: SizedBox(
                                                            height:
                                                                height * 0.18,
                                                            width: width * 0.9,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                // SizedBox(
                                                                //   width: width *
                                                                //       0.25,
                                                                // ),

                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      playaudio =
                                                                          false;
                                                                      _restartVideo();
                                                                    });
                                                                  },
                                                                  child:
                                                                      ColoredCircleImageContainer(
                                                                    height:
                                                                        height,
                                                                    width:
                                                                        width,
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    path:
                                                                        "images/switch.png",
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (videoplayerController!
                                                                        .value
                                                                        .isInitialized) {
                                                                      // Seek backward by 10 seconds
                                                                      final currentPosition = videoplayerController!
                                                                          .value
                                                                          .position;
                                                                      final newDuration =
                                                                          currentPosition -
                                                                              Duration(seconds: 10);
                                                                      videoplayerController!
                                                                          .seekTo(
                                                                              newDuration);
                                                                    }
                                                                  },
                                                                  child:
                                                                      ColoredCircleImageContainer(
                                                                    height:
                                                                        height,
                                                                    width:
                                                                        width,
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    path:
                                                                        "images/back.png",
                                                                  ),
                                                                ),

                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (videoplayerController!
                                                                          .value
                                                                          .isPlaying) {
                                                                        videoplayerController!
                                                                            .pause();
                                                                      } else {
                                                                        videoplayerController!
                                                                            .play();
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        height *
                                                                            0.1,
                                                                    width:
                                                                        width *
                                                                            0.17,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        videoplayerController!.value.isPlaying
                                                                            ? Icons.pause
                                                                            : Icons.play_arrow,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            35,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (videoplayerController!
                                                                        .value
                                                                        .isInitialized) {
                                                                      final currentPosition = videoplayerController!
                                                                          .value
                                                                          .position;
                                                                      final newDuration =
                                                                          currentPosition +
                                                                              Duration(seconds: 10);
                                                                      videoplayerController!
                                                                          .seekTo(
                                                                              newDuration);
                                                                    }
                                                                  },
                                                                  child:
                                                                      ColoredCircleImageContainer(
                                                                    height:
                                                                        height,
                                                                    width:
                                                                        width,
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    path:
                                                                        "images/next.png",
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    _restartVideo();
                                                                  },
                                                                  child:
                                                                      ColoredCircleImageContainer(
                                                                    height:
                                                                        height,
                                                                    width:
                                                                        width,
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    path:
                                                                        "images/loop.png",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      /////////////

                                                      : Expanded(
                                                          child: SizedBox(
                                                            height:
                                                                height * 0.18,
                                                            width: width * 0.9,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.25,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      playaudio =
                                                                          true;
                                                                      if (videoplayerController!
                                                                          .value
                                                                          .isPlaying) {
                                                                        videoplayerController!
                                                                            .pause();
                                                                        videoplayerController!
                                                                            .seekTo(Duration.zero);
                                                                        videoplayerController!
                                                                            .play();
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      ColoredCircleImageContainer(
                                                                    height:
                                                                        height,
                                                                    width:
                                                                        width,
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    path:
                                                                        "images/music (2).png",
                                                                  ),
                                                                ),
                                                                ColoredCircleImageContainer(
                                                                  height:
                                                                      height,
                                                                  width: width,
                                                                  borderColor:
                                                                      Colors
                                                                          .grey,
                                                                  path:
                                                                      "images/subtitle.png",
                                                                ),
                                                                ColoredCircleImageContainer(
                                                                  height:
                                                                      height,
                                                                  width: width,
                                                                  borderColor:
                                                                      Colors
                                                                          .grey,
                                                                  path:
                                                                      "images/settings_24px.png",
                                                                ),
                                                                Center(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      videoplayerController!
                                                                          .pause();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height: height *
                                                                          0.045,
                                                                      width: width *
                                                                          0.25,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                      ),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          "End workout",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              isclick == false
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          height: height * 0.06,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  time.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: VideoProgressIndicator(
                                                  colors: VideoProgressColors(
                                                      playedColor:
                                                          Colors.white),
                                                  videoplayerController!,
                                                  allowScrubbing: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          )
                        : Stack(
                            children: [
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          isclick = !isclick;
                                          print(isclick);
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          playaudio == true
                                              ? Center(
                                                  child: Container(
                                                    height: height * 0.4,
                                                    width: width * 0.6,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Center(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: AspectRatio(
                                                          aspectRatio:
                                                              videoThumbnailController!
                                                                  .value
                                                                  .aspectRatio,
                                                          child: VideoPlayer(
                                                              videoThumbnailController!),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: AspectRatio(
                                                    aspectRatio:
                                                        videoplayerController!
                                                            .value.aspectRatio,
                                                    child: VideoPlayer(
                                                        videoplayerController!),
                                                  ),
                                                ),
                                          isclick == false
                                              ? SizedBox()
                                              : Expanded(
                                                  child: Container(
                                                    height: height,
                                                    width: width,
                                                    color: MyThemeData
                                                        .background
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
                                          playaudio == true
                                              ? SizedBox()
                                              : isclick == false
                                                  ? SizedBox()
                                                  : Center(
                                                      child: IconButton(
                                                        icon: Icon(
                                                          videoplayerController!
                                                                  .value
                                                                  .isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                          color: Colors.white,
                                                          size: 35,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (videoplayerController!
                                                                .value
                                                                .isPlaying) {
                                                              videoplayerController!
                                                                  .pause();
                                                            } else {
                                                              videoplayerController!
                                                                  .play();
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                        child: WhiteSpinkitFlutter.spinkit);
                                  }
                                },
                              ),
                              isclick == false
                                  ? SizedBox()
                                  : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: height * 0.15),
                                        child: SizedBox(
                                          height: height * 0.1,
                                          width: width * 0.9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.videooo.videoName
                                                          .toString(),
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              height * 0.04),
                                                    ),
                                                    Text(
                                                      widget.videooo
                                                          .videoDescription
                                                          .toString(),
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: height * 0.03,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              playaudio == true
                                                  ? Expanded(
                                                      child: SizedBox(
                                                        height: height * 0.18,
                                                        width: width * 0.9,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            // SizedBox(
                                                            //   width: width *
                                                            //       0.25,
                                                            // ),

                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  playaudio =
                                                                      false;
                                                                  _restartVideo();
                                                                });
                                                              },
                                                              child:
                                                                  ColoredCircleImageContainer(
                                                                height: height,
                                                                width: width,
                                                                borderColor:
                                                                    Colors.grey,
                                                                path:
                                                                    "images/switch.png",
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (videoplayerController!
                                                                    .value
                                                                    .isInitialized) {
                                                                  // Seek backward by 10 seconds
                                                                  final currentPosition =
                                                                      videoplayerController!
                                                                          .value
                                                                          .position;
                                                                  final newDuration =
                                                                      currentPosition -
                                                                          Duration(
                                                                              seconds: 10);
                                                                  videoplayerController!
                                                                      .seekTo(
                                                                          newDuration);
                                                                }
                                                              },
                                                              child:
                                                                  ColoredCircleImageContainer(
                                                                height: height,
                                                                width: width,
                                                                borderColor:
                                                                    Colors.grey,
                                                                path:
                                                                    "images/back.png",
                                                              ),
                                                            ),

                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (videoplayerController!
                                                                      .value
                                                                      .isPlaying) {
                                                                    videoplayerController!
                                                                        .pause();
                                                                  } else {
                                                                    videoplayerController!
                                                                        .play();
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                height: height *
                                                                    0.1,
                                                                width: width *
                                                                    0.17,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: Center(
                                                                  child: Icon(
                                                                    videoplayerController!
                                                                            .value
                                                                            .isPlaying
                                                                        ? Icons
                                                                            .pause
                                                                        : Icons
                                                                            .play_arrow,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (videoplayerController!
                                                                    .value
                                                                    .isInitialized) {
                                                                  final currentPosition =
                                                                      videoplayerController!
                                                                          .value
                                                                          .position;
                                                                  final newDuration =
                                                                      currentPosition +
                                                                          Duration(
                                                                              seconds: 10);
                                                                  videoplayerController!
                                                                      .seekTo(
                                                                          newDuration);
                                                                }
                                                              },
                                                              child:
                                                                  ColoredCircleImageContainer(
                                                                height: height,
                                                                width: width,
                                                                borderColor:
                                                                    Colors.grey,
                                                                path:
                                                                    "images/next.png",
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                _restartVideo();
                                                              },
                                                              child:
                                                                  ColoredCircleImageContainer(
                                                                height: height,
                                                                width: width,
                                                                borderColor:
                                                                    Colors.grey,
                                                                path:
                                                                    "images/loop.png",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  :
                                                  /////////////
                                                  Expanded(
                                                      child: SizedBox(
                                                        height: width * 0.18,
                                                        width: height,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  playaudio =
                                                                      true;
                                                                  if (videoplayerController!
                                                                      .value
                                                                      .isPlaying) {
                                                                    videoplayerController!
                                                                        .pause();
                                                                    videoplayerController!
                                                                        .seekTo(
                                                                            Duration.zero);
                                                                    videoplayerController!
                                                                        .play();
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                height: width *
                                                                    0.04,
                                                                width: height *
                                                                    0.07,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                child: const Center(
                                                                    child: Image(
                                                                        image: AssetImage(
                                                                            "images/music (2).png"))),
                                                              ),
                                                            ),
                                                            Container(
                                                              height:
                                                                  width * 0.04,
                                                              width:
                                                                  height * 0.07,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              child: const Center(
                                                                  child: Image(
                                                                      image: AssetImage(
                                                                          "images/subtitle.png"))),
                                                            ),
                                                            Container(
                                                              height:
                                                                  width * 0.04,
                                                              width:
                                                                  height * 0.07,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              child: const Center(
                                                                  child: Image(
                                                                      image: AssetImage(
                                                                          "images/settings_24px.png"))),
                                                            ),
                                                            Center(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  videoplayerController!
                                                                      .pause();
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      width *
                                                                          0.045,
                                                                  width:
                                                                      height *
                                                                          0.25,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "End workout",
                                                                    ),
                                                                  ),
                                                                ),
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
                              isclick == false
                                  ? SizedBox()
                                  : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                        width: width * 0.9,
                                        height: height * 0.1,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                time.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: VideoProgressIndicator(
                                                colors: VideoProgressColors(
                                                    playedColor: Colors.white),
                                                videoplayerController!,
                                                allowScrubbing: true,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                            ],
                          )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ColoredCircleImageContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color borderColor;
  final String path;

  const ColoredCircleImageContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.borderColor,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
        height: orientation == Orientation.landscape
            ? height * 0.07
            : height * 0.04,
        width: width * 0.07,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Image(
            image: AssetImage(path),
          ),
        ),
      );
    });
  }
}
