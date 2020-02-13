import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:nuxyoung/provider/homepage.dart';
import 'package:nuxyoung/provider/auth.dart';
import 'package:nuxyoung/provider/medical.dart';
import 'package:nuxyoung/provider/tabbar.dart';


String message;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging firebaseMessaging = FirebaseMessaging();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThailandProvincesDatabase.init();
  message = "No message.";
  var initAndroid = AndroidInitializationSettings('ic_launcher');
  var initIOS = IOSInitializationSettings();
  var initSetting = InitializationSettings(initAndroid, initIOS);
  flutterLocalNotificationsPlugin.initialize(initSetting,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      Map mapNotification = message["notification"];
      String title = mapNotification["title"];
      String body = mapNotification["body"];
      sendNotification(title: title, body: body);
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
  firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });
  runApp(MyApp());
}

Future<void> sendNotification({String title, String body}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(112, title, body, platformChannelSpecifics, payload: null);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[900],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('th', 'TH'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => Loginpage(),
        '/medical': (BuildContext context) => MedicalBudhosp()
      },
      title: 'Nux Young',
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
