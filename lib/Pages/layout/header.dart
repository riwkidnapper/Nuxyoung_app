import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0, bottom: 10.0, right: 10.0, top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ประวัติแพทย์ผู้รักษา',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            height: 3.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: const FractionalOffset(0.3, 2.0),
                end: const FractionalOffset(-0.2, 0.2),
                colors: [
                  Colors.blueGrey,
                  Colors.lightBlueAccent[700],
                ],
              ),
            ),
            width: 100.0,
          ),
        ],
      ),
    );
  }
}
