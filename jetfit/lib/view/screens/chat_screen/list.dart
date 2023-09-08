import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/chat_screen/chat_user_card.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      appBar: AppBar(
        title: Text(
          'Inbox',
          style: TextStyle(
            color: MyThemeData.whitecolor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Admin")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: width,
                        height: height * 0.7,
                        child: Center(
                          child: WhiteSpinkitFlutter.spinkit,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Container(
                        height: height,
                        width: width,
                        child: Text(
                          "No chats",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      List<QueryDocumentSnapshot> document =
                          snapshot.data!.docs;

                      return Expanded(
                        child: SizedBox(
                            height: height,
                            width: width,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: document.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot documentSnapshot =
                                    document[index];
                                AdminwebModel model = AdminwebModel.fromMap(
                                    documentSnapshot.data()
                                        as Map<String, dynamic>);
                                String id = chatRoomId(
                                    Staticdata.userModel!.id!, model.id!);
                                return ChatUserCard(
                                  user: model,
                                  chatID: id,
                                );

                                // SizedBox(
                                //   height: height * 0.1,
                                //   width: width,
                                //   child: Column(
                                //     children: [
                                //       ListTile(
                                //         onTap: () {
                                //           String id = chatRoomId(
                                //               Staticdata.userModel!.id!,
                                //               model.id!);
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) => Chat(
                                //                 tokenId: 'tokam',
                                //                 chatId: id,
                                //                 model: model,
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //         leading: model.imageURL == null
                                //             ? CircleAvatar(
                                //                 backgroundColor:
                                //                     MyThemeData.background,
                                //                 backgroundImage: AssetImage(
                                //                     "images/user.png"),
                                //               )
                                //             : CircleAvatar(
                                //                 backgroundColor:
                                //                     const Color(0xfffffafafa),
                                //                 backgroundImage: NetworkImage(
                                //                   model.imageURL!,
                                //                 ),
                                //               ),
                                //         title: Text(
                                //           model.name!,
                                //           style: TextStyle(
                                //               color: MyThemeData.whitecolor,
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.w400),
                                //         ),
                                //         // subtitle: Text(
                                //         //   'Hi there, just wanted to check ...',
                                //         //   style: TextStyle(
                                //         //       color: const Color(0xffA1A1A1),
                                //         //       fontSize: 14,
                                //         //       fontWeight: FontWeight.w400),
                                //         // ),
                                //         trailing: Text(
                                //           '12:03 PM',
                                //           style: TextStyle(
                                //               color: const Color(0xffA1A1A1),
                                //               fontSize: 08,
                                //               fontWeight: FontWeight.w400),
                                //         ),
                                //       ),
                                //       Divider(
                                //         color: Colors.grey.shade300,
                                //       )
                                //     ],
                                //   ),
                                // );
                              },
                            )),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Modeleclass {
  String? image;
  String? title;
  String? subtitle;
  String? time;
  String? count;

  Modeleclass({
    this.image,
    this.title,
    this.subtitle,
    this.time,
    this.count,
  });
  static List<Modeleclass> piclist = [
    Modeleclass(
      image: "images/noah.png",
      title: "Charlotte Mathis",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Tech Ninja",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Charlotte Mathis",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Bold Explorer",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Music Maverick",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Wanderlust King",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Foodie Explorer",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Wanderlust King",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Bold Explorer",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Music Maverick",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Wanderlust King",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Foodie Explorer",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
    Modeleclass(
      image: "images/noah.png",
      title: "Wanderlust King",
      subtitle: "Hi there, just wanted to check ...",
      time: "12:03 PM",
      count: "08",
    ),
  ];
}
