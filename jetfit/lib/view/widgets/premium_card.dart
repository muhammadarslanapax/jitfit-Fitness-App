import 'package:flutter/material.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/paypal/subscription/subscription_screen.dart';
import 'package:jetfit/view/screens/trainigng_screen.dart';

class PremiumContentWidget extends StatelessWidget {
  final bool isPremiumClick;
  final Orientation orientation;
  final VideossModel videossModel;
  var controller; // Added the controller parameter

  PremiumContentWidget({
    required this.isPremiumClick,
    required this.orientation,
    required this.videossModel,
    required this.controller, // Initialize the controller parameter
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return isPremiumClick
        ? Align(
            alignment: Alignment.center,
            child: orientation == Orientation.portrait
                ? Stack(
                    children: [
                      Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shadowColor: MyThemeData.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: height * 0.6,
                          width: width * 0.75,
                          decoration: BoxDecoration(
                            color: MyThemeData.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                height: height * 0.35,
                                width: width,
                                decoration: BoxDecoration(
                                  color: MyThemeData.background,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TrainingCoverVideo(
                                  playListModel: videossModel,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: height * 0.33,
                                  width: width * 0.65,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        videossModel.videoName!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${videossModel.duration} | intensity ***',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        videossModel.videoDescription!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubscriptionSCreen(),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5,
                                            color: Colors.transparent,
                                            shadowColor: MyThemeData.onSurface,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Container(
                                              height: height * 0.045,
                                              width: width * 0.5,
                                              decoration: BoxDecoration(
                                                color: MyThemeData.background,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image(
                                                    height: height * 0.025,
                                                    image: AssetImage(
                                                      'images/premium.png',
                                                    ),
                                                  ),
                                                  Text(
                                                    "Switch to premium",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.ispremuimclick = false;
                                          controller.update();
                                        },
                                        child: Center(
                                          child: Container(
                                            height: height * 0.045,
                                            width: width * 0.5,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              controller.ispremuimclick = false;
                              controller.update();
                            },
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Center(
                                child: Image.asset(
                                  "images/close.png",
                                  height: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                :
                // landsacpe
                Stack(
                    children: [
                      Card(
                        elevation: 5,
                        color: Colors.transparent,
                        shadowColor: MyThemeData.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: height * 0.7, // Adjust the height as needed
                          width: width * 0.8, // Adjust the width as needed
                          decoration: BoxDecoration(
                            color: MyThemeData.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    height * 0.3, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  color: MyThemeData.background,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: TrainingCoverVideo(
                                  playListModel: videossModel,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      videossModel.videoName!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            20, // Adjust the font size as needed
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '${videossModel.duration} | Intensity ***',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            16, // Adjust the font size as needed
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      videossModel.videoDescription!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            16, // Adjust the font size as needed
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SubscriptionSCreen(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.transparent,
                                    shadowColor: MyThemeData.onSurface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Container(
                                      height: 50, // Adjust the height as needed
                                      width: width *
                                          0.5, // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        color: MyThemeData.background,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            height:
                                                25, // Adjust the height as needed
                                            image: AssetImage(
                                                'images/premium.png'),
                                          ),
                                          Text(
                                            "Switch to Premium",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  16, // Adjust the font size as needed
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    controller.ispremuimclick = false;
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 50, // Adjust the height as needed
                                    width: width *
                                        0.5, // Adjust the width as needed
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              16, // Adjust the font size as needed
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              controller.ispremuimclick = false;
                              controller.update();
                            },
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Center(
                                child: Image.asset(
                                  "images/close.png",
                                  height: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
        : SizedBox();
  }
}
