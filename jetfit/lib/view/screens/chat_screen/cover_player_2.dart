import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/home01/home01_controller.dart';
import 'package:jetfit/web_view/home_screen/manage_profile/manage_profile_controller.dart';
import 'package:video_player/video_player.dart';

class CoverPlayer2 extends StatefulWidget {
  final bool? isIcon;
  final String? url;

  CoverPlayer2({
    super.key,
    this.isIcon = true,
    this.url,
  });

  @override
  _CoverPlayer2State createState() => _CoverPlayer2State();
}

class _CoverPlayer2State extends State<CoverPlayer2> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(Home01Controller());
    Get.put(DashBoardController());
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url!));
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

                              
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPLayerChat(
                        videooo: widget.url,
                      ),
                    ));
              
                              // url   player screen
            
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
class VideoPLayerChat extends StatefulWidget {
  final videooo;

  const VideoPLayerChat({super.key, required this.videooo});

  @override
  State<VideoPLayerChat> createState() => _VideoPLayerChatState();
}

class _VideoPLayerChatState extends State<VideoPLayerChat> {
  var height, width;

  VideoPlayerController? videoplayerController;
  Future<void>? _initializeVideoPlayerFuture;
  VideoModel? model;
  bool isclick = false;
  String? time;
  String? uRL;

  void _disposeControllers() {
    videoplayerController?.dispose();
  }

  @override
  void initState() {
    Get.put(DashBoardController());
    videoplayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videooo!));

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

    super.initState();
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
            videoplayerController!.value.isPlaying) {
          videoplayerController!.pause();
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
                                          Center(
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
                                          isclick == false
                                              ? SizedBox()
                                              : Center(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      videoplayerController!
                                                              .value.isPlaying
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (videoplayerController!
                                                            .value.isPlaying) {
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
                                          Center(
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
                                          isclick == false
                                              ? SizedBox()
                                              : Center(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      videoplayerController!
                                                              .value.isPlaying
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (videoplayerController!
                                                            .value.isPlaying) {
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
