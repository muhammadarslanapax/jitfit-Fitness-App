import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/models/message_model.dart' as model;
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/view/screens/chat_screen/audio/audio_controller.dart';
import 'package:jetfit/view/screens/chat_screen/chat_controller.dart';
import 'package:jetfit/view/screens/chat_screen/dialogs/view_profile_screen.dart';
import 'package:jetfit/view/screens/chat_screen/helper/my_date_util.dart';
import 'package:jetfit/view/screens/chat_screen/message_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';

class ChatScreen extends StatefulWidget {
  final AdminwebModel user;
  final String chatid;

  const ChatScreen({super.key, required this.user, required this.chatid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  List<model.Message> _list = [];
  AudioController audioController = Get.put(AudioController());
  //for handling message text changes
  final _textController = TextEditingController();
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  //showEmoji -- for storing value of showing or hiding emoji
  //isUploading -- for checking if image is uploading or not?
  late String recordFilePath;
  bool _showEmoji = false, _isUploading = false;
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool stop = RecordMp3.instance.stop();
    audioController.end.value = DateTime.now();
    audioController.calcDuration();
    var ap = AudioPlayer();
    await ap.play(AssetSource("Notification.mp3"));
    ap.onPlayerComplete.listen((a) {});
    if (stop) {
      audioController.isRecording.value = false;
      audioController.isSending.value = true;
      // await uploadAudio();
      await ChatController.my.sendChatVoice(widget.chatid, widget.user,
          File(recordFilePath), model.Type.audio, audioController.total);
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //if emojis are shown & back button is pressed then hide emojis
        //or else simple close current screen on back button click
        onWillPop: () {
          if (_showEmoji) {
            setState(() => _showEmoji = !_showEmoji);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          //app bar
          appBar: AppBar(
            elevation: 5,
            backgroundColor: Colors.black,
            // backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(),
          ),

          //  backgroundColor: const Color.fromARGB(255, 234, 248, 255),
          backgroundColor: Colors.black,

          //body
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ChatController.my
                      .getAllMessages(widget.user, widget.chatid),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      //if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();
                      //if some or all data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => model.Message.fromJson(e.data()))
                                .toList() ??
                            [];

                        print("_list.length ${_list.length}");
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              reverse: true,
                              itemCount: _list.length,
                              padding: EdgeInsets.only(top: height * .01),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (_list[index].type.toString() ==
                                    model.Type.audio.toString()) {
                                  return _audio(
                                    curentUserID: _list[index].fromId!,
                                    message: _list[index].msg!,
                                    isCurrentUser: false,
                                    index: index,
                                    time: _list[index].sent!,
                                    duration: _list[index].duration.toString(),
                                    audioController: audioController,
                                    audioPlayer: audioPlayer,
                                    context: context,
                                  );
                                } else {
                                  return MessageCard(
                                    message: _list[index],
                                    chatID: widget.chatid,
                                  );
                                }
                              });
                        } else {
                          return const Center(
                            child: Text('Say Hii! 👋',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          );
                        }
                    }
                  },
                ),
              ),

              //progress indicator for showing uploading
              if (_isUploading)
                const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: CircularProgressIndicator(strokeWidth: 2))),

              //chat input filed
              _chatInput(),

              //show emojis on keyboard emoji button click & vice versa
              if (_showEmoji)
                SizedBox(
                  height: height * .35,
                  child: EmojiPicker(
                    textEditingController: _textController,
                    config: Config(
                      bgColor: const Color.fromARGB(255, 234, 248, 255),
                      columns: 8,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  // app bar widget
  Widget _appBar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewProfileScreen(user: widget.user)));
        },
        child: StreamBuilder(
            stream: ChatController.my.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => AdminwebModel.fromMap(e.data())).toList() ??
                      [];

              return Row(
                children: [
                  //back button
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),

                  //user profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(height * .03),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: height * .05,
                      height: height * .05,
                      imageUrl: list.isNotEmpty
                          ? list[0].imageURL!
                          : widget.user.imageURL!,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  //for adding some space
                  const SizedBox(width: 10),

                  //user name & last seen time
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text(list.isNotEmpty ? list[0].name! : widget.user.name!,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),

                      //for adding some space
                      const SizedBox(height: 2),

                      //last seen time of user
                      Text(
                          list.isNotEmpty
                              ? list[0].isOnline!
                                  ? 'Online'
                                  : MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: list[0].lastActive!)
                              : MyDateUtil.getLastActiveTime(
                                  context: context,
                                  lastActive: widget.user.lastActive!),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white)),
                    ],
                  )
                ],
              );
            }));
  }

  Widget bottomSheet() {
    return Container(
      height: height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      // Handle Document icon
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: [
                          'pdf',
                          'doc',
                          'docx'
                        ], // Customize the allowed file types.
                      );

                      if (result != null) {
                        File docFIle = File(result.files.single.path!);

                        await ChatController.my.sendChatdoc(
                            widget.chatid,
                            widget.user,
                            File(result.files.single.path!),
                            model.Type.document,
                            '');
                      }
                    },
                    child: iconCreation(
                        Icons.insert_drive_file, Colors.indigo, "Document"),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: () async {
                       Navigator.pop(context);

                      _showVideoPickerDialog(context);
                      // Handle Video icon tap

                      

                    },
                    child: iconCreation(
                        Icons.video_camera_front, Colors.pink, "Video"),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(
                          context);                      // Show image picker dialog when Image icon is tapped
                      _showImagePickerDialog(context);
                    },
                    child: iconCreation(
                        Icons.insert_photo, Colors.purple, "Image"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icons,
            // semanticLabel: "Help",
            size: 29,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            // fontWeight: FontWeight.w100,
          ),
        )
      ],
    );
  }
  
  void _showVideoPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select an Video"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Take a Video"),
                onTap: () async {
                  // _pickImage(ImageSource.camera);
                   final pickervideo = ImagePicker();
                  final XFile? pickedvide =
                      await pickervideo.pickVideo(source: ImageSource.camera);
                      Navigator.pop(context);
                  if (pickedvide != null) {
                    // File videoFile = File(pickedvide.path);
                    await ChatController.my.sendChatVideo(
                        widget.chatid,
                        widget.user,
                        File(pickedvide!.path),
                        model.Type.video,
                        '');
                  }

                  
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Choose from Gallery"),
                onTap: () async {
                  // _pickImage(ImageSource.gallery);
                                        Navigator.pop(context);



                   final pickervideo = ImagePicker();
                  final XFile? pickedvide =
                      await pickervideo.pickVideo(source: ImageSource.gallery);
                  if (pickedvide != null) {
                    // File videoFile = File(pickedvide.path);
                    await ChatController.my.sendChatVideo(
                        widget.chatid,
                        widget.user,
                        File(pickedvide!.path),
                        model.Type.video,
                        '');
                  }
                 
                  
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }





  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select an Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Take a Photo"),
                onTap: () async {
                 // _pickImage(ImageSource.camera);
                                       Navigator.pop(context);



                  final ImagePicker picker = ImagePicker();

                  // Picking multiple images
                  final XFile? images =
                      await picker.pickImage(imageQuality: 70, source: ImageSource.camera);

                  // uploading & sending image one by one
                  
                    setState(() => _isUploading = true);
                    await ChatController.my.sendChatImage(widget.chatid,
                        widget.user, File(images!.path), model.Type.image, '');
                    setState(() => _isUploading = false);
                  



                

                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Choose from Gallery"),
                onTap: () async {
                                        Navigator.pop(context);

                 // _pickImage(ImageSource.gallery);
                  final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var u in images) {
                          log('Image Path: ${u.path}');
                          setState(() => _isUploading = true);
                          await ChatController.my.sendChatImage(widget.chatid,
                              widget.user, File(u.path), model.Type.image, '');
                          setState(() => _isUploading = false);
                        }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




  // bottom chat input field
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * .01, horizontal: width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.grey, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    child: Icon(Icons.mic, color: Colors.grey),
                    onLongPress: () async {
                      var audioPlayer = AudioPlayer();
                      await audioPlayer.play(AssetSource("Notification.mp3"));
                      audioPlayer.onPlayerComplete.listen((a) {
                        audioController.start.value = DateTime.now();

                        startRecord();
                        audioController.isRecording.value = true;
                      });
                    },
                    onLongPressEnd: (details) {
                      setState(() => _isUploading = true);
                      stopRecord();
                      setState(() => _isUploading = false);
                    },
                  ),
                  //pick image from gallery button

                  // show bottom nav

                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (builder) => bottomSheet());
                      },
                      icon: Icon(Icons.attach_file,color: Colors.grey ,)),

           
                  //adding some space
                  SizedBox(width: width * .02),
                ],
              ),
            ),
          ),

          // //send message button
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                // if (_list.isEmpty) {
                //   //on first message (add user to my_user collection of chat user)
                //   APIs.sendFirstMessage(
                //       widget.user, _textController.text, model.Type.text);
                // } else {
                //simply send message
                ChatController.my.sendMessage(widget.user, _textController.text,
                    model.Type.text, widget.chatid, '');
                // }
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
// audio

