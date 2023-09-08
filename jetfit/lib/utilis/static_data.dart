import 'package:jetfit/models/admin_model.dart';
import 'package:jetfit/models/user_model.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:video_player/video_player.dart';

class Staticdata {
  static String? uid;
  static String subcatagorytitle = '';
  static String imageURL = '';
  static String plan1 =
      'https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-7CM62625RT172620PMT22WDI';
  static String plan2 =
      'https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-8LC20812XN250671EMT224MA';
  static String plan3 =
      'https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-3GM60695VL149162JMT2275Q';
  static String exclusuiveplan =
      'https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-26Y33698T14036044MT223HA';
  static String catagoryid = '';
  static AdminwebModel? adminmodel;
  static UserModel? userModel;
  static String clientId =
      'AeKOVoTfDqKh4jxc8x-w4OKJjYBHs4KIzIxKU9iYvRbJ5Um9uhzX3n_wTDJuekFqDSOHJnP-WvK557Vg';
  static String secretKey =
      'sk_test_51NjqECIGNTWWyp3lKBtq6KHxp7ECjllSGQI8Lqkbs025dCYWzGiyKtkvilonEOHavvkrRONYlT060ye6bPRemmYd00UOY0iEVB';
  // static String accessToken = '';

  static final String BASE_URL = 'https://fcm.googleapis.com/fcm/send';
  static final String KEY_SERVER =
      'AAAAxKsVUzg:APA91bGgk6fLlBldRATWmP8fKhInmEs-4EpyHZ_eqOluboovXK265dsd_p1QTrCkfhrg6ZEmlW2ROdQwCtVnmUAas6Qr9FSdYF7zaL7BjBbuDvpbv5vZsOEeifbkHU3iSJ7sWONQd9B7';
  static final String SENDER_ID = '412858938477';
  static bool profile = true;
  static bool proofofwork = true;
  static bool licence = true;
  static VideossModel? videoModal;
  static bool? isvideomodel;
  static bool? ispremium;
  static bool? isexclusive;
  static VideoPlayerController? videoplayerController;
  static Future<void>? initializeVideoPlayerFuture;
}
