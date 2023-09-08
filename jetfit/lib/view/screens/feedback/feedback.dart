// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';

import '../favourite/playlist/view_playlist_controller.dart';

class FeedbackProgram extends StatefulWidget {
  CategoryModel model;
  FeedbackProgram({
    super.key,
    required this.model,
  });

  @override
  State<FeedbackProgram> createState() => _FeedbackProgramState();
}

class _FeedbackProgramState extends State<FeedbackProgram> {
  TextEditingController descriptioncontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var height, width;
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadVideo(XFile file, String playlistid) async {
    Uint8List bytes = await file.readAsBytes();
    Reference storageRef = storage
        .ref()
        .child('category/${widget.model.categoryID}/feedback/$playlistid');
    TaskSnapshot uploadTask = await storageRef.putData(bytes);
    String url = await uploadTask.ref.getDownloadURL();

    // playlistloading = false;
    // update();
    return url;
  }

  bool loading = false;
  void postfeedback() async {
    String id = Uuid().v4();
    if (_pickedImage != null || _pickedVideo != null) {
      if (_pickedImage != null) {
        imageurl = await uploadVideo(_pickedImage!, id);
        print("imageURl ${imageurl}");
        FeedbackModel model = FeedbackModel(
            status: 'private',
            name: Staticdata.userModel!.name!,
            profileimageurl: Staticdata.userModel!.imageURL!,
            description: descriptioncontroller.text,
            id: id,
            playlistid: widget.model.categoryID!,
            imageurl: imageurl!,
            videourl: null);
        await FirebaseFirestore.instance
            .collection("category")
            .doc(widget.model.categoryID!)
            .collection("feedback")
            .doc(id)
            .set(model.toMap());
      } else if (_pickedVideo != null) {
        videourl = await uploadVideo(_pickedVideo!, id);
        print("videourl ${videourl}");
        FeedbackModel model = FeedbackModel(
            status: 'private',
            name: Staticdata.userModel!.name!,
            profileimageurl: Staticdata.userModel!.imageURL!,
            description: descriptioncontroller.text,
            id: id,
            playlistid: widget.model.categoryID!,
            imageurl: null,
            videourl: videourl!);
        await FirebaseFirestore.instance
            .collection("category")
            .doc(widget.model.categoryID!)
            .collection("feedback")
            .doc(id)
            .set(model.toMap());
      }

      setState(() {
        loading = false;
      });
    } else {
      showtoast("plaese upload video or photo");
      setState(() {
        loading = false;
      });
    }
  }

