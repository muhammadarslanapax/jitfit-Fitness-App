import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/favourite_controller.dart';
import 'package:jetfit/controllers/training_controller.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/favourite/remove_fav.dart';
import 'package:jetfit/view/screens/favourite/remove_playlist.dart';
import 'package:jetfit/view/screens/home01/home01_controller.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/view/screens/home01/home_01.dart';
import 'package:jetfit/view/widgets/exclusive_card.dart';
import 'package:jetfit/view/widgets/premium_card.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var height, width;

  @override
  void initState() {
    Get.put(DashBoardController());
    Get.put(TrainingController());
    Get.put(FavouriteController());
    FavouriteController.my.ispremuimclick = false;
    FavouriteController.my.isexclusiveclick = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MyThemeData.background,
        body: GetBuilder<FavouriteController>(builder: (controller) {
          return OrientationBuilder(builder: (context, orientation) {
            return SizedBox(
              height: height,
              width: width,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: orientation == Orientation.portrait
                            ? 0
                            : width * 0.005),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: orientation == Orientation.portrait
                                ? width * 0.08
                                : width * 0.15,
                            bottom: orientation == Orientation.portrait
                                ? height * 0.01
                                : height * 0.01,
                          ),
                          child: InkWell(
                            child: Text(
                              l.favorites,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? width * 0.05
                                      : width * 0.03),
                            ),
                          ),
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
                          height: height * 0.01,
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
                                        .collection("favourite")
                                        .doc(Staticdata.uid)
                                        .collection("userplaylist")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                            // width: width,
                                            // height: height,
                                            // child: Center(
                                            //   child: WhiteSpinkitFlutter.spinkit,
                                            // ),
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
                                            classType:
                                                document.get("classType"),
                                            dificulty:
                                                document.get("dificulty"),
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
                                            thumbnailimageURL: document
                                                .get("thumbnailimageURL"),
                                            categoryTimeline: document
                                                .get("categoryTimeline"),
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
                                                    filteredDocuments[index].get(
                                                        "thumbnailimageURL"),
                                                categoryTimeline:
                                                    filteredDocuments[index]
                                                        .get(
                                                            "categoryTimeline"),
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
                                        .collection("favourite")
                                        .doc(Staticdata.uid)
                                        .collection("userVideos")
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
                                          final model = VideossModel(
                                            catagorytpe:
                                                document.get("catagorytpe"),
                                            classType:
                                                document.get("classType"),
                                            dificulty:
                                                document.get("dificulty"),
                                            duration: document.get("duration"),
                                            instructor:
                                                document.get("instructor"),
                                            videoDescription: document
                                                .get("videoDescription"),
                                            videoID: document.get("videoID"),
                                            videoLanguage:
                                                document.get("videoLanguage"),
                                            videoName:
                                                document.get("videoName"),
                                            videoURL: document.get("videoURL"),
                                            videotype:
                                                document.get("videotype"),
                                            viewers: document.get("viewers"),
                                            price: document.get("price"),
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
                                                catagorytpe:
                                                    filteredDocuments[index]
                                                        .get("catagorytpe"),
                                                classType:
                                                    filteredDocuments[index]
                                                        .get("classType"),
                                                dificulty:
                                                    filteredDocuments[index]
                                                        .get("dificulty"),
                                                duration:
                                                    filteredDocuments[index]
                                                        .get("duration"),
                                                instructor:
                                                    filteredDocuments[index]
                                                        .get("instructor"),
                                                videoDescription:
                                                    filteredDocuments[index]
                                                        .get(
                                                            "videoDescription"),
                                                videoID:
                                                    filteredDocuments[index]
                                                        .get("videoID"),
                                                videoLanguage:
                                                    filteredDocuments[index]
                                                        .get("videoLanguage"),
                                                videoName:
                                                    filteredDocuments[index]
                                                        .get("videoName"),
                                                videoURL:
                                                    filteredDocuments[index]
                                                        .get("videoURL"),
                                                videotype:
                                                    filteredDocuments[index]
                                                        .get("videotype"),
                                                viewers:
                                                    filteredDocuments[index]
                                                        .get("viewers"),
                                                price: filteredDocuments[index]
                                                    .get("price"),
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
                  FavouriteController.my.ispremuimclick ||
                          FavouriteController.my.isexclusiveclick
                      ? InkWell(
                          onTap: () {
                            FavouriteController.my.ispremuimclick = false;
                            FavouriteController.my.isexclusiveclick = false;
                            FavouriteController.my.update();
                          },
                          child: Container(
                            height: height,
                            width: width,
                            color: MyThemeData.background.withOpacity(0.3),
                          ),
                        )
                      : const SizedBox(),
                  FavouriteController.my.ispremuimclick == false
                      ? SizedBox()
                      : PremiumContentWidget(
                          isPremiumClick: FavouriteController.my.ispremuimclick,
                          orientation: Orientation.portrait,
                          videossModel: FavouriteController.my.videossModel!,
                          controller: FavouriteController.my,
                        ),
                  FavouriteController.my.isexclusiveclick == false
                      ? SizedBox()
                      : ExclusiveCardWidget(
                          isexclusiveclick:
                              FavouriteController.my.isexclusiveclick,
                          orientation: Orientation.portrait,
                          videossModel: FavouriteController.my.videossModel!,
                          controller: FavouriteController.my,
                        ),
                ],
              ),
            );
          });
        }));
  }
}
///////////////////////////////////////////

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
    Get.put(FavouriteController());
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
                  child: FavPlayer(
                    videoModal: model,
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
    return GetBuilder<FavouriteController>(builder: (controller) {
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
                          builder: (context) => RemovePlaylist(model: model),
                        ));
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
                                        padding:
                                            const EdgeInsets.only(right: 12),
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
    });
  }
}

class FavPlayer extends StatefulWidget {
  final VideossModel? videoModal;

  FavPlayer({super.key, this.videoModal});

  @override
  _FavPlayerState createState() => _FavPlayerState();
}

class _FavPlayerState extends State<FavPlayer> {
  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    Get.put(DashBoardController());
    Get.put(Home01Controller());
    Get.put(FavouriteController());
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoModal!.videoURL!));
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
                            print("oijfr ${widget.videoModal!.videotype!}");
                            if (widget.videoModal!.videotype! == "Premium") {
                              if (Staticdata.ispremium!) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RemoveFav(
                                        videoModal: widget.videoModal!),
                                  ),
                                );
                              } else {
                                FavouriteController.my
                                    .premiumClickModel(widget.videoModal!);
                              }
                            } else if (widget.videoModal!.videotype! ==
                                "Exclusive") {
                              FavouriteController.my
                                  .exclusiveClickModel(widget.videoModal!);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RemoveFav(videoModal: widget.videoModal!),
                                ),
                              );
                            }
                          },
                          child: Icon(
                            Icons.play_arrow,
                            size: 50,
                            color: Colors.white,
                          )),
                    ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
              // width: width * 0.1,
              // height: height * 0.12,
              // child: Center(
              //   child: WhiteSpinkitFlutter.spinkit,
              // ),
              );
        }
      },
    );
  }
}
