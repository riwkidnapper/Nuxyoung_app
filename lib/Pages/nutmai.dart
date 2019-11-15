import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuxyoung/Tebbar/Teb_iteam.dart';

//import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
//import 'package:nuxyoung/Pages/layout/proflieDoc.dart';
//import 'package:nuxyoung/pull_to_refresh.dart';

class Pagetwo extends StatefulWidget {
  PagetwoState createState() => PagetwoState();
}

class PagetwoState extends State<Pagetwo> {
  final Firestore store = Firestore.instance;
  TextEditingController searchController = new TextEditingController();
  String filter;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";
  String uid;
  String dateOfAddpoint;
  String timeOfAddpoint;

  var name;

  //bool isSubscribeHotNews = false;
FirebaseUser currentUser;

    

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }
   @override
  initState() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        uid = user.uid;
      });
    });
  
    message = "No message.";
_loadCurrentUser();    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
      print("onDidReceiveLocalNotification called.");
    });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      // when user tap on notification.
      print("onSelectNotification called.");
      setState(() {
        message = payload;
      });
    });
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Map mapNotification = message["notification"];
        String title = mapNotification["title"];
        String body = mapNotification["body"];
        sendNotification(title: title, body: body);
        
        await store
            .collection("users")
            .where('uid', isEqualTo: currentUser.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/users/${docs.documents[0].documentID}')
              .updateData({
                'title': title,
                'body': body
          }).then((val) {
            print(title);
            print(body);
          }).catchError((title,body) {
            print(title);
            print(body);
          });
        }).catchError((title,body) {      
            print(title);
            print(body);
        });
      
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

    firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Token : $token");
    });

    super.initState();
  }

  sendNotification({title, body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('10000',
        'FLUTTER_NOTIFICATION_CHANNEL', 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
 
    await flutterLocalNotificationsPlugin.show(112,title,
        body, platformChannelSpecifics,
        payload: null);
  }

  void deleteAddpoint() async {
    {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 0.0, bottom: 10.0),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  height: 150.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.cancel,
                          size: 60.0,
                          color: Colors.redAccent,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      ),
                      Text(
                        'ยกเลิกการนัดหมาย',
                        style: TextStyle(
                            color: THEME,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'คุณต้องการที่จะยกเลิกการนัดหมายครั้งนี้ใช่ไหม ?',
                        style: TextStyle(color: THEME, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.cancel,
                            color: THEME,
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text(
                          'CANCEL',
                          style: TextStyle(
                              color: THEME, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.check_circle,
                            color: THEME,
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text(
                          'YES',
                          style: TextStyle(
                              color: THEME, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          })) {
        case 0:
          break;
        case 1:
          store
              .collection("appointment")
              .where('uid', isEqualTo: uid)
              .getDocuments()
              .then((docs) {
            store
                .document('/appointment/${docs.documents[0].documentID}')
                .delete()
                .whenComplete(() {});
          });
          sendNotification();
          break;
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: Column(
          children: <Widget>[
            Container(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("appointment")
                      .orderBy('วันเดือนปีที่นัดหมาย')
                      .orderBy('เวลาที่นัดหมาย')
                      .where('ชื่อคนไข้', isEqualTo: name)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                        ),
                      );
                    } else {
                      if (snapshot.data.documents.length == 0) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/images/p2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: new BackdropFilter(
                                      filter: new ImageFilter.blur(
                                          sigmaX: 600.0, sigmaY: 1000.0)),
                                  width: 400,
                                  height: 200,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Container(
                                width: 320,
                                height: 180,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.blue[100],
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ListTile(
                                          subtitle: Text('ไม่มีการนัดหมายใด ๆ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        dateOfAddpoint = snapshot?.data?.documents[0]
                                ['วันเดือนปีที่นัดหมาย'] ??
                            null;
                        timeOfAddpoint = snapshot?.data?.documents[0]
                                ['เวลาที่นัดหมาย'] ??
                            null;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new ExactAssetImage(
                                          'assets/images/p2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: new BackdropFilter(
                                      filter: new ImageFilter.blur(
                                          sigmaX: 600.0, sigmaY: 1000.0)),
                                  width: 400,
                                  height: 200,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Container(
                                width: 320,
                                height: 180,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) => Calendar())),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.blue[100],
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ListTile(
                                          //leading: Icon(Icons.album, size: 70.0, ),
                                          title: Text('วันนัดหมายของคุณ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0),
                                              textAlign: TextAlign.center),
                                          subtitle: Text(dateOfAddpoint ?? '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.center),
                                        ),
                                        Text(
                                          'เวลา : $timeOfAddpoint',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 30, 50, 10),
                              child: Container(
                                child: RaisedButton.icon(
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Colors.blueGrey[700],
                                  ),
                                  color: Colors.blueGrey[300],
                                  label: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "เลื่อนเวลานัดหมาย",
                                      style: TextStyle(
                                        color: Colors.blueGrey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: RaisedButton.icon(
                                icon: Icon(
                                  Icons.assignment_turned_in,
                                  color: Colors.blueGrey[700],
                                ),
                                color: Colors.blueGrey[300],
                                label: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "ยกเลิกนัดหมาย",
                                    style: TextStyle(
                                      color: Colors.blueGrey[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  deleteAddpoint();
                                  //sendNotification();
                                  /*Switch(
                        value: isSubscribeHotNews,
                           onChanged: (checked) {
                         if(checked) {
                           firebaseMessaging.subscribeToTopic("TOEY");
                         }else{
                            firebaseMessaging.unsubscribeFromTopic("TOEY");
                         }
                          setState(() => isSubscribeHotNews = checked);
                       }
                     );*/
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