  String? imageurl;
  String? videourl;
  XFile? _pickedImage;
  XFile? _pickedVideo;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyThemeData.background,
        title: Text(
          "Feedback",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return GetBuilder<ViewPlaylistController>(initState: (state) {
          // Get.put(ViewPlaylistController());
          // ViewPlaylistController.instance.isclick = false;
        }, builder: (obj) {
          return Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("category")
                      .doc(widget.model.categoryID!)
                      .collection("feedback")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: width,
                        height: height,
                        child: Center(
                          child: WhiteSpinkitFlutter.spinkit,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Container(
                        height: height,
                        width: width,
                        child: Center(
                          child: Text(
                            "No Feedback",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: height,
                        width: width,
                        color: MyThemeData.background,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              FeedbackModel model = FeedbackModel(
                                  status:
                                      snapshot.data!.docs[index].get("status"),
                                  name: snapshot.data!.docs[index].get("name"),
                                  profileimageurl: snapshot.data!.docs[index]
                                      .get("profileimageurl"),
                                  description: snapshot.data!.docs[index]
                                      .get("description"),
                                  id: snapshot.data!.docs[index].get("id"),
                                  playlistid: snapshot.data!.docs[index]
                                      .get("playlistid"),
                                  imageurl: snapshot.data!.docs[index]
                                      .get("imageurl"),
                                  videourl: snapshot.data!.docs[index]
                                      .get("videourl"));
                              return snapshot.data!.docs[index].get("status") ==
                                      "public"
                                  ? Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Card(
                                        elevation: 5,
                                        shadowColor: MyThemeData.onSurface,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          height: height * 0.35,
                                          width: width * 0.9,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyThemeData.background,
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: model
                                                            .profileimageurl !=
                                                        ''
                                                    ? Card(
                                                        elevation: 5,
                                                        shadowColor: MyThemeData
                                                            .onSurface,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                NetworkImage(model
                                                                    .profileimageurl!),
                                                          ),
                                                        ),
                                                      )
                                                    : Card(
                                                        elevation: 5,
                                                        shadowColor: MyThemeData
                                                            .onSurface,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "images/man.png"),
                                                          ),
                                                        ),
                                                      ),
                                                title: Text(
                                                  model.name!,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                subtitle: Text(
                                                  model.description!,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.15,
                                                width: width,
                                                child: model.imageurl != null
                                                    ? Image.network(model
                                                        .imageurl
                                                        .toString())
                                                    : model.videourl != null
                                                        ? FeedbackCoverPlayer(
                                                            isIcon: true,
                                                            video:
                                                                model.videourl)
                                                        : model.imageurl ==
                                                                    null &&
                                                                model.videourl ==
                                                                    null
                                                            ? Center(
                                                                child: Text(
                                                                "Empty",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ))
                                                            : SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            }),
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Card(
                    elevation: 5,
                    shadowColor: MyThemeData.onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: FloatingActionButton(
                      backgroundColor: MyThemeData.background,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _pickedVideo = null;
                          _pickedImage = null;
                          descriptioncontroller.clear();
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Form(
                              key: formkey,
                              child: AlertDialog(
                                backgroundColor: MyThemeData.background,
                                title: Text('Feedback',
                                    style: TextStyle(color: Colors.white)),
                                content: StatefulBuilder(
                                  builder: (context, setState) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    MyThemeData.background,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.image,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          'Pick Image',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.033,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                          final pickedImage =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                          setState(() {
                                                            _pickedImage =
                                                                pickedImage;
                                                            _pickedVideo = null;
                                                          });
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.video_library,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          'Pick Video',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.033,
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          Navigator.pop(
                                                              context);
                                                          final pickedVideo =
                                                              await ImagePicker()
                                                                  .pickVideo(
                                                                      source: ImageSource
                                                                          .gallery);
                                                          setState(() {
                                                            _pickedVideo =
                                                                pickedVideo;
                                                            _pickedImage = null;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: _pickedImage != null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        MyThemeData.primary80,
                                                    radius: 50,
                                                    backgroundImage: FileImage(
                                                        File(_pickedImage!
                                                            .path)),
                                                  )
                                                : _pickedVideo != null
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            MyThemeData
                                                                .onSurfaceVarient,
                                                        radius: 50,
                                                        child: Icon(
                                                            Icons.play_arrow),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            MyThemeData
                                                                .onSurfaceVarient,
                                                        radius: 50,
                                                        child: Icon(
                                                          Icons.photo_camera,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          ),
                                          TextFormField(
                                            controller: descriptioncontroller,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLines: 5,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.033,
                                            ),
                                            autofillHints: const [
                                              AutofillHints.name
                                            ],
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: MyThemeData.background,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  width: 2,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  width: 2,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 2),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              hintText: 'Description',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: width * 0.033,
                                              ),
                                            ),
                                            validator: (String? v) {
                                              if (v!.isEmpty) {
                                                return 'Required Field';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.033,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        Navigator.pop(context);
                                        postfeedback();
                                      }
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.033,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              loading == true
                  ? Container(
                      height: height,
                      width: width,
                      color: Colors.white.withOpacity(0.2),
                      child: const Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        });
      }),
    );
  }
}

class FeedbackModel {
  final String? name;
  final String? profileimageurl;
  final String? description;
  final String? id;
  final String? playlistid;
  final String? imageurl;
  final String? videourl;
  final String? status;
  FeedbackModel({
    required this.name,
    required this.profileimageurl,
    required this.description,
    required this.id,
    required this.playlistid,
    required this.imageurl,
    required this.videourl,
    required this.status,
  });

  FeedbackModel copyWith({
    String? name,
    String? profileimageurl,
    String? description,
    String? id,
    String? playlistid,
    String? imageurl,
    String? videourl,
    String? status,
  }) {
    return FeedbackModel(
      name: name ?? this.name,
      profileimageurl: profileimageurl ?? this.profileimageurl,
      description: description ?? this.description,
      id: id ?? this.id,
      playlistid: playlistid ?? this.playlistid,
      imageurl: imageurl ?? this.imageurl,
      videourl: videourl ?? this.videourl,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profileimageurl': profileimageurl,
      'description': description,
      'id': id,
      'playlistid': playlistid,
      'imageurl': imageurl,
      'videourl': videourl,
      'status': status,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      name: map['name'] as String,
      profileimageurl: map['profileimageurl'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      playlistid: map['playlistid'] as String,
      imageurl: map['imageurl'] as String,
      videourl: map['videourl'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedbackModelModel(name: $name, profileimageurl: $profileimageurl, description: $description, id: $id, playlistid: $playlistid, imageurl: $imageurl, videourl: $videourl, status: $status)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profileimageurl == profileimageurl &&
        other.description == description &&
        other.id == id &&
        other.playlistid == playlistid &&
        other.imageurl == imageurl &&
        other.videourl == videourl &&
        other.status == status;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profileimageurl.hashCode ^
        description.hashCode ^
        id.hashCode ^
        playlistid.hashCode ^
        imageurl.hashCode ^
        videourl.hashCode ^
        status.hashCode;
  }
}

class FeedbackCoverPlayer extends StatefulWidget {
  String? video;
  final bool? isIcon;

  FeedbackCoverPlayer({
    super.key,
    this.video,
    this.isIcon = true,
  });

  @override
  _FeedbackCoverPlayerState createState() => _FeedbackCoverPlayerState();
}

class _FeedbackCoverPlayerState extends State<FeedbackCoverPlayer> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video!));
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
    return Expanded(
      flex: 1,
      child: FutureBuilder(
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
                                    builder: (context) =>
                                        FeedbackVideoPlayerScreen(
                                      videooo: widget.video!,
                                    ),
                                  ));
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
            return Center(
              child: SpinkitFlutter.spinkit,
            );
          }
        },
      ),
    );
  }
}

class FeedbackVideoPlayerScreen extends StatefulWidget {
  String videooo;

  FeedbackVideoPlayerScreen({super.key, required this.videooo});

  @override
  State<FeedbackVideoPlayerScreen> createState() =>
      _FeedbackVideoPlayerScreenState();
}

class _FeedbackVideoPlayerScreenState extends State<FeedbackVideoPlayerScreen> {
  var height, width;

  VideoPlayerController? videoplayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool isclick = false;
  String? time;

  void _disposeControllers() {
    videoplayerController?.dispose();
  }

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
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
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
                                          aspectRatio: videoplayerController!
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
                                          aspectRatio: videoplayerController!
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
      }),
    );
  }
}
