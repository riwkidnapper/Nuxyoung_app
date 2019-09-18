import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/welcome_page.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => Loginpage()
      },
      title: 'Nux Young',
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
