import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:jetfit/models/message_model.dart' as model;
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/view/screens/chat_screen/chat_controller.dart';
import 'package:jetfit/view/screens/chat_screen/cover_player_2.dart';
import 'package:jetfit/view/screens/chat_screen/helper/dialogs.dart';
import 'package:jetfit/view/screens/chat_screen/helper/my_date_util.dart';

// for showing single message details
class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.chatID,
  });

  final model.Message message;
  final String chatID;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    bool isMe = Staticdata.uid == widget.message.fromId;
    return InkWell(
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _greenMessage() : _blueMessage());
  }

  // sender or another user message
  Widget _blueMessage() {
    
    //update last read message if sender and receiver are different
    if (widget.message.read!.isEmpty) {
      ChatController.my.updateMessageReadStatus(widget.message, widget.chatID);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == model.Type.image
                ? MediaQuery.of(context).orientation == Orientation.portrait
                    ? width * .02
                    : width * 0.01
                :     MediaQuery.of(context).orientation == Orientation.portrait
                    ? width * .02
                    : width * 0.01
                
                
                
                
                ),
            margin: EdgeInsets.symmetric(
                horizontal: width * .04, vertical: height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == model.Type.text
                ?
                //show text
                Text(
                    widget.message.msg!,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                //show image
                widget.message.type == model.Type.image
                    ?
                    //show image
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? width * 0.5
                              : width * 0.3,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? height * 0.2
                              : height * 0.25,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.message.msg!,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image, size: 70),
                          ),
                        ),
                      )
                    : widget.message.type == model.Type.document
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                      width: MediaQuery.of(context).orientation == Orientation.portrait ?    width * 0.45 : width * 0.3,
                                      height:MediaQuery.of(context).orientation == Orientation.portrait ?    height * 0.04  : height * 0.07,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset("images/pdf1.png",fit: BoxFit.cover,),
                                          
                                          Text("Document File")
                                        ],
                                      )
                                      
                                      ))
                              : SizedBox()),
          ),
        

        //message time
        Padding(
          padding: EdgeInsets.only(right: width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent!),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            SizedBox(width: width * .04),

            //double tick blue icon for message read

            Icon(Icons.done_all_rounded,
                color:
                    widget.message.read!.isNotEmpty ? Colors.blue : Colors.grey,
                size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent!),
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
              padding: EdgeInsets.all(widget.message.type == model.Type.image
                  ?  MediaQuery.of(context).orientation == Orientation.portrait ? width * .02 :width*0.01
                  :                     MediaQuery.of(context).orientation == Orientation.portrait ? 
            width * .02 :width*0.01
                  
                  
                  
                  ),
              margin: EdgeInsets.symmetric(
                  horizontal: width * .04, vertical: height * .01),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(
                  color: Colors.lightGreen,
                ),
                //making borders curved
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: widget.message.type == model.Type.text
                  ?
                  //show text
                  Text(
                      widget.message.msg!,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black87),
                    )
                  : widget.message.type == model.Type.video
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: width * 0.5,
                            height: height * 0.2,
                            child: CoverPlayer2(
                              url: widget.message.msg,
                            ),
                          ),
                        )
                      :
                      //show image
                      widget.message.type == model.Type.image
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                width:MediaQuery.of(context).orientation == Orientation.portrait ?     width*0.5:width*0.3,
                                height:MediaQuery.of(context).orientation == Orientation.portrait?     height*0.2:height*0.25,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: widget.message.msg!,
                                  placeholder: (context, url) => const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:
                                        Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.image, size: 70),
                                ),
                              ),
                            )
                          : widget.message.type == model.Type.document
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                      width: MediaQuery.of(context).orientation == Orientation.portrait ?    width * 0.45 : width * 0.3,
                                      height:MediaQuery.of(context).orientation == Orientation.portrait ?    height * 0.04  : height * 0.07,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset("images/pdf1.png",fit: BoxFit.cover,),
                                          
                                          Text("Document File")
                                        ],
                                      )
                                      
                                      ))
                              : SizedBox()),
        ),
      ],
    );
  }



  // bottom sheet for modifying message details
  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              //black divider
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: height * .015, horizontal: width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              widget.message.type == model.Type.text
                  ?
                  //copy option
                  _OptionItem(
                      icon: const Icon(Icons.copy_all_rounded,
                          color: Colors.blue, size: 26),
                      name: 'Copy Text',
                      onTap: () async {
                        await Clipboard.setData(
                                ClipboardData(text: widget.message.msg!))
                            .then((value) {
                          //for hiding bottom sheet
                          Navigator.pop(context);

                          Dialogs.showSnackbar(context, 'Text Copied!');
                        });
                      })
                  :
                  //save option
                  _OptionItem(
                      icon: const Icon(Icons.download_rounded,
                          color: Colors.blue, size: 26),
                      name: 'Save Image',
                      onTap: () async {
                        try {
                          log('Image Url: ${widget.message.msg}');
                          await GallerySaver.saveImage(widget.message.msg!,
                                  albumName: 'We Chat')
                              .then((success) {
                            //for hiding bottom sheet
                            Navigator.pop(context);
                            if (success != null && success) {
                              Dialogs.showSnackbar(
                                  context, 'Image Successfully Saved!');
                            }
                          });
                        } catch (e) {
                          log('ErrorWhileSavingImg: $e');
                        }
                      }),

              //separator or divider
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: width * .04,
                  indent: width * .04,
                ),

              //edit option
              // if (widget.message.type == model.Type.text && isMe)
              //   _OptionItem(
              //       icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
              //       name: 'Edit Message',
              //       onTap: () {
              //         //for hiding bottom sheet
              //         Navigator.pop(context);

              //         _showMessageUpdateDialog();
              //       }),





              //delete option
              if (isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      await ChatController.my
                          .deleteMessage(widget.message, widget.chatID)
                          .then((value) {
                        //for hiding bottom sheet
                        Navigator.pop(context);
                      });
                    }),

              //separator or divider
              Divider(
                color: Colors.black54,
                endIndent: width * .04,
                indent: width * .04,
              ),

              //sent time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                  name:
                      'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.sent!)}',
                  onTap: () {}),

              //read time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                  name: widget.message.read!.isEmpty
                      ? 'Read At: Not seen yet'
                      : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.read!)}',
                  onTap: () {}),
            ],
          );
        });
  }

  //dialog for updating message content
  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg!;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(' Update Message')
                ],
              ),

              //content
              content: TextFormField(
                initialValue: updatedMsg,
                maxLines: null,
                onChanged: (value) => updatedMsg = value,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    )),

                //update button
                // MaterialButton(
                //     onPressed: () {
                //       //hide alert dialog
                //       Navigator.pop(context);
                //       APIs.updateMessage(widget.message, updatedMsg);
                //     },
                //     child: const Text(
                //       'Update',
                //       style: TextStyle(color: Colors.blue, fontSize: 16),
                //     ))
              ],
            ));
  }
}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  _OptionItem({required this.icon, required this.name, required this.onTap});

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: width * .05, top: height * .015, bottom: height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}




















// cover player




