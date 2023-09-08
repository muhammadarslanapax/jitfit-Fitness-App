import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetfit/view/screens/feedback/feedback.dart';
import 'package:jetfit/web_view/home_screen/feedback/feedback_controller.dart';

import '../../../utilis/theme_data.dart';
import '../../../utilis/utilis.dart';
import '../../../view/widgets/textformfield.dart';
import '../../../models/add_category.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> with TickerProviderStateMixin {
  GlobalKey<FormState> profileformkey = GlobalKey<FormState>();
  var height, width;
  bool _switchValue = false;
  TabController? _tabControllers; // Initialize your tab controller

  @override
  void initState() {
    super.initState();
    _tabControllers =
        TabController(length: 4, vsync: this); // Adjust the tab count as needed
  }

  String? imageurl;
  String? videourl;
  @override
  void dispose() {
    _tabControllers!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<FeedbackController>(initState: (state) {
        Get.put(FeedbackController());
        FeedbackController.my.selectedCategory = 'Workout';
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
                        "FEEDBACK",
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabControllers,
                              tabs: [
                                Tab(text: 'Workout'),
                                Tab(text: 'Challenges'),
                                Tab(text: 'Routines'),
                                Tab(text: 'Series'),
                              ],
                              labelColor: Colors.black,
                              unselectedLabelColor:
                                  Colors.black.withOpacity(0.5),
                              indicatorColor: Colors.black,
                              onTap: (index) {
                                final categories = [
                                  'Workout',
                                  'Challenges',
                                  'Routines',
                                  'Series'
                                ];

                                obj.selectedCategory = categories[index];

                                obj.update();
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: obj.firebaseFirestore
                                    .collection("category")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: width * 0.8,
                                      height: height * 0.7,
                                      child: Center(
                                        child: SpinkitFlutter.spinkit,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    // return Container();
                                    return Container(
                                        width: width * 0.8,
                                        height: height * 0.7,
                                        child: Center(
                                            child: Text("No Categories")));
                                  } else {
                                    final filteredDocuments = snapshot
                                        .data!.docs
                                        .where((doc) =>
                                            doc['categoryType'] ==
                                            obj.selectedCategory)
                                        .toList();

                                    if (filteredDocuments.isEmpty) {
                                      return Container(
                                        width: width * 0.8,
                                        height: height * 0.7,
                                        child: Center(
                                            child: Text("No Categories")),
                                      );
                                      // return Container();
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GridView.builder(
                                        key: UniqueKey(),
                                        shrinkWrap: true,
                                        itemCount: filteredDocuments.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 2,
                                        ),
                                        itemBuilder: (context, index) {
                                          CategoryModel model = CategoryModel(
                                            classType: filteredDocuments[index]
                                                .get("classType"),
                                            dificulty: filteredDocuments[index]
                                                .get("dificulty"),
                                            instructor: filteredDocuments[index]
                                                .get("instructor"),
                                            videoLanguage:
                                                filteredDocuments[index]
                                                    .get("videoLanguage"),
                                            categoryDescription:
                                                filteredDocuments[index]
                                                    .get("categoryDescription"),
                                            categoryID: filteredDocuments[index]
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
                                            playlistType:
                                                filteredDocuments[index]
                                                    .get("playlistType"),
                                          );

                                          return Stack(
                                            children: [
                                              SizedBox(
                                                height: height,
                                                width: width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        obj.iseditplaylistclick(
                                                            model);
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        color: MyThemeData
                                                            .background,
                                                        shadowColor: MyThemeData
                                                            .onSurface,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                          height: height * 0.2,
                                                          width: width * 0.2,
                                                          foregroundDecoration:
                                                              BoxDecoration(
                                                            color: Colors.black
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
                                                              fit: BoxFit.cover,
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
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius: BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                            bottomRight: Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 12),
                                                                            child:
                                                                                Text(
                                                                              '${snapshot.data!.docs.length ?? 0} videos',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return Center(
                                                                      child: SpinkitFlutter
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        model.categoryName!,
                                                        style: TextStyle(
                                                            color: MyThemeData
                                                                .background,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                        top: 2,
                                                        right: 8,
                                                      ),
                                                      child: Text(
                                                        '${model.categoryDescription} | intensity *',
                                                        style: TextStyle(
                                                            color: MyThemeData
                                                                .background),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              obj.is_edit_playlist_click == true
                  ? Stack(
                      children: [
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
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.01, top: height * 0.03),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                obj.is_edit_playlist_click =
                                                    false;
                                                obj.update();
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios_new,
                                                color: MyThemeData.background,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Text(
                                              'User FeedBack',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: MyThemeData.background,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: width * 0.46,
                                            ),
                                            SizedBox(
                                              width: width * 0.16,
                                              child: Textformfield(
                                                onChanged: (value) {
                                                  obj.name = value;
                                                  obj.update();
                                                },
                                                hinttext: "Search User",
                                                controller: obj
                                                    .searchplaylistcontroller,
                                                abscureText: false,
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: MyThemeData.greyColor,
                                                ),
                                                keyboardtype:
                                                    TextInputType.name,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.05,
                                        ),
                                        /////////////////////
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("category")
                                                .doc(obj
                                                    .categorymodel!.categoryID)
                                                .collection("feedback")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  width: width,
                                                  height: height * 0.6,
                                                  child: Center(
                                                    child: WhiteSpinkitFlutter
                                                        .spinkit,
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.docs.isEmpty) {
                                                return Container();
                                              } else {
                                                return Expanded(
                                                  child: SizedBox(
                                                    width: width,
                                                    height: height,
                                                    child: snapshot.hasData
                                                        ? snapshot.data != null
                                                            ? snapshot
                                                                    .data!
                                                                    .docs
                                                                    .isEmpty
                                                                ? const Center(
                                                                    child: Text(
                                                                        "No feedback"),
                                                                  )
                                                                : ListView
                                                                    .builder(
                                                                    itemCount: snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      FeedbackModel model = FeedbackModel(
                                                                          name: snapshot.data!.docs[index].get(
                                                                              "name"),
                                                                          profileimageurl: snapshot.data!.docs[index].get(
                                                                              "profileimageurl"),
                                                                          description: snapshot.data!.docs[index].get(
                                                                              "description"),
                                                                          id: snapshot.data!.docs[index].get(
                                                                              "id"),
                                                                          playlistid: snapshot.data!.docs[index].get(
                                                                              "playlistid"),
                                                                          imageurl: snapshot.data!.docs[index].get(
                                                                              "imageurl"),
                                                                          videourl: snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .get("videourl"),
                                                                          status: snapshot.data!.docs[index].get("status"));
                                                                      if (obj.name
                                                                              .isEmpty ||
                                                                          obj.name ==
                                                                              '') {
                                                                        return CustomCardWidget(
                                                                          catmodel:
                                                                              obj.categorymodel,
                                                                          model:
                                                                              model,
                                                                        );
                                                                      } else if (model
                                                                          .name!
                                                                          .toLowerCase()
                                                                          .contains(obj
                                                                              .name
                                                                              .toLowerCase())) {
                                                                        return CustomCardWidget(
                                                                          catmodel:
                                                                              obj.categorymodel,
                                                                          model:
                                                                              model,
                                                                        );
                                                                      } else {
                                                                        return Container();
                                                                      }
                                                                    },
                                                                  )
                                                            : Center(
                                                                child:
                                                                    SpinkitFlutter
                                                                        .spinkit,
                                                              )
                                                        : Center(
                                                            child:
                                                                SpinkitFlutter
                                                                    .spinkit,
                                                          ),
                                                  ),
                                                );
                                              }
                                            }),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}

class CustomCardWidget extends StatefulWidget {
  FeedbackModel? model;
  CategoryModel? catmodel;
  CustomCardWidget({super.key, required this.model, required this.catmodel});

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  bool _switchValue = false;
  TextEditingController feedbackUserDescription = TextEditingController();

  bool isloadingg = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadVideo(XFile file, String playlistid) async {
    Uint8List bytes = await file.readAsBytes();
    Reference storageRef = storage
        .ref()
        .child('category/${widget.catmodel!.categoryID}/feedback/$playlistid');
    TaskSnapshot uploadTask = await storageRef.putData(bytes);
    String url = await uploadTask.ref.getDownloadURL();

    return url;
  }

  String? imageurl;
  String? videourl;
  void postfeedback(String categoryID, String playlistID) async {
    setState(() {
      isloadingg = true;
    });
    if (_pickedImage != null || _pickedVideo != null) {
      if (_pickedImage != null) {
        imageurl = await uploadVideo(_pickedImage!, playlistID);

        await FirebaseFirestore.instance
            .collection("category")
            .doc(widget.catmodel!.categoryID!)
            .collection("feedback")
            .doc(playlistID)
            .update({
          "imageurl": imageurl,
          "videourl": null,
        });
      } else if (_pickedVideo != null) {
        videourl = await uploadVideo(_pickedVideo!, playlistID);
        print("videourl ${videourl}");
        await FirebaseFirestore.instance
            .collection("category")
            .doc(widget.catmodel!.categoryID!)
            .collection("feedback")
            .doc(playlistID)
            .update({
          "videourl": videourl,
          "imageurl": null,
        });
      }

      setState(() {
        isloadingg = false;
      });
    } else {
      showtoast("plaese upload video or photo");
      setState(() {
        isloadingg = false;
      });
    }
  }

  void updatestatus(String value) async {
    await FirebaseFirestore.instance
        .collection("category")
        .doc(widget.catmodel!.categoryID!)
        .collection("feedback")
        .doc(widget.model!.id)
        .update({"status": value});
  }

  @override
  void initState() {
    feedbackUserDescription.text = widget.model!.description!;
    if (widget.model!.status == "private") {
      _switchValue = false;
    } else {
      _switchValue = true;
    }
    super.initState();
  }

  XFile? _pickedImage;
  XFile? _pickedVideo;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<FeedbackController>(initState: (state) {
      Get.put(FeedbackController());
    }, builder: (obj) {
      return Container(
        height: height * 0.4,
        width: width * 0.7,
        child: Card(
          elevation: 7,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        width: width * 0.1,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          image: widget.model!.profileimageurl != ''
                              ? DecorationImage(
                                  image: NetworkImage(
                                      widget.model!.profileimageurl!),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: AssetImage("images/man.png"),
                                  fit: BoxFit.cover,
                                ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(widget.model!.name!),
                    ],
                  ),
                  Container(
                    height: height * 0.25,
                    width: width * 0.4,
                    child: Text(
                      widget.model!.description!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  isloadingg == false
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.3,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: widget.model!.imageurl != null
                                ? Image.network(widget.model!.imageurl!)
                                : (widget.model!.videourl != null
                                    ? FeedbackCoverPlayer(
                                        isIcon: true,
                                        video: widget.model!.videourl)
                                    : Center(child: Icon(Icons.upload))),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.3,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: SpinkitFlutter.spinkit,
                          ),
                        )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            _switchValue == true ? "Public" : "Private",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                          width: 15,
                          child: Switch(
                              activeColor: Colors.black,
                              activeTrackColor: Colors.cyan,
                              inactiveThumbColor: Colors.blueGrey.shade600,
                              inactiveTrackColor: Colors.grey.shade400,
                              splashRadius: 50.0,
                              value: _switchValue,
                              onChanged: (value) {
                                if (value == true) {
                                  updatestatus("public");
                                } else {
                                  updatestatus("private");
                                }
                                setState(() {
                                  _switchValue = value;
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.image,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        'Pick Image',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width * 0.015,
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final pickedImage =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        setState(() {
                                          _pickedImage = pickedImage;
                                          _pickedVideo = null;
                                        });
                                        postfeedback(
                                          widget.catmodel!.categoryID!,
                                          widget.model!.id!,
                                        );
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.video_library,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        'Pick Video',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: width * 0.015,
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final pickedVideo =
                                            await ImagePicker().pickVideo(
                                          source: ImageSource.gallery,
                                        );
                                        setState(() {
                                          _pickedVideo = pickedVideo;
                                          _pickedImage = null;
                                        });
                                        postfeedback(
                                          widget.catmodel!.categoryID!,
                                          widget.model!.id!,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text('Update'),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this Favourite category?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (widget.model!.imageurl != null) {
                                        obj.deletefeedbfile(
                                            widget.catmodel!.categoryID!,
                                            widget.model!,
                                            context,
                                            false);
                                      } else if (widget.model!.videourl !=
                                          null) {
                                        obj.deletefeedbfile(
                                            widget.catmodel!.categoryID!,
                                            widget.model!,
                                            context,
                                            true);
                                      }
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
                        child: Text('Delete'),
                      ),
                      SizedBox(
                        width: width * 0.071,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
