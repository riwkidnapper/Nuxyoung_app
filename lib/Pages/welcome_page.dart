import 'package:flutter/material.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //logo before welcome
      body: navigationPage(context),

      //body: Loginpage(),
    );
  }
}

navigationPage(context) {
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

