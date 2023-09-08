import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/dashboard.dart';
import 'package:jetfit/view/screens/favourite/playlist/view_playlist_controller.dart';
import 'package:jetfit/view/screens/challenge_tabs.dart';
import 'package:jetfit/view/screens/feedback/feedback.dart';

class PlaylistView extends StatefulWidget {
  CategoryModel model;
  PlaylistView({
    super.key,
    required this.model,
  });

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
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
      backgroundColor: MyThemeData.background,
      body: OrientationBuilder(builder: (context, orientation) {
        return GetBuilder<ViewPlaylistController>(initState: (state) {
          Get.put(ViewPlaylistController());
          ViewPlaylistController.instance.isclick = false;
        }, builder: (obj) {
          return Container(
            height: height,
            width: width,
            child: orientation == Orientation.portrait
                ? Stack(
                    children: [
                      Container(
                          height: height,
                          width: width,
                          color: MyThemeData.background,
                          child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  widget.model.thumbnailimageURL!))),
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
                                  padding: EdgeInsets.only(left: width * 0.1),
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.model.classType.toString(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          widget.model.categoryName.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.06,
                                          ),
                                        ),
                                        Text(
                                          widget.model.categoryDescription
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
                                              Text(
                                                widget.model.categoryTimeline
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.02),
                                                child: Text(
                                                  widget.model.dificulty
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                widget.model.instructor
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
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
                                                          ChallengeTabsScreen(
                                                              model:
                                                                  widget.model),
                                                    ));
                                              },
                                              child: Container(
                                                height: height * 0.05,
                                                width: width * 0.35,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    Text(
                                                      "Start Program",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FeedbackProgram(
                                                              model:
                                                                  widget.model),
                                                    ));
                                              },
                                              child: Container(
                                                  height: height * 0.05,
                                                  width: width * 0.35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .feedback_outlined,
                                                          color: Colors.black,
                                                        ),
                                                        Text(
                                                          "FeedBack",
                                                        ),
                                                      ],
                                                    ),
                                                  )),
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      content: const Text(
                                                        'Are you sure you want to Add to Favourite?',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            obj.addtofavourite(
                                                                widget.model,
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                MyThemeData
                                                                    .greyColor,
                                                          ),
                                                          child:
                                                              const Text('Add'),
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
                                                        .favorite_border_outlined,
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
                                  child: Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          widget.model.thumbnailimageURL!))),
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
                                            widget.model.classType.toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            widget.model.categoryName
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.035,
                                            ),
                                          ),
                                          Text(
                                            widget.model.categoryDescription
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: width * 0.02,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.22,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  widget.model.categoryTimeline
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.02,
                                                  ),
                                                ),
                                                Text(
                                                  widget.model.dificulty
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.02,
                                                  ),
                                                ),
                                                Text(
                                                  widget.model.instructor
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.02,
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
                                                            ChallengeTabsScreen(
                                                                model: widget
                                                                    .model),
                                                      ));
                                                },
                                                child: Container(
                                                  height: height * 0.09,
                                                  width: width * 0.15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: const Row(
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
                                                        "Start Program",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FeedbackProgram(
                                                                model: widget
                                                                    .model),
                                                      ));
                                                },
                                                child: Container(
                                                    height: height * 0.09,
                                                    width: width * 0.15,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .feedback_outlined,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            "FeedBack",
                                                          ),
                                                        ],
                                                      ),
                                                    )),
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        content: const Text(
                                                          'Are you sure you want to Add to Favourite?',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              obj.addtofavourite(
                                                                  widget.model,
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  MyThemeData
                                                                      .greyColor,
                                                            ),
                                                            child: const Text(
                                                                'Add'),
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
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
                                                          .favorite_border_outlined,
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


//////////////////
