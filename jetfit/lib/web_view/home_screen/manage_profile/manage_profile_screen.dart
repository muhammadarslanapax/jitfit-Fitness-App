import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/auth/login_screen/login.dart';
import 'package:jetfit/web_view/home_screen/manage_catagory/manage_catagory_controller.dart';
import 'package:jetfit/web_view/home_screen/manage_profile/manage_profile_controller.dart';
import 'package:jetfit/web_view/home_screen/add_category/video_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class MangeProfileScreen extends StatefulWidget {
  const MangeProfileScreen({super.key});

  @override
  State<MangeProfileScreen> createState() => _MangeProfileScreenState();
}

class _MangeProfileScreenState extends State<MangeProfileScreen> {
  GlobalKey<FormState> profileformkey = GlobalKey<FormState>();
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<ManageProfileController>(initState: (state) {
        Get.put(ManageProfileController());
        ManageProfileController.my.assignValues();
      }, builder: (obj) {
        return Form(
          key: profileformkey,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: width * 0.05),
                    width: width,
                    height: height * 0.1,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "MANAGE PRFILE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.08),
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: width,
                      height: height * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //......................................................................................
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.03,
                                    ),
                                    Text(
                                      "MY PROFILE",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: MyThemeData.background,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: height * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: ClipOval(
                                            child: obj.profileImage == null
                                                ? Staticdata.adminmodel!
                                                            .imageURL !=
                                                        null
                                                    ? Image.network(
                                                        Staticdata.adminmodel!
                                                            .imageURL!,
                                                        fit: BoxFit.cover,
                                                        width: 120,
                                                        height: 120,
                                                      )
                                                    : Container(
                                                        width: 120,
                                                        height: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade400,
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "no image",
                                                          ),
                                                        ),
                                                      )
                                                : FutureBuilder(
                                                    future: obj.profileImage!
                                                        .readAsBytes(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Image.memory(
                                                          snapshot.data!,
                                                          fit: BoxFit.cover,
                                                        );
                                                      } else {
                                                        return Container(
                                                          width: 120,
                                                          height: 120,
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          child: Center(
                                                            child:
                                                                SpinkitFlutter
                                                                    .spinkit,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.03,
                                        ),
                                        WebButton(
                                            text: "Upload",
                                            color: MyThemeData.background,
                                            onPressed: () {
                                              obj.pickImage();
                                            },
                                            width: width * 0.08),
                                        Container(
                                          width: width * 0.03,
                                        ),
                                        WebButton(
                                            text: "Delete",
                                            color: MyThemeData.background,
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Confirm Delete'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this Profile Image?'),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          obj.deletepic(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              MyThemeData
                                                                  .background,
                                                        ),
                                                        child: const Text(
                                                            'Delete'),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              MyThemeData
                                                                  .redColour,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            width: width * 0.08),
                                      ],
                                    ),
                                    Text(
                                      "MANAGE INSTRUCTORS",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: MyThemeData.background,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //////////////////////////////
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.025,
                                              left: width * 0.01),
                                          child: TextButton(
                                            onPressed: () {
                                              obj.opentextfield =
                                                  !obj.opentextfield;
                                              obj.update();
                                            },
                                            child: const Text(
                                              "Add +",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: width * 0.1,
                                            height: height * 0.09,
                                            child: obj.opentextfield == true
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.015),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        ////////////////////
                                                      },
                                                      controller:
                                                          obj.controllerleaders,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      cursorColor: Colors.black,
                                                      autofocus: false,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Add instructors",
                                                        hintStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20.0,
                                                                10,
                                                                20.0,
                                                                10),
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor: Colors
                                                            .grey.shade200,
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        errorBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.red,
                                                            width: 2,
                                                          ),
                                                        ),
                                                        focusedErrorBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.red,
                                                            width: 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : StreamBuilder<QuerySnapshot>(
                                                    stream: obj
                                                        .firebaseFirestore
                                                        .collection(
                                                            'instructors')
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.data ==
                                                              null
                                                          ? Center(
                                                              child:
                                                                  SpinkitFlutter
                                                                      .spinkit,
                                                            )
                                                          : ListView.builder(
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      TagContainer(
                                                                        text: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get('name'),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            obj.deleteinstructor(snapshot.data!.docs[index].get('id'),
                                                                                context);
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.black,
                                                                          ))
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                    }),
                                          ),
                                        ),
                                        obj.opentextfield == true
                                            ? SizedBox(
                                                width: width * 0.02,
                                              )
                                            : const SizedBox(),
                                        obj.opentextfield == true
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02),
                                                child: WebButton(
                                                  width: width * 0.05,
                                                  text: 'ADD',
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    obj.addleaderslist(context);
                                                  },
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    ///////////////////////////////////////////////
                                    SizedBox(height: height * 0.03),
                                    lableTextname("User Name"),
                                    SizedBox(height: height * 0.01),
                                    SizedBox(
                                      width: width * 0.25,
                                      child: Textformfield(
                                        controller: obj.usernamecontroller,
                                        abscureText: false,
                                        validation: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter User name';
                                          }
                                          return null; // input is valid
                                        },
                                        keyboardtype: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.03),
                                    lableTextname("User Email"),
                                    SizedBox(height: height * 0.01),
                                    SizedBox(
                                      width: width * 0.25,
                                      child: Textformfield(
                                        controller: obj.useremailcontroller,
                                        abscureText: false,
                                        validation: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter User email';
                                          }
                                          return null; // input is valid
                                        },
                                        keyboardtype: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.05),
                                    WebButton(
                                      text: 'Save',
                                      color: MyThemeData.background,
                                      width: width * 0.25,
                                      onPressed: () {
                                        if (profileformkey.currentState!
                                            .validate()) {
                                          obj.updatefields();
                                          obj.update();
                                        } else {
                                          showtoast("fullfill all fields");
                                        }
                                      },
                                    ),
                                    SizedBox(height: height * 0.05),
                                    WebButton(
                                      text: 'LogOut',
                                      color: MyThemeData.background,
                                      width: width * 0.25,
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        showtoast("sign out succesfull");

                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.getKeys();
                                        prefs.clear();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                    ),
                                    SizedBox(height: height * 0.05),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upload Introduction Video",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: MyThemeData.background,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: height * 0.06,
                                ),

                                // obj.model?. videoURL==null ?

                                Container(
                                    width: width * 0.25,
                                    height: height * 0.25,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: obj.videoloading == true
                                        ? SizedBox(
                                            width: width * 0.1,
                                            height: height * 0.12,
                                            child: Center(
                                              child: SpinkitFlutter.spinkit,
                                            ),
                                          )
                                        : StreamBuilder(
                                            stream: obj.firebaseFirestore
                                                .collection("introvideo")
                                                .where('videoID',
                                                    isEqualTo: '1')
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child: SpinkitFlutter.spinkit,
                                                );
                                              }

                                              if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .drive_folder_upload_outlined,
                                                      color: MyThemeData
                                                          .background,
                                                      size: 30,
                                                    ),
                                                    lableTextname(
                                                        "Category Thumbnail"),
                                                  ],
                                                );
                                              } else {
                                                VideoModel model = VideoModel(
                                                  videoID: snapshot
                                                      .data!.docs[0]
                                                      .get('videoID'),
                                                  time: snapshot.data!.docs[0]
                                                      .get('time'),
                                                  videoURL: snapshot
                                                      .data!.docs[0]
                                                      .get('videoURL'),
                                                );
                                                return INtroVideoPlayer(
                                                    playListModel: model);
                                              }
                                            },
                                          )),
                                SizedBox(
                                  height: height * 0.07,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: width * 0.09),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width * 0.03,
                                      ),
                                      WebButton(
                                          text: "Upload",
                                          color: MyThemeData.background,
                                          onPressed: () {
                                            obj.pickvideo();
                                          },
                                          width: width * 0.08),
                                      Container(
                                        width: width * 0.03,
                                      ),
                                      WebButton(
                                          text: "Delete",
                                          color: MyThemeData.background,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Delete'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this Video ?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        obj.deletevideo(
                                                            context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            MyThemeData
                                                                .background,
                                                      ),
                                                      child:
                                                          const Text('Delete'),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            MyThemeData
                                                                .redColour,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          width: width * 0.08),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              obj.imageloading == true
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

class TagContainer extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;

  const TagContainer({
    Key? key,
    required this.text,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class INtroVideoPlayer extends StatefulWidget {
  final VideoModel playListModel;

  const INtroVideoPlayer({super.key, required this.playListModel});

  @override
  _INtroVideoPlayerState createState() => _INtroVideoPlayerState();
}

class _INtroVideoPlayerState extends State<INtroVideoPlayer> {
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
    await firebaseFirestore.collection("introvideo").doc('1').update({
      'time':
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
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          updateseconds();

          return
              // widget.playListModel.videoURL==null? Column(
              //   crossAxisAlignment:
              //   CrossAxisAlignment.center,
              //   mainAxisAlignment:
              //   MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Icon(
              //       Icons
              //           .drive_folder_upload_outlined,
              //       color: MyThemeData.background,
              //       size: 30,
              //     ),
              //     lableTextname(
              //         "Category Thumbnail"),
              //   ],
              // ):

              AspectRatio(
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
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
    );
  }
}
