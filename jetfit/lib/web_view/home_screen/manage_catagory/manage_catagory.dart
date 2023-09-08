import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/web_view/home_screen/manage_catagory/manage_catagory_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/home_screen/manage_catagory/video_players.dart';
import 'package:get/get.dart';
import 'package:jetfit/web_view/home_screen/add_category/addvideo/addvideo.dart';

class ManagecategoryScreen extends StatefulWidget {
  const ManagecategoryScreen({Key? key}) : super(key: key);

  @override
  State<ManagecategoryScreen> createState() => _ManagecategoryScreenState();
}

class _ManagecategoryScreenState extends State<ManagecategoryScreen>
    with TickerProviderStateMixin {
  GlobalKey<FormState> categoryformKey = GlobalKey<FormState>();
  GlobalKey<FormState> videoformkey = GlobalKey<FormState>();
  GlobalKey<FormState> singlevideoformKey = GlobalKey<FormState>();
  var height, width;
  TabController? _tabController; // Initialize your tab controller

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Adjust the tab count as needed
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<ManageCtagoryController>(initState: (state) {
        Get.put(ManageCtagoryController());
        ManageCtagoryController.my.is_edit_single_video_click = false;
        ManageCtagoryController.my.falseAllClick();
      }, builder: (obj) {
        return Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: width * 0.05),
                      width: width,
                      height: height * 0.1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          obj.is_edit_category_click == true
                              ? 'EDIT PLAYLIST'
                              : obj.is_edit_single_video_click == true
                                  ? obj.is_single_viewer_click == true
                                      ? 'MANAGE VIEWERS'
                                      : 'EDIT VIDEO'
                                  : obj.is_edit_playlist_click == true
                                      ? obj.is_viewer_click == true
                                          ? 'MANAGE VIEWERS'
                                          : obj.is_edit_video_click == true
                                              ? 'EDIT VIDEO'
                                              : obj.is_upload_video_click ==
                                                      true
                                                  ? 'UPLOAD VIDEO'
                                                  : 'EDIT PLAYLIST'
                                      : "MANAGE ALL PLAYLIST",
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
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: height * 0.8,
                        width: width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TabBar(
                                controller: _tabController,
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
                                        width: width,
                                        height: height,
                                        color: Colors.black.withOpacity(0.1),
                                        child: Center(
                                          child: SpinkitFlutter.spinkit,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Container();
                                      // return Center(
                                      //     child: Text("No Categories"));
                                    } else {
                                      final filteredDocuments = snapshot
                                          .data!.docs
                                          .where((doc) =>
                                              doc['categoryType'] ==
                                              obj.selectedCategory)
                                          .toList();

                                      if (filteredDocuments.isEmpty) {
                                        // return Center(
                                        //     child: Text("No Categories"));
                                        return Container();
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
                                              classType:
                                                  filteredDocuments[index]
                                                      .get("classType"),
                                              dificulty:
                                                  filteredDocuments[index]
                                                      .get("dificulty"),
                                              instructor:
                                                  filteredDocuments[index]
                                                      .get("instructor"),
                                              videoLanguage:
                                                  filteredDocuments[index]
                                                      .get("videoLanguage"),
                                              categoryDescription:
                                                  filteredDocuments[index].get(
                                                      "categoryDescription"),
                                              categoryID:
                                                  filteredDocuments[index]
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Card(
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
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
                                                            const EdgeInsets
                                                                .only(
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        dropdownColor:
                                                            MyThemeData
                                                                .whitecolor,
                                                        icon: const Icon(
                                                            Icons
                                                                .more_vert_rounded,
                                                            color:
                                                                Colors.white),
                                                        onChanged: (value) {
                                                          if (value ==
                                                              'Edit Category') {
                                                            obj.editcategory_click_method(
                                                                model);
                                                          } else if (value ==
                                                              'Edit Playlist') {
                                                            obj.iseditplaylistclick(
                                                                model);
                                                            obj.update();
                                                          } else if (value ==
                                                              'Delete Category') {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Confirm Delete'),
                                                                    content:
                                                                        const Text(
                                                                            'Are you sure you want to delete this Category?'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          obj.deletecategory(
                                                                              model.categoryID!,
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              MyThemeData.background,
                                                                        ),
                                                                        child: const Text(
                                                                            'Delete'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              MyThemeData.redColour,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        },
                                                        items: <String>[
                                                          'Edit Category',
                                                          'Edit Playlist',
                                                          'Delete Category',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value ==
                                                                      'Edit Category'
                                                                  ? 'Edit Category'
                                                                  : value ==
                                                                          'Edit Playlist'
                                                                      ? 'Edit Playlist'
                                                                      : value ==
                                                                              'Delete Category'
                                                                          ? 'Delete Category'
                                                                          : '',
                                                              style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }),

                              ///////////// videos gettt
                              StreamBuilder<QuerySnapshot>(
                                  stream: obj.firebaseFirestore
                                      .collection("videos")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: width,
                                        height: height,
                                        color: Colors.black.withOpacity(0.1),
                                        child: Center(
                                          child: SpinkitFlutter.spinkit,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Container();
                                      // return Center(
                                      //     child: Text("No Categories"));
                                    } else {
                                      final filteredDocuments = snapshot
                                          .data!.docs
                                          .where((doc) =>
                                              doc['catagorytpe'] ==
                                              obj.selectedCategory)
                                          .toList();

                                      if (filteredDocuments.isEmpty) {
                                        // return Center(
                                        //     child: Text("No Categories"));
                                        return Container();
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
                                            VideossModel model = VideossModel(
                                              price: filteredDocuments[index]
                                                  .get("price"),
                                              catagorytpe:
                                                  filteredDocuments[index]
                                                      .get("catagorytpe"),
                                              classType:
                                                  filteredDocuments[index]
                                                      .get("classType"),
                                              dificulty:
                                                  filteredDocuments[index]
                                                      .get("dificulty"),
                                              duration: filteredDocuments[index]
                                                  .get("duration"),
                                              instructor:
                                                  filteredDocuments[index]
                                                      .get("instructor"),
                                              videoDescription:
                                                  filteredDocuments[index]
                                                      .get("videoDescription"),
                                              videoID: filteredDocuments[index]
                                                  .get("videoID"),
                                              videoLanguage:
                                                  filteredDocuments[index]
                                                      .get("videoLanguage"),
                                              videoName:
                                                  filteredDocuments[index]
                                                      .get("videoName"),
                                              videoURL: filteredDocuments[index]
                                                  .get("videoURL"),
                                              videotype:
                                                  filteredDocuments[index]
                                                      .get("videotype"),
                                              viewers: filteredDocuments[index]
                                                  .get("viewers"),
                                            );

                                            return Stack(
                                              children: [
                                                SizedBox(
                                                  height: height,
                                                  width: width,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Card(
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
                                                          ),
                                                          child:
                                                              VideoPlayerWidget(
                                                            videoID:
                                                                model.videoID!,
                                                            videoURl:
                                                                model.videoURL!,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          model.videoName!,
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
                                                            const EdgeInsets
                                                                .only(
                                                          left: 8,
                                                          top: 2,
                                                          right: 8,
                                                        ),
                                                        child: Text(
                                                          '${model.videoDescription} | intensity *',
                                                          style: TextStyle(
                                                              color: MyThemeData
                                                                  .background),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        dropdownColor:
                                                            MyThemeData
                                                                .whitecolor,
                                                        icon: const Icon(
                                                            Icons
                                                                .more_vert_rounded,
                                                            color:
                                                                Colors.white),
                                                        onChanged: (value) {
                                                          if (value ==
                                                              'Edit Video') {
                                                            obj.editsinglevideoclick(
                                                                model);
                                                          } else if (value ==
                                                              'Manage Viewers') {
                                                            obj.getsingleviewers(
                                                                model);
                                                          } else if (value ==
                                                              'Delete Video') {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Confirm Delete'),
                                                                  content:
                                                                      const Text(
                                                                          'Are you sure you want to delete this Video?'),
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        obj.deletesinglevideo(
                                                                            model.videoID!,
                                                                            context);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            MyThemeData.background,
                                                                      ),
                                                                      child: const Text(
                                                                          'Delete'),
                                                                    ),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            MyThemeData.redColour,
                                                                      ),
                                                                      onPressed:
                                                                          () {
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
                                                          }
                                                        },
                                                        items: <String>[
                                                          'Edit Video',
                                                          'Delete Video',
                                                          'Manage Viewers',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value ==
                                                                      'Edit Video'
                                                                  ? 'Edit Video'
                                                                  : value ==
                                                                          'Delete Video'
                                                                      ? 'Delete Video'
                                                                      : value ==
                                                                              'Manage Viewers'
                                                                          ? 'Manage Viewers'
                                                                          : '',
                                                              style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
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
                  ],
                ),
              ),
            ),
            obj.is_edit_category_click == true
                ? GestureDetector(
                    onTap: () {
                      obj.is_edit_category_click = false;
                      obj.is_edit_playlist_click = false;
                      obj.categoryloading = false;
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

            obj.is_edit_category_click == true
                ? Form(
                    key: categoryformKey,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: width * 0.35,
                            height: height * 0.8,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.02,
                                  ),

                                  InkWell(
                                    onTap: () {
                                      obj.pickImage(
                                          obj.editcategory_Model!.categoryID!);
                                    },
                                    child: Container(
                                      width: width * 0.25,
                                      height: height * 0.25,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: obj.editcategory_Model!
                                              .thumbnailimageURL!.isEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .drive_folder_upload_outlined,
                                                  color: MyThemeData.background,
                                                  size: 30,
                                                ),
                                                lableTextname(
                                                    "Category Thumbnail"),
                                              ],
                                            )
                                          : Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(obj
                                                  .editcategory_Model!
                                                  .thumbnailimageURL!),
                                            ),
                                    ),
                                  ),
/////////////////////////
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
                                          items: obj.catagorytypeitems
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      value,
                                                      style: const TextStyle(
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
                                      lableTextname("Playlist Type"),
                                      lableTextname("Set the filter tags"),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            lableTextname("Difficulty"),
                                            Container(
                                              width: width * 0.15,
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
                                                value:
                                                    obj.difficultyselectedvalue,
                                                onChanged: (String? newValue) {
                                                  obj.difficultyselectedvalue =
                                                      newValue!;
                                                  obj.update();
                                                },
                                                items: obj.difficultymenuItems
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            lableTextname("Class Type"),
                                            Container(
                                              width: width * 0.15,
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
                                                value:
                                                    obj.classtypeselectedvalue,
                                                onChanged: (String? newValue) {
                                                  obj.classtypeselectedvalue =
                                                      newValue!;
                                                  obj.update();
                                                },
                                                items: obj.classtypemenuItems
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            lableTextname("Instructor"),
                                            Container(
                                              width: width * 0.15,
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
                                                value:
                                                    obj.instructorselectedvalue,
                                                onChanged: (String? newValue) {
                                                  obj.instructorselectedvalue =
                                                      newValue!;
                                                  obj.update();
                                                },
                                                items: obj.instructormenuItems
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            lableTextname("Video Language"),
                                            Container(
                                              width: width * 0.15,
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
                                                value: obj
                                                    .videolanguageselectedvalue,
                                                onChanged: (String? newValue) {
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
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                            obj.typeselectedvalue = newValue!;
                                            obj.update();
                                          },
                                          items: obj.typeitems
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      value,
                                                      style: const TextStyle(
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
                                      lableTextname("Category Name"),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Textformfield(
                                          controller:
                                              obj.categorynamecontroller,
                                          abscureText: false,
                                          validation: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Category name';
                                            }
                                            return null; // input is valid
                                          },
                                          keyboardtype: TextInputType.name,
                                        ),
                                      ),
                                      lableTextname(
                                          "Duration timeline for program"),
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
                                          maxline: 4,
                                          controller:
                                              obj.categorydescriptioncontroller,
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
                                              if (categoryformKey.currentState!
                                                  .validate()) {
                                                obj.uploadeEditcategoryToDB(obj
                                                    .editcategory_Model!
                                                    .categoryID!);
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

                                  //////////////////////////////
                                ],
                              ),
                            ),
                          ),
                          obj.categoryloading == true
                              ? Container(
                                  width: width * 0.37,
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
                    /////////////////////////////////////////////////////////////////
                  )
                //////////////////////////////  is_edit_playlist_click
                : obj.is_edit_playlist_click == true
                    ? Stack(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: obj.firebaseFirestore
                                  .collection("category")
                                  .doc(obj.editcategory_Model!.categoryID)
                                  .collection("playlist")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.01),
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
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        obj.is_edit_playlist_click =
                                                            false;
                                                        obj.update();
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_back_ios_new,
                                                        color: MyThemeData
                                                            .background,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.01,
                                                    ),
                                                    Text(
                                                      'Playlist',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: MyThemeData
                                                              .background,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.45,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.16,
                                                      child: Textformfield(
                                                        onChanged: (value) {
                                                          obj.name = value;
                                                          obj.update();
                                                        },
                                                        hinttext:
                                                            "Search Video",
                                                        controller: obj
                                                            .searchplaylistcontroller,
                                                        abscureText: false,
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: MyThemeData
                                                              .greyColor,
                                                        ),
                                                        keyboardtype:
                                                            TextInputType.name,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: width,
                                                  height: height * 0.4,
                                                  child: snapshot.hasData
                                                      ? snapshot.data != null
                                                          ? snapshot.data!.docs
                                                                  .isEmpty
                                                              ? const Center(
                                                                  child: Text(
                                                                      "No video"),
                                                                )
                                                              : ListView
                                                                  .builder(
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
                                                                      duration: snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .get(
                                                                              "duration"),
                                                                      viewers: snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .get(
                                                                              "viewers"),
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

                                                                    var viewers = List<
                                                                        String>.from(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get('viewers') ??
                                                                        []);

                                                                    if (obj.name
                                                                            .isEmpty ||
                                                                        obj.name ==
                                                                            '') {
                                                                      return PlaylistPlayer(
                                                                        playListModel:
                                                                            model,
                                                                      );
                                                                    } else if (model
                                                                        .videoName!
                                                                        .toLowerCase()
                                                                        .contains(obj
                                                                            .name
                                                                            .toLowerCase())) {
                                                                      return PlaylistPlayer(
                                                                        playListModel:
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
                                                          child: SpinkitFlutter
                                                              .spinkit,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                onPressed: () {
                                  obj.is_upload_video_click = true;
                                  obj.playlistloading = false;
                                  obj.uploadplaylistloading = false;
                                  obj.playlistID = null;
                                  obj.videodescriptioncontroller.clear();
                                  obj.videonamecontroller.clear();
                                  if (obj.videofile != null) {
                                    obj.videofile = null;
                                  }
                                  obj.update();
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
                      )
                    : const SizedBox(),

            ////////////////////////video click blur container
            obj.is_edit_video_click == true || obj.is_upload_video_click == true
                ? GestureDetector(
                    onTap: () {
                      obj.is_edit_video_click = false;
                      obj.is_upload_video_click = false;
                      obj.editplaylistloading = false;
                      obj.uploadingeditvideoclick = false;
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
////////////////////  video small container
            obj.is_upload_video_click == true
                ? Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: videoformkey,
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
                                      obj.pickVideo(
                                          obj.editcategory_Model!.categoryID!);
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
                                                Icon(
                                                  Icons
                                                      .drive_folder_upload_outlined,
                                                  color: MyThemeData.background,
                                                  size: 30,
                                                ),
                                                lableTextname("upload Video"),
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
                                            : Container(
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
                                                  child:
                                                      Text(obj.videofile!.name),
                                                ),
                                              )),

                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                        if (videoformkey.currentState!
                                            .validate()) {
                                          if (obj.videofile != null &&
                                              obj.playlistloading == false) {
                                            obj.uploadplaylistToDB(
                                                obj.videoooourl!,
                                                obj.editcategory_Model!
                                                    .categoryID!);
                                            obj.videoooourl = null;
                                            obj.update();
                                          } else {
                                            showtoast("uploading in progress");
                                          }
                                        } else {
                                          showtoast(
                                              "please fulfill all fields");
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

            /////////////////////////////////////////////////edit
            obj.is_edit_video_click == true
                ? Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: videoformkey,
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
                                lableTextname("Edit Video"),
                                SizedBox(
                                  height: height * 0.04,
                                ),

                                obj.playListModel!.videoURL!.isNotEmpty
                                    ? obj.editplaylistloading == true
                                        ? Container(
                                            width: width * 0.25,
                                            height: height * 0.18,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 2,
                                              ),
                                            ),
                                            child: Center(
                                              child: SpinkitFlutter.spinkit,
                                            ),
                                          )
                                        : obj.uploadingeditvideoclick == true
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
                                                  child:
                                                      Text(obj.videofile!.name),
                                                ),
                                              )
                                            // : const SizedBox()
                                            :
                                            // video work
                                            EditVideoWork(
                                                playListModel:
                                                    obj.playListModel!,
                                              )
                                    : Container(
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
                                            Icon(
                                              Icons
                                                  .drive_folder_upload_outlined,
                                              color: MyThemeData.background,
                                              size: 30,
                                            ),
                                            lableTextname("upload Video"),
                                          ],
                                        )),

                                SizedBox(
                                  height: height * 0.02,
                                ),

                                WebButton(
                                  onPressed: () {
                                    if (obj.editplaylistloading == false) {
                                      obj.editpickVideo(
                                          obj.editcategory_Model!.categoryID!,
                                          obj.playListModel!.videoID!);
                                      setState(() {});

                                      obj.update();
                                    } else {
                                      showtoast("uploading in progress");
                                    }
                                  },
                                  text: 'Upload Video',
                                  color: MyThemeData.background,
                                  width: width * 0.25,
                                ),

                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                        if (videoformkey.currentState!
                                            .validate()) {
                                          if (obj.editplaylistloading ==
                                              false) {
                                            obj.uploadeEditplaylistToDB(
                                                obj.editcategory_Model!
                                                    .categoryID!,
                                                obj.playListModel!.videoID!);

                                            obj.update();
                                          } else {
                                            showtoast("uploading in progress");
                                          }
                                        } else {
                                          showtoast(
                                              "please fulfill all fields");
                                        }
                                      },
                                      text: 'Save Video',
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
/////////////////////////////////// viewers
            ///
            ///

            obj.is_viewer_click == true
                ? Padding(
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
                            padding: EdgeInsets.only(left: width * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.01, top: height * 0.03),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          obj.is_viewer_click = false;
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
                                        'Viewers',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: MyThemeData.background,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: width * 0.45,
                                      ),
                                      SizedBox(
                                        width: width * 0.16,
                                        child: Textformfield(
                                          hinttext: "Search Viewer",
                                          controller:
                                              obj.searchviewercontroller,
                                          abscureText: false,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: MyThemeData.greyColor,
                                          ),
                                          keyboardtype: TextInputType.name,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.025, top: height * 0.03),
                                  child: Row(
                                    children: [
                                      lableTextname("No"),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      lableTextname("Profile"),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      lableTextname("Email"),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      lableTextname("Role"),
                                    ],
                                  ),
                                ),
                                FutureBuilder<List<UserModel>>(
                                    future: obj.fetchusermodel(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data == null
                                            ? Expanded(
                                                child: Center(
                                                  child: SpinkitFlutter.spinkit,
                                                ),
                                              )
                                            : snapshot.data!.isEmpty
                                                ? Expanded(
                                                    child: const Center(
                                                        child:
                                                            Text("No views")),
                                                  )
                                                : Expanded(
                                                    child: SizedBox(
                                                      width: width,
                                                      height: height,
                                                      child: ListView.builder(
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              children: [
                                                                //////////////// viewer image
                                                                SizedBox(
                                                                  width: width,
                                                                  height:
                                                                      height *
                                                                          0.09,
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.05,
                                                                        child:
                                                                            Text(
                                                                          '${index + 1}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.background,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image: snapshot.data![index].imageURL == null || snapshot.data![index].imageURL == ""
                                                                              ? DecorationImage(image: AssetImage("images/user.png"))
                                                                              : DecorationImage(image: NetworkImage(snapshot.data![index].imageURL!)),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        width: width *
                                                                            0.06,
                                                                        height: height *
                                                                            0.06,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.17,
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data![index].name}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.background,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.23,
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data![index].email}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                MyThemeData.background,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.06,
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data![index].role}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.background,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.02,
                                                                      ),
                                                                      WebButton(
                                                                          text:
                                                                              "Delete",
                                                                          color: MyThemeData
                                                                              .background,
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Confirm Delete'),
                                                                                  content: const Text('Are you sure you want to delete this User?'),
                                                                                  actions: [
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        obj.videoviewdelete(obj.playlistVideoModel!, index, context);
                                                                                        ////
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
                                                                          width:
                                                                              width * 0.08),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                      } else if (snapshot.hasError) {
                                        return Expanded(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        return Expanded(
                                          child: Center(
                                            child: SpinkitFlutter.spinkit,
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
                  )
                : const SizedBox(),

            obj.is_edit_single_video_click == true
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
                                padding: EdgeInsets.only(left: width * 0.01),
                                child: Form(
                                  key: singlevideoformKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: width * 0.1),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.03,
                                                  ),
                                                  lableTextname(
                                                      "Category Type"),
                                                  Container(
                                                    width: width * 0.25,
                                                    height: height * 0.07,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color: MyThemeData
                                                            .greyColor,
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButton<String>(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  width * 0.02),
                                                      underline: Container(),
                                                      value: obj
                                                          .catagoryselectedValue,
                                                      onChanged:
                                                          (String? newValue) {
                                                        obj.catagoryselectedValue =
                                                            newValue!;
                                                        obj.update();
                                                      },
                                                      items: obj
                                                          .catagorytypeitems
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>(
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
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.1,
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
                                                        color: MyThemeData
                                                            .greyColor,
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButton<String>(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  width * 0.02),
                                                      underline: Container(),
                                                      value:
                                                          obj.typeselectedvalue,
                                                      onChanged:
                                                          (String? newValue) {
                                                        obj.typeselectedvalue =
                                                            newValue!;
                                                        obj.update();
                                                      },
                                                      items: obj.typeitems.map<
                                                          DropdownMenuItem<
                                                              String>>(
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
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      0.1,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  lableTextname(
                                                      "Set the filter tags"),
                                                  SizedBox(
                                                    width: width * 0.25,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        lableTextname(
                                                            "Difficulty"),
                                                        Container(
                                                          width: width * 0.15,
                                                          height: height * 0.07,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 2,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                          child: DropdownButton<
                                                              String>(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width *
                                                                            0.02),
                                                            underline:
                                                                Container(),
                                                            value: obj
                                                                .difficultyselectedvalue,
                                                            onChanged: (String?
                                                                newValue) {
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
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
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
                                                        lableTextname(
                                                            "Class Type"),
                                                        Container(
                                                          width: width * 0.15,
                                                          height: height * 0.07,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 2,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                          child: DropdownButton<
                                                              String>(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width *
                                                                            0.02),
                                                            underline:
                                                                Container(),
                                                            value: obj
                                                                .classtypeselectedvalue,
                                                            onChanged: (String?
                                                                newValue) {
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
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
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
                                                        lableTextname(
                                                            "Instructor"),
                                                        Container(
                                                          width: width * 0.15,
                                                          height: height * 0.07,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 2,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                          child: DropdownButton<
                                                              String>(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width *
                                                                            0.02),
                                                            underline:
                                                                Container(),
                                                            value: obj
                                                                .instructorselectedvalue,
                                                            onChanged: (String?
                                                                newValue) {
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
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
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
                                                        lableTextname(
                                                            "Video Language"),
                                                        Container(
                                                          width: width * 0.15,
                                                          height: height * 0.07,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 2,
                                                              color: MyThemeData
                                                                  .greyColor,
                                                            ),
                                                          ),
                                                          child: DropdownButton<
                                                              String>(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width *
                                                                            0.02),
                                                            underline:
                                                                Container(),
                                                            value: obj
                                                                .videolanguageselectedvalue,
                                                            onChanged: (String?
                                                                newValue) {
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
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
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
                                              SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: height * 0.02,
                                                    ),
                                                    Container(
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
                                                      child: obj.editplaylistloading ==
                                                              true
                                                          ? Center(
                                                              child:
                                                                  SpinkitFlutter
                                                                      .spinkit,
                                                            )
                                                          : VideoPlayerWidget(
                                                              videoURl: obj.videoooourl ==
                                                                      null
                                                                  ? obj
                                                                      .videossModel!
                                                                      .videoURL!
                                                                  : obj
                                                                      .videoooourl!,
                                                              videoID: ""),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.01,
                                                    ),
                                                    WebButton(
                                                      onPressed: () {
                                                        obj.editsinglepickVideo(
                                                            obj.videossModel!
                                                                .videoID!);
                                                      },
                                                      text: 'Upload Video',
                                                      color: MyThemeData
                                                          .background,
                                                      width: width * 0.25,
                                                    ),
                                                    lableTextname("Video Name"),
                                                    SizedBox(
                                                      width: width * 0.25,
                                                      child: Textformfield(
                                                        controller: obj
                                                            .videonamecontroller,
                                                        abscureText: false,
                                                        validation: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter Video name';
                                                          }
                                                          return null; // input is valid
                                                        },
                                                        keyboardtype:
                                                            TextInputType.name,
                                                      ),
                                                    ),
                                                    lableTextname(
                                                        "Video Description"),
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
                                                        keyboardtype:
                                                            TextInputType.name,
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
                                                        keyboardtype:
                                                            TextInputType.name,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.02,
                                                    ),
                                                    WebButton(
                                                      onPressed: () {
                                                        if (obj.videossModel!
                                                                    .videoURL !=
                                                                null &&
                                                            obj.videossModel!
                                                                    .videoURL !=
                                                                '' &&
                                                            singlevideoformKey
                                                                .currentState!
                                                                .validate() &&
                                                            obj.editplaylistloading ==
                                                                false) {
                                                          obj.uploadeedtsingleVideoToDB(
                                                              obj.videossModel!
                                                                  .videoID!);
                                                          obj.update();
                                                        } else {
                                                          showtoast(
                                                              "fulfill all fields");
                                                        }
                                                      },
                                                      text: 'Save Video',
                                                      color: MyThemeData
                                                          .background,
                                                      width: width * 0.25,
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //////////////////////////////
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      obj.uploadingeditvideoclick == true
                          ? Expanded(
                              child: Container(
                                width: width,
                                height: height,
                                color: Colors.black.withOpacity(0.1),
                                child: Center(
                                  child: SpinkitFlutter.spinkit,
                                ),
                              ),
                            )
                          : SizedBox(),
                      /////// ye krna
                    ],
                  )
                : const SizedBox(),

            obj.is_single_viewer_click == true
                ? Padding(
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
                            padding: EdgeInsets.only(left: width * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.01, top: height * 0.03),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          obj.is_single_viewer_click = false;
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
                                        'Viewers',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: MyThemeData.background,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: width * 0.45,
                                      ),
                                      SizedBox(
                                        width: width * 0.16,
                                        child: Textformfield(
                                          hinttext: "Search Viewer",
                                          controller:
                                              obj.searchviewercontroller,
                                          abscureText: false,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: MyThemeData.greyColor,
                                          ),
                                          keyboardtype: TextInputType.name,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.025, top: height * 0.03),
                                  child: Row(
                                    children: [
                                      lableTextname("No"),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      lableTextname("Profile"),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      lableTextname("Email"),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      lableTextname("Role"),
                                    ],
                                  ),
                                ),
                                FutureBuilder<List<UserModel>>(
                                    future: obj.fetchsingleusermodel(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data == null
                                            ? Expanded(
                                                child: Center(
                                                  child: SpinkitFlutter.spinkit,
                                                ),
                                              )
                                            : snapshot.data!.isEmpty
                                                ? Expanded(
                                                    child: const Center(
                                                        child:
                                                            Text("No views")),
                                                  )
                                                : Expanded(
                                                    child: SizedBox(
                                                      width: width,
                                                      height: height,
                                                      child: ListView.builder(
                                                        itemCount: snapshot
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              children: [
                                                                //////////////// viewer image
                                                                SizedBox(
                                                                  width: width,
                                                                  height:
                                                                      height *
                                                                          0.09,
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.05,
                                                                        child:
                                                                            Text(
                                                                          '${index + 1}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.background,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          image: snapshot.data![index].imageURL == null || snapshot.data![index].imageURL == ""
                                                                              ? DecorationImage(image: AssetImage("images/user.png"))
                                                                              : DecorationImage(image: NetworkImage(snapshot.data![index].imageURL!)),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        width: width *
                                                                            0.06,
                                                                        height: height *
                                                                            0.06,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.01,
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.17,
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data![index].name}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.background,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.23,
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data![index].email}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                MyThemeData.background,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.06,
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data![index].role}',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              color: MyThemeData.background,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.02,
                                                                      ),
                                                                      WebButton(
                                                                          text:
                                                                              "Delete",
                                                                          color: MyThemeData
                                                                              .background,
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                  title: const Text('Confirm Delete'),
                                                                                  content: const Text('Are you sure you want to delete this User?'),
                                                                                  actions: [
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        obj.videosingleviewdelete(obj.videossModel!, index, context);
                                                                                        ////
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
                                                                          width:
                                                                              width * 0.08),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                      } else if (snapshot.hasError) {
                                        return Expanded(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        return Expanded(
                                          child: Center(
                                            child: SpinkitFlutter.spinkit,
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
