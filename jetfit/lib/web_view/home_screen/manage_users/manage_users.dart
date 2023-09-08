import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:get/get.dart';

import 'manage_users_controller.dart';

class MangeUsersScreen extends StatefulWidget {
  const MangeUsersScreen({super.key});

  @override
  State<MangeUsersScreen> createState() => _MangeUsersScreenState();
}

class _MangeUsersScreenState extends State<MangeUsersScreen> {
  GlobalKey<FormState> userformKey = GlobalKey<FormState>();

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<ManageUserController>(initState: (state) {
        Get.put(ManageUserController());
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
                      "MANAGE USERS",
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
                                            createdAt:snapshot.data!.docs[index]
                                                .get("createdAt") ,
                                            isOnline:snapshot.data!.docs[index]
                                                .get("isOnline") ,
                                            lastActive: snapshot.data!.docs[index]
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
                                                            text: "Edit",
                                                            color: MyThemeData
                                                                .background,
                                                            onPressed: () {
                                                              obj.edituserclick(
                                                                  model);
                                                            },
                                                            width:
                                                                width * 0.08),
                                                        SizedBox(
                                                          width: width * 0.015,
                                                        ),
                                                        WebButton(
                                                            text: "Delete",
                                                            color: MyThemeData
                                                                .background,
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Confirm Delete'),
                                                                    content:
                                                                        const Text(
                                                                            'Are you sure you want to delete this User?'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          obj.deleteUser(
                                                                            model,
                                                                            context,
                                                                          );
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              MyThemeData.background,
                                                                        ),
                                                                        child: const Text(
                                                                            'Delete'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              MyThemeData.redColour,
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
                                                            width:
                                                                width * 0.08),
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
                                                            text: "Edit",
                                                            color: MyThemeData
                                                                .background,
                                                            onPressed: () {
                                                              obj.edituserclick(
                                                                  model);
                                                            },
                                                            width:
                                                                width * 0.08),
                                                        SizedBox(
                                                          width: width * 0.015,
                                                        ),
                                                        WebButton(
                                                            text: "Delete",
                                                            color: MyThemeData
                                                                .background,
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Confirm Delete'),
                                                                    content:
                                                                        const Text(
                                                                            'Are you sure you want to delete this User?'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          obj.deleteUser(
                                                                            snapshot.data!.docs[index].get("id"),
                                                                            context,
                                                                          );
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              MyThemeData.background,
                                                                        ),
                                                                        child: const Text(
                                                                            'Delete'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              MyThemeData.redColour,
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
                                                            width:
                                                                width * 0.08),
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
            obj.is_edit_user_click == true
                ? GestureDetector(
                    onTap: () {
                      obj.is_edit_user_click = false;
                      obj.update();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: width * 0.05),
                      width: width,
                      height: height,
                      color: MyThemeData.background.withOpacity(0.3),
                    ),
                  )
                : const SizedBox(),
            obj.is_edit_user_click == true
                ? Form(
                    key: userformKey,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: width * 0.3,
                            height: height * 0.8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  lableTextname("Edit User"),
                                  obj.imageloading == false
                                      ? SizedBox(
                                          width: width * 0.2,
                                          height: height * 0.15,
                                          child: ClipOval(
                                            child: obj.profileImage == null
                                                ? Container(
                                                    width: width * 0.2,
                                                    height: height * 0.15,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2,
                                                      ),
                                                      image: obj.userModel!
                                                                  .imageURL ==
                                                              null
                                                          ? const DecorationImage(
                                                              image: AssetImage(
                                                                "images/profile-user.png",
                                                              ),
                                                            )
                                                          : DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                obj.userModel!
                                                                    .imageURL!,
                                                              ),
                                                            ),
                                                    ),
                                                  )
                                                : FutureBuilder(
                                                    future: obj.profileImage!
                                                        .readAsBytes(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Container(
                                                          width: width * 0.2,
                                                          height: height * 0.15,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 2,
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  MemoryImage(
                                                                snapshot.data!,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Container(
                                                          width: width * 0.2,
                                                          height: height * 0.15,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                          ),
                                                          child: Center(
                                                            child:
                                                                SpinkitFlutter
                                                                    .spinkit,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                          ),
                                        )
                                      : Container(
                                          width: width * 0.2,
                                          height: height * 0.15,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade400,
                                          ),
                                          child: Center(
                                            child: SpinkitFlutter.spinkit,
                                          ),
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      WebButton(
                                        text: 'Upload',
                                        color: MyThemeData.background,
                                        width: width * 0.09,
                                        onPressed: () {
                                          if (obj.imageloading == false) {
                                            obj.pickImage(obj.userModel!);
                                          } else {
                                            showtoast("uploading in progress");
                                          }
                                        },
                                      ),
                                      WebButton(
                                        text: 'Delete',
                                        color: MyThemeData.background,
                                        width: width * 0.09,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirm Delete'),
                                                content: const Text(
                                                    'Are you sure you want to delete this User?'),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      obj.deletepic(
                                                        obj.userModel!,
                                                        context,
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          MyThemeData
                                                              .background,
                                                    ),
                                                    child: const Text('Delete'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          MyThemeData.redColour,
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
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      lableTextname("Usery Role"),
                                      Container(
                                        width: width * 0.25,
                                        height: height * 0.07,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: MyThemeData.greyColor,
                                          ),
                                        ),
                                        child: DropdownButton<String>(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.02),
                                          underline: Container(),
                                          value: obj.selectedvalue,
                                          onChanged: (String? newValue) {
                                            obj.selectedvalue = newValue!;
                                            obj.update();
                                          },
                                          items: obj.menuItems
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      value,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.1,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      lableTextname("User Name"),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Textformfield(
                                          controller: obj.usernamecontroller,
                                          abscureText: false,
                                          validation: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter User name';
                                            }
                                            return null; // input is valid
                                          },
                                          keyboardtype: TextInputType.name,
                                        ),
                                      ),
                                      lableTextname("User Email"),
                                      SizedBox(
                                        width: width * 0.25,
                                        child: Textformfield(
                                          controller: obj.useremailcontroller,
                                          abscureText: false,
                                          validation: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter User Email';
                                            }
                                            return null; // input is valid
                                          },
                                          keyboardtype:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.025,
                                      ),
                                      WebButton(
                                        text: 'Save',
                                        color: MyThemeData.background,
                                        width: width * 0.25,
                                        onPressed: () {
                                          if (userformKey.currentState!
                                              .validate()) {
                                            obj.updateuser(obj.userModel!.id!);
                                          } else {
                                            showtoast("please fullfill fields");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          obj.updateLoading == true
                              ? Container(
                                  width: width * 0.3,
                                  height: height * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: SpinkitFlutter.spinkit,
                                  ),
                                )
                              : const SizedBox(),
                        ],
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
