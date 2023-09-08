import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/models/message_model.dart' as model;
import 'package:jetfit/utilis/static_data.dart';

class ChatWebController extends GetxController {
  static ChatWebController get my => Get.find();
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      AdminwebModel user, String chatid) {
    return firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      AdminwebModel chatUser) {
    return firestore
        .collection('Admin')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      AdminwebModel user, String chatid) {
    return firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  Future<void> updateMessageReadStatus(
      model.Message message, String chatid) async {
    firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  Future<void> deleteMessage(model.Message message, String chatid) async {
    await firestore
        .collection('chatroom')
        .doc(chatid)
        .collection('chats')
        .doc(message.sent)
        .delete();

    if (message.type == model.Type.image) {
      await storage.refFromURL(message.msg!).delete();
    }
  }

  Future<void> sendChatImage(
      String chatId, AdminwebModel chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage
        .ref()
        .child('chats/${chatId}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    //notification
    await sendMessage(chatUser, imageUrl, model.Type.image, chatId);
  }

  static Future<void> sendMessage(
    AdminwebModel chatUser,
    String msg,
    model.Type type,
    String chatId,
  ) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final model.Message message = model.Message(
        duration: '',
        toId: chatUser.id!,
        msg: msg,
        read: '',
        type: type,
        fromId: Staticdata.uid!,
        sent: time);

    final ref =
        firestore.collection('chatroom').doc(chatId).collection('chats');
    await ref.doc(time).set(message.toJson()).then((value) {
      // sendPushNotification(chatUser, type == model.Type.text ? msg : 'image'));
    });
  }

// for adding an user to my user when first message is send
  // static Future<void> sendFirstMessage(
  //     AdminwebModel chatUser, String msg, model.Type type) async {
  //   await firestore
  //       .collection('users')
  //       .doc(chatUser.id)
  //       .collection('my_users')
  //       .doc(user.uid)
  //       .set({}).then((value) => sendMessage(chatUser, msg, type));
  // }

  // for updating user information

//  static Future<void> updateUserInfo() async {
//     await firestore.collection('users').doc(user.uid).update({
//       'name': me.name,
//       'about': me.about,
//     });
//   }
}
