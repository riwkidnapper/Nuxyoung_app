import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
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
        drawer: new Drawer(),
        body: Center(
          child: Text('Hello Worldddddddd'),
        ),
      ),
    );
  }
}
