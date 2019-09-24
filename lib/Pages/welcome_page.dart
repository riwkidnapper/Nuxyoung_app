import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //logo before welcome
      body: SplashScreen(),

      //body: Loginpage(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    //did you seen :) now lets try with 10 seconds
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    FirebaseAuth.instance
        .currentUser()
        .then((user) => {
              if (user == null)
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loginpage(),
                    ),
                  )
                }
              else
                {
                  // Firestore.instance
                  //     .collection("users")
                  //     .document(user.uid)
                  //     .get()
                  //     .then((DocumentSnapshot result) =>
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ).catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
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
          'assets/images/welcomehome.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
