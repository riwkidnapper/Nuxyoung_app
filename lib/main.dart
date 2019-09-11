import 'package:flutter/material.dart';
import 'package:nuxyong_app/Pages/welcome_page.dart';
import 'package:nuxyong_app/Auth/login_page.dart';
import 'package:nuxyong_app/Tebbar/home_bottombar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      routes: <String, WidgetBuilder>{
        'main': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => Loginpage()
      },
      title: 'Nux Young',
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
