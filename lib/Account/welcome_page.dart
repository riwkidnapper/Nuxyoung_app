import 'dart:async';
import 'package:flutter/material.dart';

import 'package:nuxyong_app/Account/login_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Welcome());
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => loginPage(),
      },
      //logo before welcome
      //home: SplashScreen(),
      home: loginPage(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    //did you seen :) now lets try with 10 seconds
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed("/homepage");
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

//now lets run the app
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/welcome.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
