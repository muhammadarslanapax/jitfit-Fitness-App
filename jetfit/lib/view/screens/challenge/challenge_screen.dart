import 'package:get/get.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/challenge/challenge_controller.dart';
import 'package:jetfit/view/screens/cover_player/cover_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jetfit/view/screens/dashboard.dart';

class ChallengeScreen extends StatefulWidget {
  VideossModel videoModel;
  ChallengeScreen({
    required this.videoModel,
    super.key,
  });

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  var height, width;
  bool play = false;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoard(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return GetBuilder<ChallengeController>(initState: (state) {
          Get.put(ChallengeController());
          ChallengeController.instance.isclick = false;
        }, builder: (obj) {
          return play == true
              ? Container()
              : Container(
                  height: height,
                  width: width,
                  color: MyThemeData.background,
                  child: orientation == Orientation.portrait
                      ? Stack(
                          children: [
                            Container(
                              height: height,
                              width: width,
                              child: CoverPlayer(
                                ishomecontroller: false,
                                issearchcontroller: false,
                                istrainignCOntroller: false,
                                isIcon: false,
                                videoModal: widget.videoModel,
                                isvideomodel: true,
                              ),
                            ),
                            Container(
                              height: height,
                              width: width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.65),
                                    Colors.black.withOpacity(0.65),
                                    Colors.black.withOpacity(0.7),
                                    Colors.black.withOpacity(0.8),
                                    Colors.black.withOpacity(0.85),
                                    Colors.black.withOpacity(0.9),
                                    MyThemeData.background,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 0.07),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: height * 0.4,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.1),
                                        child: SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.videoModel.classType
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${widget.videoModel.viewers!.length}',
                                                      style: TextStyle(
                                                        color: MyThemeData
                                                            .greyColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " views",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MyThemeData
                                                            .whitecolor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                widget.videoModel.videoName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.06,
                                                ),
                                              ),
                                              Text(
                                                widget
                                                    .videoModel.videoDescription
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          widget.videoModel
                                                              .duration
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Duration",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  width * 0.02),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            widget.videoModel
                                                                .dificulty
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Intensity",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          play = true;
                                                          print("play ${play}");
                                                        });
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            widget.videoModel
                                                                .instructor
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Instructor",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                VideoPlayerScreen(
                                                                    videooo: widget
                                                                        .videoModel),
                                                          ));
                                                    },
                                                    child: Container(
                                                      height: height * 0.05,
                                                      width: width * 0.35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .play_arrow_outlined,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            l.startVideo,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.03,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                MyThemeData
                                                                    .background,
                                                            title: const Text(
                                                              'Add Favourite',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            content: const Text(
                                                              'Are you sure you want to Add to Favourite?',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  obj.addtofavourite(
                                                                      widget
                                                                          .videoModel,
                                                                      context);
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      MyThemeData
                                                                          .greyColor,
                                                                ),
                                                                child:
                                                                    const Text(
                                                                        'Add'),
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
                                                    icon: Icon(
                                                      obj.isclick
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: height,
                                width: width,
                                color: MyThemeData.background,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: height,
                                      width: width,
                                      child: CoverPlayer(
                                        ishomecontroller: false,
                                        issearchcontroller: false,
                                        istrainignCOntroller: false,
                                        isIcon: false,
                                        videoModal: widget.videoModel,
                                        isvideomodel: true,
                                      ),
                                    ),
                                    Container(
                                      height: height,
                                      width: width,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          transform: GradientRotation(-35),
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.black.withOpacity(0.65),
                                            Colors.black.withOpacity(0.75),
                                            Colors.black.withOpacity(0.8),
                                            Colors.black.withOpacity(0.9),
                                            Colors.black.withOpacity(0.95),
                                            MyThemeData.background,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: width * 0.15,
                                          top: height * 0.12,
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            height: height * 0.75,
                                            width: width * 0.6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.videoModel.classType
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  widget.videoModel.videoName
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  widget.videoModel
                                                      .videoDescription
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: width * 0.02,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.32,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            widget.videoModel
                                                                .duration
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  width * 0.02,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Duration",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize:
                                                                  width * 0.02,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            widget.videoModel
                                                                .dificulty
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  width * 0.02,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Intensity",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize:
                                                                  width * 0.02,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            widget.videoModel
                                                                .instructor
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  width * 0.02,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Instructor",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize:
                                                                  width * 0.02,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoPlayerScreen(
                                                                videooo: widget
                                                                    .videoModel,
                                                              ),
                                                            ));
                                                      },
                                                      child: Container(
                                                        height: height * 0.09,
                                                        width: width * 0.15,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Image(
                                                              image: AssetImage(
                                                                  'images/training/play_arrow_24px.png'),
                                                            ),
                                                            Text(
                                                              "Start session",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.03,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  MyThemeData
                                                                      .background,
                                                              title: const Text(
                                                                'Add Favourite',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              content:
                                                                  const Text(
                                                                'Are you sure you want to Add to Favourite?',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    obj.addtofavourite(
                                                                        widget
                                                                            .videoModel,
                                                                        context);
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        MyThemeData
                                                                            .greyColor,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                          'Add'),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        MyThemeData
                                                                            .redColour,
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
                                                      },
                                                      icon: Icon(
                                                        obj.isclick
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                );
        });
      }),
    );
  }
}
