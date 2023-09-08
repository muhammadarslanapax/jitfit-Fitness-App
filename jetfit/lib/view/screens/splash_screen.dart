import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jetfit/controllers/dahboard_controller.dart';
import 'package:jetfit/controllers/setting_controller.dart';
import 'package:jetfit/main.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/profile_selector/profile_selector.dart';
import 'package:jetfit/web_view/auth/welcome_screen/welcome_screen.dart';
import 'package:jetfit/web_view/home_screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class MyCustomSplashScreen extends StatefulWidget {
  const MyCustomSplashScreen({super.key});

  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  bool notificationinfo = false;
  AnimationController? _controller;
  Animation<double>? animation1;

  List<UserModel>? userModels = [];
  String? t;

  // void getTokan() async {
  //   await FirebaseMessaging.instance.getToken().then((value) {
  //     t = value!;
  //     print("token ${t}");
  //   });
  // }

  void notificationdatacheck(context) {
    FirebaseMessaging.instance.subscribeToTopic("myTopic1");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  color: Colors.black,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ));
      }
    });
  }

  void getuserlist() async {
    userModels = await SettingController.my.getUserListFromPrefs();
  }

  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    Get.put(SettingController());
    Get.put(DashBoardController());
    if (kIsWeb) {
    } else {
      // getTokan();

      notificationdatacheck(context);
      getuserlist();
    }

    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller!.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? v = prefs.getString('UserId');
      setState(() {
        if (v == null) {
          Staticdata.uid = v;

          Navigator.pushReplacement(
            context,
            PageTransition(
              kIsWeb
                  ? const WelcomeScreen()
                  :
                  // SubscriptionSCreen(),

                  userModels!.isNotEmpty
                      ? ProfileSelector(userModels: userModels ?? [])
                      : DashBoard(),
            ),
          );
        } else {
          Staticdata.uid = v;

          Navigator.pushReplacement(
              context,
              PageTransition(
                kIsWeb ? const AdminHome() : const DashBoard(),
              ));

          ////
        }
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Image(
                  height: animation1!.value,
                  image: const AssetImage('images/logo.png'),
                ),
              ),
            ],
          ),
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: _containerOpacity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: width / _containerSize,
                  width: width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('images/home/persons.png'),
                    ),
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
