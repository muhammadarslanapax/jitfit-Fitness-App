import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videooo;

  const VideoPlayerScreen({super.key, required this.videooo});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? videoplayerController;
  String? time;
  bool isclick = false;
  Future<void>? _initializeVideoPlayerFuture;
  @override
  void initState() {
    videoplayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videooo));

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
    videoplayerController!.dispose();
    super.dispose();
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
                height: height,
                width: width,
                color: MyThemeData.background,
                child: Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
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
                                    aspectRatio: videoplayerController!
                                        .value.aspectRatio,
                                    child: VideoPlayer(videoplayerController!),
                                  ),
                                ),
                                isclick == false
                                    ? SizedBox()
                                    : Expanded(
                                        child: Container(
                                          height: height,
                                          width: width,
                                          color: MyThemeData.background
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
                                                videoplayerController!.pause();
                                              } else {
                                                videoplayerController!.play();
                                              }
                                            });
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: WhiteSpinkitFlutter.spinkit);
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
                                          color: Colors.white, fontSize: 12),
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
        ),
      ),
    );
  }
}
