import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var height, width;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyThemeData.background,
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: MyThemeData.background,
        body: OrientationBuilder(builder: (context, orientation) {
          return GetBuilder<ProfileController>(initState: (state) {
            Get.put(ProfileController());
            ProfileController.instance.nameController.text =
                Staticdata.userModel!.name! ?? '';
          }, builder: (obj) {
            return Stack(
              children: [
                orientation == Orientation.portrait
                    ? portraitMode(obj, key)
                    : landscapeMode(obj, key),
                obj.isLoading == true
                    ? Center(
                        child: Container(
                            height: height,
                            width: width,
                            color: Colors.white.withOpacity(0.3),
                            child: WhiteSpinkitFlutter.spinkit))
                    : SizedBox(),
              ],
            );
          });
        }));
  }

  Widget portraitMode(ProfileController obj, GlobalKey<FormState> key) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            color: MyThemeData.background,
                            height: height * 0.1,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    obj.getGalleryImage();
                                    Navigator.pop(context);
                                  },
                                  child: BtmSheetIcon(
                                      height: height * 0.035,
                                      text: 'Gallery',
                                      icon: Icons.photo),
                                ),
                                InkWell(
                                  onTap: () {
                                    obj.getCameraImage();
                                    Navigator.pop(context);
                                  },
                                  child: BtmSheetIcon(
                                    height: height * 0.035,
                                    text: 'Camera',
                                    icon: Icons.camera_alt,
                                  ),
                                )
                              ],
                            ),
                          ));
                },
                child: obj.selectedImage.value == null
                    ? Staticdata.userModel!.imageURL!.isEmpty ||
                            Staticdata.userModel!.imageURL == ''
                        ? CircleAvatar(
                            child: Icon(Icons.person), radius: width * 0.14)
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage(Staticdata.userModel!.imageURL!),
                            radius: width * 0.14)
                    : CircleAvatar(
                        backgroundImage:
                            FileImage(File(obj.selectedImage.value!.path)),
                        radius: width * 0.14)),
            SizedBox(height: height * 0.1),
            customTextFilled(
              obj,
              'Name',
              key,
            ),
            SizedBox(height: height * 0.1),
            ElevatedButton(
              onPressed: () {
                obj.uploadImage(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyThemeData.background,
                elevation: 5, // Add elevation
                shadowColor: MyThemeData.onSurface, // Set shadow color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Set border radius
                  side: BorderSide(
                    color: Colors.black, // Set border color
                    width: 1.0, // Set border width
                  ),
                ),
              ),
              child: Container(
                height: 40,
                width: width,
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landscapeMode(ProfileController obj, GlobalKey<FormState> key) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.08, vertical: height * 0.15),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.1,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    color: MyThemeData.background,
                    height: height * 0.1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            obj.getGalleryImage();
                            Navigator.pop(context);
                          },
                          child: BtmSheetIcon(
                            height: height * 0.035,
                            text: 'Gallery',
                            icon: Icons.photo,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            obj.getCameraImage();
                            Navigator.pop(context);
                          },
                          child: BtmSheetIcon(
                            height: height * 0.035,
                            text: 'Camera',
                            icon: Icons.camera_alt,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: obj.selectedImage.value == null
                  ? Staticdata.userModel!.imageURL!.isEmpty ||
                          Staticdata.userModel!.imageURL == ''
                      ? CircleAvatar(
                          child: Icon(Icons.person),
                          radius: width * 0.1,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(Staticdata.userModel!.imageURL!),
                          radius: width * 0.1,
                        )
                  : CircleAvatar(
                      backgroundImage:
                          FileImage(File(obj.selectedImage.value!.path)),
                      radius: width * 0.1,
                    ),
            ),
            SizedBox(
              width: width * 0.1,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customTextFilled(
                    obj,
                    'Name',
                    key,
                  ),
                  SizedBox(height: height * 0.05), // Adjusted spacing
                  ElevatedButton(
                    onPressed: () {
                      obj.uploadImage(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyThemeData.background,
                      elevation: 5,
                      shadowColor: MyThemeData.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Container(
                      height: 40,
                      width: width,
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFilled(
      ProfileController obj, String hint, GlobalKey<FormState> key) {
    return OrientationBuilder(builder: (context, orientation) {
      return Form(
        key: key,
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
                maxLines: 1,
                controller: obj.nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 10),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

class BtmSheetIcon extends StatelessWidget {
  double height;
  String text;
  IconData icon;

  BtmSheetIcon(
      {super.key,
      required this.height,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: height,
          color: Colors.white,
        ),
        Text(text, style: const TextStyle(color: Colors.white))
      ],
    );
  }
}
