import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ลงทะเบียนผู้ใช้งาน"),
          backgroundColor: Colors.blueGrey[500],
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ));
  }
}
