import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/home_screen/add_category/add_playlist/add_playlist_controller.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/web_view/home_screen/add_category/video_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AddcategoryScreen extends StatefulWidget {
  const AddcategoryScreen({super.key});

  @override
  State<AddcategoryScreen> createState() => _AddcategoryScreenState();
}

class _AddcategoryScreenState extends State<AddcategoryScreen> {
  GlobalKey<FormState> categoryformKey = GlobalKey<FormState>();
  GlobalKey<FormState> videoformKey = GlobalKey<FormState>();

  var height, width;

  @override
  void dispose() {
    AddCtagoryController.my.videoplayerController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.put(AddCtagoryController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<AddCtagoryController>(initState: (state) {
        Get.put(AddCtagoryController());

        AddCtagoryController.my.initstatefunctions();
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
                      obj.isaddvideoclick == true
                          ? "ADD NEW VIDEO"
                          : "ADD NEW PLAYLIST",
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
                    child: Row(
                      children: [
                        Form(
                          key: categoryformKey,
                          child: Stack(
                            children: [
                              Container(
                                width: width * 0.37,
                                height: height,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: Colors.grey.shade200,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          obj.pickImage();
                                        },
                                        child: Container(
                                          width: width * 0.25,
                                          height: height * 0.22,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                          child: obj.thumbnailImage == null
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Image(
                                                      height: height * 0.07,
                                                      width: width * 0.07,
                                                      image: const AssetImage(
                                                          'images/upploadimage.png'),
                                                    ),
                                                    lableTextname(
                                                        "Category Thumbnail"),
                                                  ],
                                                )
                                              : FutureBuilder(
                                                  future: obj.thumbnailImage!
                                                      .readAsBytes(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover,
                                                      );
                                                    } else {
                                                      return Container(
                                                        width: width * 0.25,
                                                        height: height * 0.22,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        child: Center(
                                                          child: SpinkitFlutter
                                                              .spinkit,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
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

                                          // /////////////////
                                          lableTextname("Playlist Type"),

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

                                          lableTextname("Playlist Name"),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Textformfield(
                                              controller:
                                                  obj.categorynamecontroller,
                                              abscureText: false,
                                              validation: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Playlist name';
                                                }
                                                return null; // input is valid
                                              },
                                              keyboardtype: TextInputType.name,
                                            ),
                                          ),
                                          obj.catagoryselectedValue ==
                                                      "Challenges" ||
                                                  obj.catagoryselectedValue ==
                                                      "Series"
                                              ? lableTextname("Minutes per day")
                                              : lableTextname(
                                                  "Duration timeline for program"),
                                          obj.catagoryselectedValue ==
                                                      "Challenges" ||
                                                  obj.catagoryselectedValue ==
                                                      "Series"
                                              ? SizedBox(
                                                  width: width * 0.25,
                                                  child: Textformfield(
                                                    controller: obj
                                                        .categorydayscontroller,
                                                    abscureText: false,
                                                    validation: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter Days';
                                                      }
                                                      return null; // input is valid
                                                    },
                                                    keyboardtype:
                                                        TextInputType.name,
                                                  ),
                                                )
                                              : Container(),
                                          obj.catagoryselectedValue ==
                                                      "Challenges" ||
                                                  obj.catagoryselectedValue ==
                                                      "Series"
                                              ? lableTextname("Days")
                                              : Container(),
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
                                          lableTextname("Category Description"),
                                          SizedBox(
                                            width: width * 0.25,
                                            child: Textformfield(
                                              maxline: 1,
                                              controller: obj
                                                  .categorydescriptioncontroller,
                                              abscureText: false,
                                              validation: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Category Description';
                                                }
                                                return null; // input is valid
                                              },
                                              keyboardtype: TextInputType.name,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.015,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.05),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: WebButton(
                                                onPressed: () async {
                                                  if (categoryformKey
                                                          .currentState!
                                                          .validate() &&
                                                      obj.thumbnailImage !=
                                                          null) {
                                                    obj.uploadImage(
                                                        obj.thumbnailImage!);
                                                  } else {
                                                    showtoast("not saved");
                                                  }
                                                },
                                                text: 'Save',
                                                color: MyThemeData.background,
                                                width: width * 0.25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // //////////////////////////////
                                    ],
                                  ),
                                ),
                              ),
                              obj.categoryloading == true
                                  ? Container(
                                      width: width * 0.37,
                                      height: height,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: SpinkitFlutter.spinkit,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        /////////////////eeeeeeeee
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.025),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.01,
                                            top: height * 0.03),
                                        child: lableTextname("Playlist"),
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: obj.firebaseFirestore
                                              .collection("category")
                                              .doc(obj.categoryId)
                                              .collection("playlist")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            return snapshot.hasData
                                                ? snapshot.data != null
                                                    ? snapshot
                                                            .data!.docs.isEmpty
                                                        ? Expanded(
                                                            child: Center(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  obj.floatingactionfunction();
                                                                },
                                                                child: Image(
                                                                  height:
                                                                      height *
                                                                          0.1,
                                                                  width: width *
                                                                      0.2,
                                                                  image: const AssetImage(
                                                                      'images/upload.png'),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Expanded(
                                                            child: SizedBox(
                                                              width: width,
                                                              height: height,
                                                              child: ListView
                                                                  .builder(
                                                                key:
                                                                    UniqueKey(),
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  PlayListModel
                                                                      model =
                                                                      PlayListModel(
                                                                    viewers: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "viewers"),
                                                                    duration: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "duration"),
                                                                    categoryID: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "categoryID"),
                                                                    videoDescription: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "videoDescription"),
                                                                    videoID: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "videoID"),
                                                                    videoName: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "videoName"),
                                                                    videoURL: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "videoURL"),
                                                                  );
                                                                  return VideoPlayerWidget(
                                                                      playListModel:
                                                                          model);
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                    : Expanded(
                                                        child: SizedBox(
                                                          width: width,
                                                          height: height,
                                                          child: Center(
                                                            child:
                                                                SpinkitFlutter
                                                                    .spinkit,
                                                          ),
                                                        ),
                                                      )
                                                : Expanded(
                                                    child: SizedBox(
                                                      width: width,
                                                      height: height,
                                                      child: Center(
                                                        child: SpinkitFlutter
                                                            .spinkit,
                                                      ),
                                                    ),
                                                  );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      obj.floatingactionfunction();
                                    },
                                    backgroundColor: Colors.black,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            obj.isaddvideoclick == true
                ? GestureDetector(
                    onTap: () {
                      obj.isaddvideoclick = false;
                      obj.update();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: width * 0.05),
                      width: width,
                      height: height,
                      color: MyThemeData.background.withOpacity(0.3),
                    ),
                  )
                : const SizedBox(),
            obj.isaddvideoclick == true
                ? Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: videoformKey,
                      child: Stack(
                        children: [
                          Container(
                            width: width * 0.3,
                            height: height * 0.8,
                            color: Colors.white,
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                lableTextname("Upload Video"),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (obj.thumbnailImage != null) {
                                        obj.pickVideo();
                                      } else {
                                        showtoast(
                                            "please upload Category first");
                                      }
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
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image(
                                                  height: height * 0.1,
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
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: SpinkitFlutter.spinkit,
                                                ),
                                              )
                                            : Center(
                                                child: Container(
                                                  width: width * 0.25,
                                                  height: height * 0.18,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                        obj.videofile!.name),
                                                  ),
                                                ),
                                              )),

                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // lableTextname("Duration of video"),
                                    // SizedBox(
                                    //   width: width * 0.25,
                                    //   child: Textformfield(
                                    //     controller:
                                    //         obj.videodurationtimelinecontroller,
                                    //     abscureText: false,
                                    //     validation: (value) {
                                    //       if (value == null || value.isEmpty) {
                                    //         return 'Please enter Duration';
                                    //       }
                                    //       return null; // input is valid
                                    //     },
                                    //     keyboardtype: TextInputType.name,
                                    //   ),
                                    // ),
                                    lableTextname("Video Name"),
                                    SizedBox(
                                      width: width * 0.25,
                                      child: Textformfield(
                                        controller: obj.videonamecontroller,
                                        abscureText: false,
                                        validation: (value) {
                                          if (value == null || value.isEmpty) {
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
                                        controller:
                                            obj.videodescriptioncontroller,
                                        abscureText: false,
                                        validation: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Video Description';
                                          }
                                          return null; // input is valid
                                        },
                                        keyboardtype: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.025,
                                    ),
                                    WebButton(
                                      onPressed: () {
                                        if (videoformKey.currentState!
                                                .validate() &&
                                            obj.thumbnailImage != null) {
                                          if (obj.videofile != null &&
                                              obj.playlistloading == false) {
                                            obj.uploadplaylistToDB(
                                                obj.videoooourl!);
                                            obj.update();
                                          } else {
                                            showtoast("uploading in progress");
                                          }
                                        } else {
                                          showtoast(
                                              "please add Category first");
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

                                //////////////////////////////
                              ],
                            )),
                          ),
                          obj.uploadplaylistloading == true
                              ? Container(
                                  width: width * 0.3,
                                  height: height * 0.8,
                                  color: Colors.black.withOpacity(0.1),
                                  child: Center(
                                    child: SpinkitFlutter.spinkit,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
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
  final PlayListModel playListModel;

  const VideoPlayerWidget({super.key, required this.playListModel});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
    print(
        "seconds   : '${_videoPlayerController!.value.duration.inMinutes}:${(_videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}'");
  }

  @override
  void initState() {
    Get.put(AddCtagoryController());
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
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(_videoPlayerController!),
                              if (!_isVideoPlaying)
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      AddCtagoryController.my.isvideoplayclick =
                                          true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScreen(
                                                    videooo: widget
                                                        .playListModel
                                                        .videoURL!),
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
                width: width * 0.015,
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playListModel.videoName!,
                        style: TextStyle(
                          color: MyThemeData.background,
                          fontWeight: FontWeight.bold,
                        ),
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
                              AddCtagoryController.my.deletevideo(
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
                width: width * 0.02,
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
