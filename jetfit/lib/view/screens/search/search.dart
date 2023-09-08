import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/favourite_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/favourite/playlist/playlist_view.dart';
import 'package:jetfit/view/screens/cover_player/cover_player.dart';
import 'package:jetfit/view/screens/home01/home_01.dart';
import 'package:jetfit/view/screens/search/search_controller.dart';
import 'package:jetfit/models/add_category.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jetfit/view/widgets/exclusive_card.dart';
import 'package:jetfit/view/widgets/premium_card.dart';

class VideoSearchScreen extends StatefulWidget {
  const VideoSearchScreen({super.key});

  @override
  State<VideoSearchScreen> createState() => _VideoSearchScreenState();
}

class _VideoSearchScreenState extends State<VideoSearchScreen> {
  var height, width;
  final controller = Get.put(VideoSearchController());
  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyThemeData.background,
      body: OrientationBuilder(builder: (context, orientation) {
        return GetBuilder<VideoSearchController>(
          initState: (state) {
            Get.put(FavouriteController());
            controller.isexclusiveclick = false;
            controller.ispremuimclick = false;
          },
          builder: (controller) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: orientation == Orientation.portrait
                          ? 0
                          : width * 0.005),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: orientation == Orientation.portrait
                                ? 0
                                : width * 0.12),
                        child: Center(
                          child: Card(
                            elevation: 5,
                            shadowColor: MyThemeData.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: orientation == Orientation.landscape
                                  ? width * 0.8
                                  : width * 0.9,
                              child: TextFormField(
                                onChanged: (value) {
                                  controller.name = value;
                                  controller.update();
                                },
                                maxLines: 1,
                                controller: controller.searchController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: l.searchHere,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 10, 20.0, 10),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: MyThemeData.background,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Expanded(
                        child: Container(
                          height: height,
                          width: width,
                          child: SingleChildScrollView(
                            child: Column(
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("category")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: width,
                                        height: height * 0.7,
                                        child: Center(
                                          child: WhiteSpinkitFlutter.spinkit,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Container();
                                    } else {
                                      final documents = snapshot.data!.docs;

                                      final filteredDocuments =
                                          documents.where((document) {
                                        final model = CategoryModel(
                                          playlistType:
                                              document.get("playlistType"),
                                          classType: document.get("classType"),
                                          dificulty: document.get("dificulty"),
                                          instructor:
                                              document.get("instructor"),
                                          videoLanguage:
                                              document.get("videoLanguage"),
                                          categoryDescription: document
                                              .get("categoryDescription"),
                                          categoryID:
                                              document.get("categoryID"),
                                          categoryName:
                                              document.get("categoryName"),
                                          categoryType:
                                              document.get("categoryType"),
                                          thumbnailimageURL:
                                              document.get("thumbnailimageURL"),
                                          categoryTimeline:
                                              document.get("categoryTimeline"),
                                        );

                                        if (controller.name.isEmpty) {
                                          return true;
                                        } else {
                                          return model.categoryName!
                                              .toLowerCase()
                                              .contains(controller.name
                                                  .toLowerCase());
                                        }
                                      }).toList();

                                      return Padding(
                                        padding: orientation ==
                                                Orientation.portrait
                                            ? const EdgeInsets.only(left: 8.0)
                                            : EdgeInsets.only(
                                                left: width * 0.12),
                                        child: GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          key: UniqueKey(),
                                          shrinkWrap: true,
                                          itemCount: filteredDocuments.length,
                                          gridDelegate: orientation ==
                                                  Orientation.portrait
                                              ? SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisExtent: 180,
                                                  crossAxisSpacing: 20,
                                                  mainAxisSpacing: 0,
                                                )
                                              : SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 27,
                                                  mainAxisSpacing: 1,
                                                  mainAxisExtent: 200,
                                                  crossAxisCount: 3,
                                                ),
                                          itemBuilder: (context, index) {
                                            final catmodel = CategoryModel(
                                              playlistType:
                                                  filteredDocuments[index]
                                                      .get("playlistType"),
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
                                            );

                                            return CategoryStream(
                                              orientation: orientation,
                                              height: height,
                                              width: width,
                                              model: catmodel,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                                ///////////// videos gettt
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("videos")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: width,
                                        height: height,
                                        child: Center(
                                          child: WhiteSpinkitFlutter.spinkit,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.docs.isEmpty) {
                                      return Container();
                                    } else {
                                      final documents = snapshot.data!.docs;
                                      final filteredDocuments =
                                          documents.where((document) {
                                        final model = VideossModel(
                                          price: document.get("price"),
                                          catagorytpe:
                                              document.get("catagorytpe"),
                                          classType: document.get("classType"),
                                          dificulty: document.get("dificulty"),
                                          duration: document.get("duration"),
                                          instructor:
                                              document.get("instructor"),
                                          videoDescription:
                                              document.get("videoDescription"),
                                          videoID: document.get("videoID"),
                                          videoLanguage:
                                              document.get("videoLanguage"),
                                          videoName: document.get("videoName"),
                                          videoURL: document.get("videoURL"),
                                          videotype: document.get("videotype"),
                                          viewers: document.get("viewers"),
                                        );

                                        if (controller.name.isEmpty) {
                                          return true;
                                        } else {
                                          return model.videoName!
                                              .toLowerCase()
                                              .contains(controller.name
                                                  .toLowerCase());
                                        }
                                      }).toList();

                                      return Padding(
                                        padding: orientation ==
                                                Orientation.portrait
                                            ? const EdgeInsets.only(left: 8.0)
                                            : EdgeInsets.only(
                                                left: width * 0.12),
                                        child: GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          key: UniqueKey(),
                                          shrinkWrap: true,
                                          itemCount: filteredDocuments.length,
                                          gridDelegate: orientation ==
                                                  Orientation.portrait
                                              ? SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 15,
                                                  mainAxisExtent: 180,
                                                  mainAxisSpacing: 2,
                                                )
                                              : SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 27,
                                                  mainAxisSpacing: 1,
                                                  mainAxisExtent: 200,
                                                  crossAxisCount: 3,
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

                                            return VideoStream(
                                              height: height,
                                              width: width,
                                              model: model,
                                              orientation: orientation,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                    ],
                  ),
                ),
                controller.ispremuimclick || controller.isexclusiveclick
                    ? InkWell(
                        onTap: () {
                          controller.ispremuimclick = false;
                          controller.isexclusiveclick = false;
                          controller.update();
                        },
                        child: Container(
                          height: height,
                          width: width,
                          color: MyThemeData.background.withOpacity(0.3),
                        ),
                      )
                    : const SizedBox(),
                controller.ispremuimclick == false
                    ? SizedBox()
                    : PremiumContentWidget(
                        isPremiumClick: controller.ispremuimclick,
                        orientation: Orientation.portrait,
                        videossModel: controller.videossModel!,
                        controller: controller,
                      ),
                controller.isexclusiveclick == false
                    ? SizedBox()
                    : ExclusiveCardWidget(
                        isexclusiveclick: controller.isexclusiveclick,
                        orientation: Orientation.portrait,
                        videossModel: controller.videossModel!,
                        controller: controller,
                      ),
              ],
            );
          },
        );
      }),
    );
  }
}

