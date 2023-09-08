import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jetfit/view/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _getLocation();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCEZGHSkQZsk-ga1a40gci9bsYHRfgqhXs",
          authDomain: "john-fit.firebaseapp.com",
          projectId: "john-fit",
          storageBucket: "john-fit.appspot.com",
          messagingSenderId: "844683891512",
          appId: "1:844683891512:web:2706ad848d2fc6c84ca7cd",
          measurementId: "G-Q9RCXVRDDY"),
    );

    runApp(const MyApp());
  } else {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    runApp(const MyApp());
  }
}

@pragma('vm:entry-point')
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Locale mainlocale = const Locale("en");

Future<void> _getLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString("local");

  print("myvakiueejj   ${value}");
  if (value == null) {
    print("============================================================null");
    mainlocale = const Locale("en");
  } else {
    if (value == "en") {
      mainlocale = const Locale("en");
      print("value is ===================================== ${mainlocale}");
    } else if (value == "de") {
      mainlocale = const Locale("de");
      print("value is ===================================== ${mainlocale}");
    } else if (value == "es") {
      mainlocale = const Locale("es");
      print("value is ===================================== ${mainlocale}");
    } else if (value == "fr") {
      mainlocale = const Locale("fr");
      print("value is ===================================== ${mainlocale}");
    } else {
      mainlocale = const Locale("en");
      print("value is ===================================== ${mainlocale}");
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  // late final Locale _locale = mainlocale;

  setLocale(Locale newLocale) {
    setState(() {
      mainlocale = newLocale;
    });
  }

  @override
  void initState() {
    super.initState();

    setLocale(mainlocale);
  }

  @override
  Widget build(BuildContext context) {
    final lan = AppLocalizations.of(context);

    print("=========== main  ${mainlocale}");
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      locale: mainlocale,

      //  localizationsDelegates: const [
      //         AppLocalizations.delegate,
      //         GlobalMaterialLocalizations.delegate,
      //         GlobalCupertinoLocalizations.delegate,
      //         GlobalWidgetsLocalizations.delegate
      //       ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Color(0xff111413),
        ),
      ),
      home:
          //  const AdminHome(),
          const MyCustomSplashScreen(),
    );
  }
}
