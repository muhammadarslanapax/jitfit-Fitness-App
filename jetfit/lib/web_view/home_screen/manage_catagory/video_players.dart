import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/home_screen/manage_catagory/manage_catagory_controller.dart';
import 'package:jetfit/web_view/home_screen/manage_favourite/manage_favourite_controller.dart';
import 'package:jetfit/web_view/home_screen/add_category/video_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../models/add_category.dart';

////////////////////////////
class PlaylistPlayer extends StatefulWidget {
  final PlayListModel playListModel;

  const PlaylistPlayer({super.key, required this.playListModel});

  @override
  _PlaylistPlayerState createState() => _PlaylistPlayerState();
}

class _PlaylistPlayerState extends State<PlaylistPlayer> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(ManageCtagoryController());
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

  void updateseconds() async {
    await firebaseFirestore
        .collection("category")
        .doc(widget.playListModel.categoryID)
        .collection("playlist")
        .doc(widget.playListModel.videoID)
        .update({
      'duration':
          '${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}'
    });
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.02,
              ),
              Container(
                width: width * 0.1,
                color: Colors.grey,
                height: height * 0.12,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      updateseconds();

                      return AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(_videoPlayerController!),
                            if (!_isVideoPlaying)
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              VideoPlayerScreen(
                                            videooo:
                                                widget.playListModel.videoURL!,
                                          ),
                                        ));
                                  },
                                  child: const Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: height * 0.03,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                ),
                                child: Center(
                                  child: Text(
                                    '${_videoPlayerController!.value.position.inMinutes}:${(_videoPlayerController!.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
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
                  },
                ),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height * 0.11,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          ManageCtagoryController.my
                              .getviewers(widget.playListModel);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: MyThemeData.background,
                              size: 20,
                            ),
                            Text(
                              '${widget.playListModel.viewers!.length}',
                              style: TextStyle(
                                  color: MyThemeData.background,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ///////////////////////////
                      Text(
                        widget.playListModel.videoName!,
                        style: TextStyle(
                            color: MyThemeData.background,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.playListModel.videoDescription!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //////////////////
              WebButton(
                  text: "Edit",
                  color: MyThemeData.background,
                  onPressed: () {
                    ManageCtagoryController.my
                        .editvideoclick(widget.playListModel);
                  },
                  width: width * 0.08),
              SizedBox(
                width: width * 0.02,
              ),
              WebButton(
                text: "Delete",
                color: MyThemeData.background,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete this Video?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              ManageCtagoryController.my.deletevideo(
                                  widget.playListModel.categoryID!,
                                  widget.playListModel.videoID!,
                                  context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyThemeData.background,
                            ),
                            child: const Text('Delete'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyThemeData.redColour,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                width: width * 0.07,
              ),
              SizedBox(
                width: width * 0.07,
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class EditVideoWork extends StatefulWidget {
  final PlayListModel playListModel;

  const EditVideoWork({super.key, required this.playListModel});

  @override
  _EditVideoWorkState createState() => _EditVideoWorkState();
}

class _EditVideoWorkState extends State<EditVideoWork> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(ManageCtagoryController());
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.playListModel.videoURL!));
    _initializeVideoPlayerFuture =
        _videoPlayerController!.initialize().then((_) {
      setState(
          () {}); // Ensure the player is initialized before calling setState
    });
    _videoPlayerController!.addListener(videoPlayerListener);
  }

  void videoPlayerListener() {
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
    return Center(
      child: Container(
        width: width * 0.25,
        height: height * 0.18,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(_videoPlayerController!),
                      if (!_isVideoPlaying)
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
                                      videooo: widget.playListModel.videoURL!,
                                    ),
                                  ));
                            },
                            child: const Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              '${_videoPlayerController!.value.position.inMinutes}:${(_videoPlayerController!.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  width: width * 0.25,
                  height: height * 0.18,
                  child: Center(
                    child: SpinkitFlutter.spinkit,
                  ),
                );
              }
            }),
      ),
    );
  }
}

////////////////////////
class FavouritePlaylistPlayer extends StatefulWidget {
  VideossModel model;
  String uid;
  FavouritePlaylistPlayer({super.key, required this.model, required this.uid});

  @override
  State<FavouritePlaylistPlayer> createState() =>
      _FavouritePlaylistPlayerState();
}

class _FavouritePlaylistPlayerState extends State<FavouritePlaylistPlayer> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(ManageFAvouriteController());
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.model.videoURL!));
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.02,
              ),
              Container(
                width: width * 0.1,
                color: Colors.grey,
                height: height * 0.12,
                child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(_videoPlayerController!),
                              if (!_isVideoPlaying)
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScreen(
                                              videooo: widget.model.videoURL!,
                                            ),
                                          ));
                                    },
                                    child: const Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: height * 0.03,
                                  width: width * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${_videoPlayerController!.value.position.inMinutes}:${(_videoPlayerController!.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
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
                    }),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              //////////////////
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height * 0.11,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///////////////////////////
                      Text(
                        widget.model.videoName!,
                        style: TextStyle(
                            color: MyThemeData.background,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.model.videoDescription!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              WebButton(
                text: "Delete Favourite",
                color: MyThemeData.background,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm Delete'),
                        content: const Text(
                            'Are you sure you want to delete this Favourite Video?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              ManageFAvouriteController.my.deleteUser(
                                  widget.uid, widget.model.videoID!, context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyThemeData.background,
                            ),
                            child: const Text('Delete'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyThemeData.redColour,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
                  );
                },
                width: width * 0.1,
              ),
              SizedBox(
                width: width * 0.07,
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
