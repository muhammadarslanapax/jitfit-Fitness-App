// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:jetfit/utilis/static_data.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static void initialize() {
//     // initializationSettings  for Android
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       // icon
//       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//     );
//     _notificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   static void createAndDisplayChatNotification(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       NotificationDetails notificationDetails = const NotificationDetails(
//         android: AndroidNotificationDetails(
//           "pushnotificationapp",
//           "pushnotificationappchannel",
//           'LaunchTheme',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       );
//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//       );
//     } on Exception catch (e) {
//       // ignore: avoid_print
//       print(e);
//     }
//   }
// }

// Future<bool> pushNotificationsSpecificDevice({
//   required String token,
//   required String title,
//   required String body,
// }) async {
//   String dataNotifications = '{ "to" : "$token",'
//       ' "notification" : {'
//       ' "title":"$title",'
//       '"body":"$body"'
//       ' }'
//       ' }';

//   await http.post(
//     Uri.parse(Staticdata.BASE_URL),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'key= ${Staticdata.KEY_SERVER}',
//     },
//     body: dataNotifications,
//   );
//   return true;
// }

// Future<bool> pushNotificationsGroupDevice({
//   required String title,
//   required String body,
// }) async {
//   String dataNotifications = '{'
//       '"operation": "create",'
//       '"notification_key_name": "appUser-testUser",'
//       '"registration_ids":["dV5pjB2aS_KAE1CuCrBPRG:APA91bHDjwDJbEBYVYtaBXdJ9hNHt2yNnoNhGU5k16AMvGcCFTAdK7h9GHWUu8rlthR8oQXbFJi5EBQQ1okFOZJC94m98manc6Or6CZr5TTDB-B8zzlMT1RrLzPakDg2kvM0Mir460bG","d1Kudv_ERRSY4ELxKjss-c:APA91bFMm-S56N35a6u8WAMiV88I3fNXKvhcLa8KbMrbjG7CdiVVCikJd3dyc0SgBkqlm3bsAJpU7rueX5esTYjOhILAUUNI8JXXZXDNXfWzi-wOWerYBfHFNR1JgL2N6c41iNJi8vaB"],'
//       '"notification" : {'
//       '"title":"$title",'
//       '"body":"$body"'
//       ' }'
//       ' }';

//   var response = await http.post(
//     Uri.parse(Staticdata.BASE_URL),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'key= ${Staticdata.KEY_SERVER}',
//       'project_id': "${Staticdata.SENDER_ID}"
//     },
//     body: dataNotifications,
//   );

//   print(response.body.toString());

//   return true;
// }

Future<bool> pushNotificationsAllUsers({
  required String title,
  required String body,
}) async {
  // FirebaseMessaging.instance.subscribeToTopic("myTopic1");

  String dataNotifications = '{ '
      ' "to" : "/topics/myTopic1" , '
      ' "notification" : {'
      ' "title":"$title" , '
      ' "body":"$body" '
      ' } '
      ' } ';

  var response = await http.post(
    Uri.parse(Staticdata.BASE_URL),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key= ${Staticdata.KEY_SERVER}',
    },
    body: dataNotifications,
  );
  print(response.body.toString());
  return true;
}
