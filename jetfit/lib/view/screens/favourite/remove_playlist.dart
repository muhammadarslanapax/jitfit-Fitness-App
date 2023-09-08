import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/challenge_tabs.dart';
import 'package:jetfit/view/screens/dashboard.dart';
import 'package:jetfit/view/screens/favourite/remove_favourite_controller.dart';

class RemovePlaylist extends StatefulWidget {
  CategoryModel model;
  RemovePlaylist({
    super.key,
    required this.model,
  });

  @override
  State<RemovePlaylist> createState() => _RemovePlaylistState();
}

class _RemovePlaylistState extends State<RemovePlaylist> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    Get.put(DashBoardController());
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              DashBoardController.my.index = 3;
              DashBoardController.my.update();
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
        return GetBuilder<RemovePlaylistFavouriteController>(
            initState: (state) {
          Get.put(RemovePlaylistFavouriteController());
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
                                              Column(
                                                children: [
                                                  Text(
                                                    widget
                                                        .model.categoryTimeline
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Duration",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.02),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      widget.model.dificulty
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Intensity",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    widget.model.instructor
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Instructor",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
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
                                                        'Remove Favourite',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      content: const Text(
                                                        'Are you sure you want to Remove Favourite?',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            obj.removetofavourite(
                                                                widget.model,
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                MyThemeData
                                                                    .greyColor,
                                                          ),
                                                          child: const Text(
                                                              'Remove'),
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
                                                    ? Icons
                                                        .favorite_border_rounded
                                                    : Icons.favorite,
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
                                                Column(
                                                  children: [
                                                    Text(
                                                      widget.model
                                                          .categoryTimeline
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.02,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Duration",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      widget.model.dificulty
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.02,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Intensity",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      widget.model.instructor
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: width * 0.02,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Instructor",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
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
                                                          'Remove Favourite',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        content: const Text(
                                                          'Are you sure you want to Remove Favourite?',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              obj.removetofavourite(
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
                                                                'Remove'),
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
                                                      ? Icons
                                                          .favorite_border_rounded
                                                      : Icons.favorite,
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
