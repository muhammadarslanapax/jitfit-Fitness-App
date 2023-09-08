import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jetfit/utilis/theme_data.dart';

void showtoast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: MyThemeData.background,
    textColor: MyThemeData.whitecolor,
    gravity: ToastGravity.BOTTOM,
    fontSize: 17,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_LONG,
  );
}

const double defaultPadding = 16.0;

class SpinkitFlutter {
  static var spinkit = CircularProgressIndicator(
    backgroundColor: Colors.white,
    valueColor: AlwaysStoppedAnimation<Color>(
      Colors.black, //<-- SEE HERE
    ),
  );
}

class WhiteSpinkitFlutter {
  static var spinkit = CircularProgressIndicator(
    backgroundColor: Colors.black26,
    valueColor: AlwaysStoppedAnimation<Color>(
      Colors.white, //<-- SEE HERE
    ),
  );
}
