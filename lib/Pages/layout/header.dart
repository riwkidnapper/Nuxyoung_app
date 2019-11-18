import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0, bottom: 10.0, right: 10.0, top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ตารางการปฏิบัติงานของแพทย์',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 3.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: const FractionalOffset(1.0, 2.0),
                end: const FractionalOffset(-0.2, 0.2),
                colors: [
                  Colors.blueGrey[300],
                  Colors.blue[200],
                ],
              ),
            ),
            width: 250.0,
          ),
        ],
      ),
    );
  }
}