class VideoStream extends StatelessWidget {
  const VideoStream({
    super.key,
    required this.height,
    required this.orientation,
    required this.width,
    required this.model,
  });

  final double height;
  final Orientation orientation;
  final double width;

  final VideossModel model;

  @override
  Widget build(BuildContext context) {
    Get.put(DashBoardController());
    return Stack(
      children: [
        ShimmerCard(height: height, width: width, orientation: orientation),
        Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                color: Colors.transparent,
                shadowColor: MyThemeData.onSurface,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: orientation == Orientation.portrait
                      ? height * 0.13
                      : height * 0.27,
                  width:
                      orientation == Orientation.portrait ? width : width * 0.5,
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CoverPlayer(
                    ishomecontroller: false,
                    issearchcontroller: true,
                    istrainignCOntroller: false,
                    isvideomodel: true,
                    videoModal: model,
                    isIcon: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  model.videoName!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: MyThemeData.whitecolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  '${model.duration}',
                  style: TextStyle(color: MyThemeData.whitecolor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  '${model.viewers!.length} views',
                  style: TextStyle(
                    color: MyThemeData.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryStream extends StatelessWidget {
  const CategoryStream({
    super.key,
    required this.height,
    required this.orientation,
    required this.width,
    required this.model,
  });

  final double height;
  final Orientation orientation;
  final double width;
  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    Get.put(DashBoardController());
    return Stack(
      children: [
        ShimmerCard(height: height, width: width, orientation: orientation),
        Container(
          height: orientation == Orientation.portrait ? height : width,
          width: orientation == Orientation.portrait ? width : height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistView(model: model),
                      ));

                  // DashBoardController.my.index = 6;
                  // DashBoardController.my.update();
                },
                child: Card(
                  elevation: 5,
                  color: Colors.transparent,
                  shadowColor: MyThemeData.onSurface,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: orientation == Orientation.portrait
                        ? height * 0.13
                        : height * 0.27,
                    width: orientation == Orientation.portrait
                        ? width
                        : width * 0.5,
                    foregroundDecoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          model.thumbnailimageURL!,
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('category')
                              .doc(model.categoryID)
                              .collection('playlist')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                height: height * 0.03,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Text(
                                        '${snapshot.data!.docs.length ?? 0} videos',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: WhiteSpinkitFlutter.spinkit,
                              );
                            }
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  model.categoryName!,
                  style: TextStyle(
                      color: MyThemeData.whitecolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  '${model.categoryTimeline} | intensity *',
                  style: TextStyle(color: MyThemeData.whitecolor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
