import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/models/message_model.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/view/screens/chat_screen/chat.dart';
import 'package:jetfit/view/screens/chat_screen/chat_controller.dart';
import 'package:jetfit/view/screens/chat_screen/dialogs/profile_dialog.dart';
import 'package:jetfit/view/screens/chat_screen/helper/my_date_util.dart';

//card to represent a single user in home screen
class ChatUserCard extends StatefulWidget {
  final AdminwebModel user;
  final String chatID;

  const ChatUserCard({super.key, required this.user, required this.chatID});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;
  @override
  void initState() {
    Get.put(ChatController());
    super.initState();
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: width * .04, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          //for navigating to chat screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatScreen(
                        user: widget.user,
                        chatid: widget.chatID,
                      )));
        },
        child: StreamBuilder(
          stream: ChatController.my.getLastMessage(widget.user, widget.chatID),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list =
                data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) _message = list[0];

            return ListTile(
              //user profile picture
              leading: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => ProfileDialog(user: widget.user));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(height * .03),
                  child: CachedNetworkImage(
                    width: height * .055,
                    height: height * .055,
                    imageUrl: widget.user.imageURL!,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
              ),

              //user name
              title: Text(widget.user.name!),
              //last message
              subtitle: Text(
                  _message != null
                      ? _message!.type! == Type.image
                          ? 'image'
                          : _message!.type! == Type.audio
                              ? "audio"
                              : _message!.msg!
                      : "Hey ! there i am here to assist you",
                  maxLines: 1),

              //last message time
              trailing: _message == null
                  ? null //show nothing when no message is sent
                  : _message!.read!.isEmpty &&
                          _message!.fromId != Staticdata.uid
                      ?
                      //show for unread message
                      Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent.shade400,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      :
                      //message sent time
                      Text(
                          MyDateUtil.getLastMessageTime(
                              context: context, time: _message!.sent!),
                          style: const TextStyle(color: Colors.black54),
                        ),
            );
          },
        ),
      ),
    );
  }
}
