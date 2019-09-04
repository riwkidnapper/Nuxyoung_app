import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:nuxyong_app/Pages/doctor_page/calendar.dart';
import 'package:nuxyong_app/Pages/doctor_page/history.dart';
import 'package:nuxyong_app/Pages/doctor_page/video.dart';
import 'package:nuxyong_app/Tebbar/bottombar.dart';

class medicalBudhosp extends StatefulWidget {
  @override
  _medicalBudhospState createState() => _medicalBudhospState();
}

class _medicalBudhospState extends State<medicalBudhosp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedicalBudhosp',
      home: Scaffold(
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
                Icons.home,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new HomePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.notifications_none,
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
                title: Text('History'),
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
                title: Text('Initial symptoms'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Video'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChewieDemo()));
                },
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text('Chat'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Calendar'),
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
        body: Center(
          child: Text(
            'Za warudo',
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}
