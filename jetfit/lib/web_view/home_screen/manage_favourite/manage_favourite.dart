import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/home_screen/manage_catagory/video_players.dart';
import 'package:jetfit/web_view/home_screen/manage_favourite/manage_favourite_controller.dart';
import 'package:get/get.dart';

class ManageFavourite extends StatefulWidget {
  const ManageFavourite({super.key});

  @override
  State<ManageFavourite> createState() => _ManageFavouriteState();
}

class _ManageFavouriteState extends State<ManageFavourite> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<ManageFAvouriteController>(initState: (state) {
        Get.put(ManageFAvouriteController());
        ManageFAvouriteController.my.is_edit_favourite_click = false;
      }, builder: (obj) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: width * 0.05),
                  width: width,
                  height: height * 0.1,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "MANAGE FAVOURITES",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.08),
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: width,
                    height: height * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.01, top: height * 0.03),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  'Users',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: MyThemeData.background,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: width * 0.5,
                                ),
                                SizedBox(
                                  width: width * 0.16,
                                  child: Textformfield(
                                    hinttext: "Search User",
                                    controller: obj.searchusercontroller,
                                    abscureText: false,
                                    onChanged: (value) {
                                      obj.name = value;
                                      obj.update();
                                    },
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: MyThemeData.greyColor,
                                    ),
                                    keyboardtype: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.025, top: height * 0.03),
                            child: Row(
                              children: [
                                lableTextname("No"),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                lableTextname("Profile"),
                                SizedBox(
                                  width: width * 0.19,
                                ),
                                lableTextname("Email"),
                                SizedBox(
                                  width: width * 0.175,
                                ),
                                lableTextname("Role"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: obj.firebaseFirestore
                                      .collection('User')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: SpinkitFlutter.spinkit,
                                      );
                                    } else if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          UserModel model = UserModel(
                                            createdAt: snapshot
                                                .data!.docs[index]
                                                .get("createdAt"),
                                            isOnline: snapshot.data!.docs[index]
                                                .get("isOnline"),
                                            lastActive: snapshot
                                                .data!.docs[index]
                                                .get("lastActive"),
                                            tokan: snapshot.data!.docs[index]
                                                .get("tokan"),
                                            email: snapshot.data!.docs[index]
                                                .get("email"),
                                            id: snapshot.data!.docs[index]
                                                .get("id"),
                                            imageURL: snapshot.data!.docs[index]
                                                .get("imageURL"),
                                            name: snapshot.data!.docs[index]
                                                .get("name"),
                                            password: snapshot.data!.docs[index]
                                                .get("password"),
                                            role: snapshot.data!.docs[index]
                                                .get("role"),
                                            status: snapshot.data!.docs[index]
                                                .get("status"),
                                          );

                                          if (obj.name.isEmpty ||
                                              obj.name == '') {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  //////////////// viewer image
                                                  SizedBox(
                                                    width: width,
                                                    height: height * 0.09,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: width * 0.05,
                                                          child: Text(
                                                            '${index + 1}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.grey,
                                                            image: model.imageURL ==
                                                                    null
                                                                ? const DecorationImage(
                                                                    image:
                                                                        AssetImage(
                                                                      "images/profile-user.png",
                                                                    ),
                                                                  )
                                                                : DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image:
                                                                        NetworkImage(
                                                                      model
                                                                          .imageURL!,
                                                                    ),
                                                                  ),
                                                          ),
                                                          width: width * 0.06,
                                                          height: height * 0.06,
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.01,
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.17,
                                                          child: Text(
                                                            model.name!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.2,
                                                          child: Text(
                                                            model.email!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.09,
                                                          child: Text(
                                                            model.role!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.02,
                                                        ),
                                                        WebButton(
                                                            text:
                                                                "Manage Favourite",
                                                            color: MyThemeData
                                                                .background,
                                                            onPressed: () {
                                                              obj.manageFavouritetap(
                                                                  model);
                                                            },
                                                            width:
                                                                width * 0.13),
                                                        SizedBox(
                                                          width: width * 0.015,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else if (model.name!
                                              .toLowerCase()
                                              .contains(
                                                  obj.name.toLowerCase())) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  //////////////// viewer image
                                                  SizedBox(
                                                    width: width,
                                                    height: height * 0.09,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: width * 0.05,
                                                          child: Text(
                                                            '${index + 1}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        model.imageURL == null
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .grey,
                                                                        image:
                                                                            const DecorationImage(
                                                                          image:
                                                                              AssetImage(
                                                                            "images/profile-user.png",
                                                                          ),
                                                                        )),
                                                                width: width *
                                                                    0.06,
                                                                height: height *
                                                                    0.06,
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  model
                                                                      .imageURL!,
                                                                  errorBuilder:
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                    return Text(
                                                                        'Error loading image');
                                                                  },
                                                                ),
                                                                width: width *
                                                                    0.06,
                                                                height: height *
                                                                    0.06,
                                                              ),
                                                        SizedBox(
                                                          width: width * 0.01,
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.17,
                                                          child: Text(
                                                            model.name!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.2,
                                                          child: Text(
                                                            model.email!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.09,
                                                          child: Text(
                                                            model.role!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyThemeData
                                                                    .background,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.02,
                                                        ),
                                                        WebButton(
                                                            text:
                                                                "Manage Favourite",
                                                            color: MyThemeData
                                                                .background,
                                                            onPressed: () {
                                                              obj.manageFavouritetap(
                                                                  model);
                                                            },
                                                            width:
                                                                width * 0.13),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: Text('No Users'));
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

///////////////////////////////////////////
            obj.is_edit_favourite_click == true
                ? Padding(
                    padding: EdgeInsets.only(top: height * 0.08),
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: width,
                          height: height * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.01, top: height * 0.03),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          obj.is_edit_favourite_click = false;
                                          obj.update();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: MyThemeData.background,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                          '${obj.userModel!.name}\'s Favourites',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: MyThemeData.background,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.25,
                                      ),
                                      SizedBox(
                                        width: width * 0.16,
                                        child: Textformfield(
                                          onChanged: (value) {
                                            obj.name = value;
                                            obj.update();
                                          },
                                          hinttext: "Search Video",
                                          controller: obj.searchusercontroller,
                                          abscureText: false,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: MyThemeData.greyColor,
                                          ),
                                          keyboardtype: TextInputType.name,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height,
                                    width: width,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          // lableTextname("Favourite Videos"),
                                          /////////////////////////
                                          StreamBuilder<QuerySnapshot>(
                                              stream: obj.firebaseFirestore
                                                  .collection("favourite")
                                                  .doc(obj.userModel!.id)
                                                  .collection("userVideos")
                                                  .snapshots(),
                                              builder: (context,
                                                  userplaylistsnapshot) {
                                                if (userplaylistsnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child: WhiteSpinkitFlutter
                                                        .spinkit,
                                                  );
                                                } else if (userplaylistsnapshot
                                                    .hasError) {
                                                  return Text(
                                                      'Error: ${userplaylistsnapshot.error}');
                                                } else if (!userplaylistsnapshot
                                                        .hasData ||
                                                    userplaylistsnapshot
                                                        .data!.docs.isEmpty) {
                                                  return Container();
                                                } else {
                                                  return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemCount:
                                                        userplaylistsnapshot
                                                            .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      VideossModel model =
                                                          VideossModel(
                                                        price:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get("price"),
                                                        catagorytpe:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "catagorytpe"),
                                                        classType:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "classType"),
                                                        dificulty:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "dificulty"),
                                                        duration:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "duration"),
                                                        instructor:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "instructor"),
                                                        videoDescription:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "videoDescription"),
                                                        videoID:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get("videoID"),
                                                        videoLanguage:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "videoLanguage"),
                                                        videoName:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "videoName"),
                                                        videoURL:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "videoURL"),
                                                        videotype:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "videotype"),
                                                        viewers:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get("viewers"),
                                                      );

                                                      if (obj.name.isEmpty ||
                                                          obj.name == '') {
                                                        return FavouritePlaylistPlayer(
                                                            model: model,
                                                            uid: obj.userModel!
                                                                .id!);
                                                      } else if (model
                                                          .videoName!
                                                          .toLowerCase()
                                                          .contains(obj.name
                                                              .toLowerCase())) {
                                                        return FavouritePlaylistPlayer(
                                                            model: model,
                                                            uid: obj.userModel!
                                                                .id!);
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  );
                                                }
                                              }),

                                          /////////////////////////////////////////////////////////////

                                          // ////////////////////

                                          // lableTextname("Favourite Categories"),
                                          StreamBuilder<QuerySnapshot>(
                                              stream: obj.firebaseFirestore
                                                  .collection("favourite")
                                                  .doc(obj.userModel!.id)
                                                  .collection("userplaylist")
                                                  .snapshots(),
                                              builder: (context,
                                                  userplaylistsnapshot) {
                                                if (userplaylistsnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child:
                                                        SpinkitFlutter.spinkit,
                                                  );
                                                } else if (userplaylistsnapshot
                                                    .hasError) {
                                                  return Text(
                                                      'Error: ${userplaylistsnapshot.error}');
                                                } else if (!userplaylistsnapshot
                                                        .hasData ||
                                                    userplaylistsnapshot
                                                        .data!.docs.isEmpty) {
                                                  return Container();
                                                } else {
                                                  return ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    itemCount:
                                                        userplaylistsnapshot
                                                            .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      CategoryModel
                                                          categoryModel =
                                                          CategoryModel(
                                                        categoryDescription:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "categoryDescription"),
                                                        categoryID:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "categoryID"),
                                                        categoryName:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "categoryName"),
                                                        categoryTimeline:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "categoryTimeline"),
                                                        categoryType:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "categoryType"),
                                                        classType:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "classType"),
                                                        dificulty:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "dificulty"),
                                                        instructor:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "instructor"),
                                                        playlistType:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "playlistType"),
                                                        thumbnailimageURL:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "thumbnailimageURL"),
                                                        videoLanguage:
                                                            userplaylistsnapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                    "videoLanguage"),
                                                      );

                                                      if (obj.name.isEmpty ||
                                                          obj.name == '') {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.02,
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.1,
                                                                    color: Colors
                                                                        .grey,
                                                                    height:
                                                                        height *
                                                                            0.12,
                                                                    child: categoryModel.thumbnailimageURL ==
                                                                            null
                                                                        ? Center(
                                                                            child:
                                                                                SpinkitFlutter.spinkit)
                                                                        : Image(
                                                                            image: NetworkImage(
                                                                            categoryModel.thumbnailimageURL!,
                                                                          )),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.01,
                                                                  ),
                                                                  //////////////////
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          height *
                                                                              0.11,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          ///////////////////////////
                                                                          Text(
                                                                            categoryModel.categoryName!,
                                                                            style:
                                                                                TextStyle(color: MyThemeData.background, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Text(
                                                                            categoryModel.categoryDescription!,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  WebButton(
                                                                    text:
                                                                        "Delete Favourite",
                                                                    color: MyThemeData
                                                                        .background,
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text('Confirm Delete'),
                                                                            content:
                                                                                const Text('Are you sure you want to delete this Favourite category?'),
                                                                            actions: [
                                                                              ElevatedButton(
                                                                                onPressed: () {
                                                                                  ManageFAvouriteController.my.removetofavourite(obj.userModel!.id!, categoryModel.categoryID!, context);
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: MyThemeData.background,
                                                                                ),
                                                                                child: const Text('Delete'),
                                                                              ),
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: MyThemeData.redColour,
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: const Text('Cancel'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    width:
                                                                        width *
                                                                            0.1,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.07,
                                                                  ),
                                                                ],
                                                              ),
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      } else if (categoryModel
                                                          .categoryName!
                                                          .toLowerCase()
                                                          .contains(obj.name
                                                              .toLowerCase())) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.02,
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        width *
                                                                            0.1,
                                                                    color: Colors
                                                                        .grey,
                                                                    height:
                                                                        height *
                                                                            0.12,
                                                                    child: Image(
                                                                        image: NetworkImage(
                                                                      categoryModel
                                                                          .thumbnailimageURL!,
                                                                    )),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.01,
                                                                  ),
                                                                  //////////////////
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          height *
                                                                              0.11,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          ///////////////////////////
                                                                          Text(
                                                                            categoryModel.categoryName!,
                                                                            style:
                                                                                TextStyle(color: MyThemeData.background, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Text(
                                                                            categoryModel.categoryDescription!,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.grey,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  WebButton(
                                                                    text:
                                                                        "Delete Favourite",
                                                                    color: MyThemeData
                                                                        .background,
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text('Confirm Delete'),
                                                                            content:
                                                                                const Text('Are you sure you want to delete this Favourite category?'),
                                                                            actions: [
                                                                              ElevatedButton(
                                                                                onPressed: () {
                                                                                  ManageFAvouriteController.my.deleteUser(obj.userModel!.id!, categoryModel.categoryID!, context);
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: MyThemeData.background,
                                                                                ),
                                                                                child: const Text('Delete'),
                                                                              ),
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: MyThemeData.redColour,
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: const Text('Cancel'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    width:
                                                                        width *
                                                                            0.1,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        width *
                                                                            0.07,
                                                                  ),
                                                                ],
                                                              ),
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  );
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      }),
    );
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
}
