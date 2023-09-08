import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/view/screens/profile_selector/profile_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jetfit/utilis/static_data.dart';

class SettingController extends GetxController {
  static SettingController get my => Get.find();
  int index = 0;
  int unitspreferencesindex = 0;
  int language = 0;
  int subtitlelanguage = 0;
  int videoresolution = 0;
  bool subtitles = false;
  bool ispotraitmodeclick = false;
  int accountsettings = 0;
  int jetfitpremium = 0;

  Future<void> setLanguagePreference(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language', value);
    language = value; // Update the local language value
    update(); // Notify GetX that the state has changed
  }

  Future<void> getLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getInt('language') ?? 0; // Default value is 0 if not found
    // Notify GetX that the state has changed
  }

  void saveUserListToPrefs(List<UserModel> userList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userJsonList =
        userList.map((user) => jsonEncode(user.toJson())).toList();
    prefs.setStringList('user_list', userJsonList);
  }

  Future<List<UserModel>> getUserListFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userJsonList = prefs.getStringList('user_list');

    if (userJsonList != null) {
      return userJsonList
          .map((userJson) => UserModel.fromJson(jsonDecode(userJson)))
          .toList();
    }

    return [];
  }

  Future<List<UserModel>> addorupdateUser() async {
    List<UserModel> userList = await getUserListFromPrefs();
    int updateindex = userList
        .indexWhere((element) => element.id == Staticdata.userModel!.id);
    if (updateindex != -1) {
      userList[updateindex] = Staticdata.userModel!;
      update();
    } else {
      userList.add(Staticdata.userModel!);
    }
    return userList;
  }

  void logoutfunction(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('UserId');
    List<UserModel> userList = await getUserListFromPrefs();
    userList = await addorupdateUser();
    saveUserListToPrefs(userList);
    await getUserListFromPrefs().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileSelector(userModels: value),
          ));
    });
  }
}
