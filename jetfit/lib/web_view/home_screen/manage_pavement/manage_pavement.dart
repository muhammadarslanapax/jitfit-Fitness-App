import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/widgets/textformfield.dart';
import 'package:jetfit/view/widgets/web_button.dart';
import 'package:jetfit/web_view/home_screen/manage_pavement/manage_pavement_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagePavementScreen extends StatefulWidget {
  const ManagePavementScreen({super.key});

  @override
  State<ManagePavementScreen> createState() => _ManagePavementScreenState();
}

class _ManagePavementScreenState extends State<ManagePavementScreen> {
  GlobalKey<FormState> profileformkey = GlobalKey<FormState>();
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<ManagePavementController>(initState: (state) {
        Get.put(ManagePavementController());
      }, builder: (obj) {
        return Form(
          key: profileformkey,
          child: Stack(
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
                        "MANAGE PAVEMENT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white),
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
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.03,
                              ),
                              Text(
                                "Admin Panel - Payments",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: MyThemeData.background,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: height * 0.03,
                              ),
                              SizedBox(height: height * 0.03),
                              lableTextname("Enter Amount"),
                              SizedBox(height: height * 0.01),
                              SizedBox(
                                width: width * 0.25,
                                child: Textformfield(
                                  controller: obj.amountController,
                                  abscureText: false,
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter ammount';
                                    }
                                    return null; // input is valid
                                  },
                                  keyboardtype: TextInputType.name,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.3,
                                child: ListView.builder(
                                  itemCount: obj.payments.length,
                                  itemBuilder: (context, index) {
                                    final payment = obj.payments[index];
                                    return ListTile(
                                      title: Text(payment.description),
                                      subtitle: Text(
                                          "Amount: \$${payment.amount.toString()}"),
                                    );
                                  },
                                ),
                              ),
                              WebButton(
                                text: 'Submit Payment Amount',
                                color: MyThemeData.background,
                                width: width * 0.25,
                                onPressed: () {},
                              ),
                              SizedBox(height: height * 0.01),
                              WebButton(
                                text: 'Edit Users Subscriptions',
                                color: MyThemeData.background,
                                width: width * 0.25,
                                onPressed: () {
                                  obj.is_edit_pavement_click = true;
                                  obj.update();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
////////////////////////////////
              obj.is_edit_pavement_click == true
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                            controller:
                                                obj.searchusercontroller,
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
                                        left: width * 0.025,
                                        top: height * 0.03),
                                    child: Row(
                                      children: [
                                        lableTextname("No"),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        lableTextname("Profile"),
                                        SizedBox(
                                          width: width * 0.195,
                                        ),
                                        lableTextname("Plan"),
                                        SizedBox(
                                          width: width * 0.13,
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
                                              .where("role",
                                                  isEqualTo: "premium user")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child: SpinkitFlutter.spinkit,
                                              );
                                            } else if (snapshot.hasData) {
                                              return ListView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  UserModel model = UserModel(
                                                    createdAt: snapshot
                                                        .data!.docs[index]
                                                        .get("createdAt"),
                                                    isOnline: snapshot
                                                        .data!.docs[index]
                                                        .get("isOnline"),
                                                    lastActive: snapshot
                                                        .data!.docs[index]
                                                        .get("lastActive"),
                                                    tokan: snapshot
                                                        .data!.docs[index]
                                                        .get("tokan"),
                                                    email: snapshot
                                                        .data!.docs[index]
                                                        .get("email"),
                                                    id: snapshot
                                                        .data!.docs[index]
                                                        .get("id"),
                                                    imageURL: snapshot
                                                        .data!.docs[index]
                                                        .get("imageURL"),
                                                    name: snapshot
                                                        .data!.docs[index]
                                                        .get("name"),
                                                    password: snapshot
                                                        .data!.docs[index]
                                                        .get("password"),
                                                    role: snapshot
                                                        .data!.docs[index]
                                                        .get("role"),
                                                    status: snapshot
                                                        .data!.docs[index]
                                                        .get("status"),
                                                  );
                                                  obj.checkdailyUser(model);

                                                  if (obj.name.isEmpty ||
                                                      obj.name == '') {
                                                    return buildUserTile(
                                                        index,
                                                        model,
                                                        width,
                                                        height,
                                                        obj);
                                                  } else if (model.name!
                                                      .toLowerCase()
                                                      .contains(obj.name
                                                          .toLowerCase())) {
                                                    return buildUserTile(
                                                        index,
                                                        model,
                                                        width,
                                                        height,
                                                        obj);
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
                    )
                  : SizedBox(),

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
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              lableTextname("${obj.userModel!.name} details"),
                              SizedBox(
                                width: width * 0.2,
                                height: height * 0.15,
                                child: ClipOval(
                                    child: Container(
                                  width: width * 0.2,
                                  height: height * 0.15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    image: obj.userModel!.imageURL == ""
                                        ? const DecorationImage(
                                            image: AssetImage(
                                              "images/profile-user.png",
                                            ),
                                          )
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              obj.userModel!.imageURL!,
                                            ),
                                          ),
                                  ),
                                )),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  lableTextname("User Role"),
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
                                                    fontWeight: FontWeight.w400,
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
                                  lableTextname("Subscription History"),
                                  Container(
                                    height: height * 0.35,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('subscriptions')
                                          .where("userId",
                                              isEqualTo: obj.userModel!.id)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Loading indicator while fetching data
                                          return Center(
                                              child: CircularProgressIndicator(
                                            backgroundColor:
                                                MyThemeData.background,
                                          ));
                                        }

                                        if (snapshot.hasError) {
                                          // Error message if there's an issue with the stream
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          );
                                        }

                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          // Display a message if there are no subscription records
                                          return Center(
                                            child: Text(
                                                'No subscription history available.'),
                                          );
                                        }

                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final subscription =
                                                snapshot.data!.docs[index];
                                            String time = obj.getFormattedTime(
                                              context,
                                              subscription
                                                  .get("timestamp")
                                                  .toDate(),
                                            );
                                            String formattedDate =
                                                DateFormat.yMd().format(
                                                    subscription
                                                        .get("timestamp")
                                                        .toDate());
                                            return ListTile(
                                              title: Text(
                                                  "Duration: ${subscription.get("duration")}"),
                                              subtitle: Text(
                                                  "Activity: ${subscription.get("activity")}\nPrice: \$${subscription.get("price").toStringAsFixed(2)}"),
                                              trailing: Column(
                                                children: [
                                                  Text(
                                                      "Date: ${formattedDate}"),
                                                  Text("Time: ${time}"),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  WebButton(
                                      text: 'Save',
                                      color: MyThemeData.background,
                                      width: width * 0.25,
                                      onPressed: () {
                                        obj.updateuser(obj.userModel!.id!);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
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

// showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder:
//                                                                       (context) {
//                                                                     return AlertDialog(
//                                                                       title:
//                                                                           const Text('Remove Subscription'),
//                                                                       content:
//                                                                           const Text('Are you sure you want to remove subscription ?'),
//                                                                       actions: [
//                                                                         ElevatedButton(
//                                                                           onPressed: () {
//                                                                             // obj.deleteUser(
//                                                                             //   snapshot.data!.docs[index].get("id"),
//                                                                             //   context,
//                                                                             // );
//                                                                           },
//                                                                           style: ElevatedButton.styleFrom(
//                                                                             backgroundColor: MyThemeData.background,
//                                                                           ),
//                                                                           child: const Text('Yes'),
//                                                                         ),
//                                                                         ElevatedButton(
//                                                                           style: ElevatedButton.styleFrom(
//                                                                             backgroundColor: MyThemeData.redColour,
//                                                                           ),
//                                                                           onPressed: () {
//                                                                             Navigator.pop(context);
//                                                                           },
//                                                                           child: const Text('No'),
//                                                                         ),
//                                                                       ],
//                                                                     );
//                                                                   },
//                                                                 );
Widget buildUserTile(int index, UserModel model, double width, double height,
    ManagePavementController obj) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      children: [
        SizedBox(
          width: width,
          height: height * 0.09,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.05,
                child: Text(
                  '${index + 1}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyThemeData.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: model.imageURL == null
                      ? const DecorationImage(
                          image: AssetImage("images/profile-user.png"),
                        )
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(model.imageURL!),
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
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: MyThemeData.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('subscriptions')
                      .where('userId', isEqualTo: model.id)
                      .where('activity', isEqualTo: 'activate')
                      .snapshots(),
                  builder: (context, subscriptionSnapshot) {
                    if (subscriptionSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SizedBox(
                        width: width * 0.15,
                        child: Text(
                          "Getting Plan...",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: MyThemeData.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      width: width * 0.15,
                      child: Text(
                        subscriptionSnapshot.data!.docs[0].get("duration"),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: MyThemeData.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
              SizedBox(
                width: width * 0.09,
                child: Text(
                  model.role!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: MyThemeData.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              WebButton(
                text: "View Detail",
                color: MyThemeData.background,
                onPressed: () {
                  obj.edituserclick(model);
                },
                width: width * 0.1,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('subscriptions')
                      .where('userId', isEqualTo: model.id)
                      .where('activity', isEqualTo: 'activate')
                      .snapshots(),
                  builder: (context, subscriptionSnapshot) {
                    if (subscriptionSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return WebButton(
                        text: "expiry date...",
                        color: MyThemeData.background,
                        onPressed: () {
                          obj.edituserclick(model);
                        },
                        width: width * 0.1,
                      );
                    }
                    DateTime subscriptionEndDate = subscriptionSnapshot
                        .data!.docs[0]
                        .get("subscriptionEndTime")
                        .toDate();
                    int daysRemaining =
                        subscriptionEndDate.difference(DateTime.now()).inDays;

                    Color buttonColor;

                    if (daysRemaining <= 5) {
                      buttonColor = MyThemeData.redColour;
                    } else if (daysRemaining <= 10) {
                      buttonColor = Colors.yellow;
                    } else {
                      buttonColor = Colors.green;
                    }

                    return WebButton(
                      text:
                          '${subscriptionEndDate.month}/${subscriptionEndDate.day}/${subscriptionEndDate.year}',
                      color: buttonColor,
                      onPressed: () {
                        // obj.edituserclick(model);
                      },
                      width: width * 0.1,
                    );
                  }),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    ),
  );
}
