import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:nuxyong_app/Pages/doctor_page/calendar.dart';
import 'package:nuxyong_app/Pages/doctor_page/history.dart';
import 'package:nuxyong_app/Pages/doctor_page/symptoms.dart';
import 'package:nuxyong_app/Pages/doctor_page/video.dart';
import 'package:nuxyong_app/Tebbar/home_bottombar.dart';

import 'chat/Tools/screenloadingchat.dart';

class MedicalBudhosp extends StatefulWidget {
  @override
  _MedicalBudhospState createState() => _MedicalBudhospState();
}

class _MedicalBudhospState extends State<MedicalBudhosp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: GradientAppBar(
          leading: new IconButton(
            icon: new Icon(
              Icons.menu,
              color: Colors.blueGrey,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text(
            'Welcome Doctor',
            style: TextStyle(
              color: Colors.blueGrey[700],
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                const IconData(0xe800, fontFamily: 'chat'),
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new HomePage(
                    ),

                  ),
                );
              },
            ),
            SizedBox(
              width: 5.0,
            ),
            IconButton(
              icon: Icon(
                const IconData(0xe811, fontFamily: 'chat'),
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new LoadingChat(),
                  ),
                );
              },
            ),
            SizedBox(
              width: 5.0,
            ),
            IconButton(
              icon: Icon(
                const IconData(0xe801, fontFamily: 'chat'),
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Container(),
                  ),
                );
              },
            ),
          ],
          backgroundColorStart: Colors.white,
          backgroundColorEnd: Colors.blueGrey[50],
        ),
        /************************************************************************ */
        drawer: new Drawer(
          elevation: 20.0,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Doctor Marnoj"),
                accountEmail: Text("marnoj@doctor.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue.shade800,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[400],
                ),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('แบบฟอร์ม'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHisToRy()));
                },
              ),
              ListTile(
                leading: Icon(Icons.accessible_forward),
                title: Text('อาการเบื้องต้น'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExpansionTileSample()));
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('วิดีโอ'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChewieDemo()));
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('ปฏิทิน'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CaLenDar(
                                title: 'Calendar',
                              )));
                },
              )
            ],
          ),
        ),
        /****************************************************************************** */
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/homewall.png'),
                  colorFilter: new ColorFilter.mode(
                      Colors.grey[50].withOpacity(0.3), BlendMode.dstATop),
                ),
              ),
            ),
            Center(
              child: Text(
                'Za warudo',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ],
        ));
  }
}
