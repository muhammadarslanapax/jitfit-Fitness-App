import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/view/screens/chat_screen/helper/my_date_util.dart';

import '../../../../utilis/theme_data.dart';

//view profile screen -- to view profile of user
class ViewProfileScreen extends StatefulWidget {
  final AdminwebModel user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.black,
          //app bar
          appBar: AppBar(title: Text(widget.user.name!)),
          floatingActionButton: //user about
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Joined On: ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text(
                  MyDateUtil.getLastMessageTime(
                      context: context,
                      time: widget.user.createdAt!,
                      showYear: true),
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),

          //body
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for adding some space
                  SizedBox(width: width, height: height * .03),

                  //user profile picture
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(height * .1),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: MyThemeData.onSurface,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                          child: CachedNetworkImage(
                            width: height * .2,
                            height: height * .2,
                            fit: BoxFit.cover,
                            imageUrl: widget.user.imageURL!,
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                    child: Icon(CupertinoIcons.person)),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // for adding some space
                  SizedBox(height: height * .03),

                  // user email label
                  Text(widget.user.email!,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),

                  // for adding some space
                  SizedBox(height: height * .02),

                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Info: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text("Admin",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
