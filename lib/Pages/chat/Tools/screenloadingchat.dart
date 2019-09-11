import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuxyong_app/Pages/chat/chat_screen.dart';
import 'dart:async';

class LoadingChat extends StatefulWidget {
  @override
  _LoadingChatState createState() => _LoadingChatState();
}

class _LoadingChatState extends State<LoadingChat> {
  startTime() async {
    var _duration = new Duration(milliseconds: 1200);
    //did you seen :) now lets try with 10 seconds
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatScreen()));
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
          'assets/images/message.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
