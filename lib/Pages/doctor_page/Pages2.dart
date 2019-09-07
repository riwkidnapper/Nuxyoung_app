import 'package:flutter/material.dart';

class Pagetwo extends StatefulWidget {
  pagetwoState createState() => pagetwoState();
}

class pagetwoState extends State<Pagetwo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 150.0, bottom: 100.0),
        child: Column(
          children: <Widget>[
            Text("DEMO",
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold)),
            Text(
              "Login Screen 1",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