Widget _audio({
  required String message,
  required String curentUserID,
  required bool isCurrentUser,
  required int index,
  required String time,
  required String duration,
  required BuildContext context,
  required AudioPlayer audioPlayer,
  required AudioController audioController,
}) {
  return Align(
    alignment: curentUserID == Staticdata.uid
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Card(
      color: Colors.transparent,
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: curentUserID == Staticdata.uid
              ? MyThemeData.redColour
              : MyThemeData.background.withOpacity(0.18),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                audioController.onPressedPlayButton(index, message);
                // changeProg(duration: duration);
              },
              onSecondaryTap: () {
                audioPlayer.stop();
                //   audioController.completedPercentage.value = 0.0;
              },
              child: Obx(
                () => (audioController.isRecordPlaying &&
                        audioController.currentId == index)
                    ? Icon(
                        Icons.cancel,
                        color: isCurrentUser
                            ? Colors.white
                            : MyThemeData.background,
                      )
                    : Icon(
                        Icons.play_arrow,
                        color: isCurrentUser
                            ? Colors.white
                            : MyThemeData.background,
                      ),
              ),
            ),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                      LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrentUser ? Colors.white : MyThemeData.background,
                        ),
                        value: (audioController.isRecordPlaying &&
                                audioController.currentId == index)
                            ? audioController.completedPercentage.value
                            : audioController.totalDuration.value.toDouble(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              duration,
              style: TextStyle(
                  fontSize: 12,
                  color: isCurrentUser ? Colors.white : MyThemeData.background),
            ),
          ],
        ),
      ),
    ),
  );
}

// our or user message
