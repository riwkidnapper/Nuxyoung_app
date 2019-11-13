import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
//import 'package:nuxyoung/Pages/layout/proflieDoc.dart';
//import 'package:nuxyoung/pull_to_refresh.dart';



class Pagetwo extends StatefulWidget {
  PagetwoState createState() => PagetwoState();
  
}

class PagetwoState extends State<Pagetwo> {
  TextEditingController searchController = new TextEditingController();
  String filter;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
   String message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";
  //bool isSubscribeHotNews = false;

   @override
  initState() {
    message = "No message.";
 
    var initializationSettingsAndroid =
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
  
  sendNotification({title,body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('10000',
        'FLUTTER_NOTIFICATION_CHANNEL', 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
 
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
 
    await flutterLocalNotificationsPlugin.show(112, title,
            body, platformChannelSpecifics,
        payload: null);
  }
 
  Widget build(BuildContext context) {
  return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: 
      (BuildContext context, bool innerBoxIsScrolled){
         return <Widget>[
                // SliverAppBar(
                //   automaticallyImplyLeading: true,
                //   backgroundColor: Colors.transparent,
                //   expandedHeight: 300.0,
                //   floating: false,
                //   pinned: true,
                //   flexibleSpace: FlexibleSpaceBar(
                //       centerTitle: true,
                //       collapseMode: CollapseMode.pin,
                //       background: Image.asset(
                //         'assets/images/a.jpg',
                //         fit: BoxFit.cover,
                //       )),
                // ),
              ];
      },
      body: Column(
        children: <Widget>[
          Container(
            child: ConstrainedBox(
             constraints: BoxConstraints(
               
               ),
               child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
             Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new ExactAssetImage('assets/images/p2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new BackdropFilter(filter: new ImageFilter.blur(sigmaX: 600.0, sigmaY: 1000.0)),
                    width: 400,
                    height: 200,
                  ),
                ),
              ),
              // new Padding(
              //   padding: new EdgeInsets.all(8.0),
              //   child: new TextField(
              //     controller: searchController,
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search),
              //       border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(32.0)),
              //       hintText: "ค้นหา",
              //     ),
              //   ),
              //   ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                      width: 320,
                      height: 150,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => Calendar()
                          )
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.blue[100],
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            const ListTile(
                              //leading: Icon(Icons.album, size: 70.0, ),
                              title: Text('วันนัดหมายของคุณ', style: TextStyle(color: Colors.black,fontSize: 20.0),
                              textAlign: TextAlign.center),
                              subtitle: Text('16 พฤศจิกายน 2562', style: TextStyle(color: Colors.black,fontSize: 24.0),
                              textAlign: TextAlign.center),
                          ),
                          ],
                          ),
                        ),
                      ),
                    ),
              ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: Container(
                     child: RaisedButton.icon(
                       icon: Icon(
                         Icons.date_range,
                         color: Colors.blueGrey[700],
                       ),
                       color: Colors.blueGrey[300],
                        label: Text(
                          "เลื่อนเวลานัดหมาย",
                          style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ), onPressed: () async {},
                     ),
                    ),
                  ),

                  Container(
                   child: RaisedButton.icon(
                     icon: Icon(
                       Icons.assignment_turned_in,
                       color: Colors.blueGrey[700],
                     ),
                     color: Colors.blueGrey[300],
                      label: Text(
                        "ยกเลิกนัดหมาย",
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ), onPressed: ()  {
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
              // Container(
              //       width: 320,
              //       height: 150,
              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.0),
              //         ),
              //         color: Colors.green[200],
              //         elevation: 10,
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             const ListTile(
              //           //   leading: Icon(Icons.album, size: 70.0, ),
              //             title: Text('เลื่อนเวลานัด', style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
              //           //   subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
              //           ),
              //           ],
              //         ),
              //       ),
              //     ),
            ],
          ),
            ),
          )
        ],
      ),
      ),
      );
  } 
}

    // return Scaffold(
    //   body: SmartRefresher(
    //     enablePullDown: true,
    //     enablePullUp: true,
    //     header: WaterDropHeader(),
    //     footer: CustomFooter(
    //       builder: (BuildContext context, LoadStatus mode) {
    //         Widget body;
    //         if (mode == LoadStatus.idle) {
    //           body = Text("pull up load");
    //         } else if (mode == LoadStatus.failed) {
    //           body = Text("Load Failed!Click retry!");
    //         } else {
    //           body = Text("No more Data");
    //         }
    //         return Container(
    //           height: 55.0,
    //           child: Center(child: body),
    //         );
    //       },
    //     ),
    //     controller: _refreshController,
    //     onRefresh: _onRefresh,
    //     onLoading: _onLoading,
    //     child: ListView.builder(
    //       itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
    //       itemExtent: 100.0,
    //       itemCount: items.length,
    //     ),
    //   ),
    // );

