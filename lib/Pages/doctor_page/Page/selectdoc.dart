import 'package:flutter/material.dart';

class Selectdoc extends StatefulWidget {
  final String doctorName;
  final photoUser;
  final String times;
  const Selectdoc(
      {Key key,
      @required this.doctorName,
      @required this.photoUser,
      @required this.times})
      : super(key: key);
  @override
  _SelectdocState createState() =>
      _SelectdocState(doctorName, photoUser, times);
}

class _SelectdocState extends State<Selectdoc> {
  final String doctorName;
  final photoUser;
  final String times;
  String timelist = "";
  _SelectdocState(this.doctorName, this.photoUser, this.times);

  @override
  Widget build(BuildContext context) {
    timelist = times.split("., ").join("\n\n");
    return Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.all(15.0),
      height: 270,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black38, offset: Offset(0, 1), blurRadius: 1)
        ],
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[100],
                      child: Container(
                        width: 250.0,
                        height: 300.0,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: NetworkImage(
                              photoUser,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          doctorName,
                          style:
                              TextStyle(fontSize: 40, color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "วันเวลาออกตรวจ",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          timelist,
                          style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
