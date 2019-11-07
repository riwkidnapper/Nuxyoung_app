import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:nuxyoung/package/picker.dart';

bool clear = false;

class Addappoint extends StatefulWidget {
  final String doctorName;
  Addappoint({Key key, @required this.doctorName}) : super(key: key);

  @override
  _AddappointState createState() => _AddappointState(doctorName);
}

class _AddappointState extends State<Addappoint> {
  FirebaseUser user;
  final Firestore store = Firestore.instance;
  DateTime date;
  DateTime time = DateTime.now();
  DateTime dateandtime;
  final String doctorName;
  final GlobalKey<FormState> _fbKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _lastController;
  TextEditingController _hisController;
  TextEditingController _simController;

  _AddappointState(this.doctorName);
  @override
  void initState() {
    super.initState();
    date = DateTime(
        DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
    _nameController = TextEditingController();
    _lastController = TextEditingController();
    _hisController = TextEditingController();
    _simController = TextEditingController();
  }

  var items = [
    'วันพุธ, 9.00 น. - 12.00 น.',
    'วันศุกร์, 9.00 น. - 12.00 น.',
  ];

  void changState() {
    setState(() {
      clear = true;
    });
  }

  void setstate() {
    setState(() {
      clear = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "การนัดหมาย",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            //padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'เลือกแพทย์',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => changState(),
                      icon: Icon(Icons.clear),
                    ),
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    hintText: doctorName,
                    hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'เลือกช่วงเวลา',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                DateAndTimePicker(
                  currentDateAndTime: date,
                  onSelect: (DateTime d) {
                    setState(() {
                      date = d;
                    });
                  },
                ),

                // Row(6
                //   children: <Widget>[
                //     Expanded(
                //       child: TextField(
                //         style: TextStyle(fontSize: 18),
                //         controller: _controller,
                //       ),
                //     ),
                //     PopupMenuButton<String>(
                //       icon: const Icon(Icons.arrow_drop_down),
                //       onSelected: (String value) {
                //         _controller.text = value;
                //       },
                //       itemBuilder: (BuildContext context) {
                //         return items.map<PopupMenuItem<String>>((String value) {
                //           return PopupMenuItem(child: Text(value), value: value);
                //         }).toList();
                //       },
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'ชื่อ - นามสกุลคนไข้',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextFormField(
                  controller: _lastController,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),

                Text(
                  'ประวัติการรักษา',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextFormField(
                  controller: _hisController,
                  maxLines: 4,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),

                Text(
                  'อาการเบื้องต้น',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextFormField(
                  controller: _simController,
                  maxLines: 4,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),

                Center(
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.assignment_turned_in,
                      color: Colors.blueGrey[700],
                    ),
                    color: Colors.blueGrey[300],
                    label: Text(
                      "ยืนยัน",
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      _fbKey?.currentState?.save();
                      if (_fbKey?.currentState?.validate() ?? true) {
                        var paitientName = _lastController?.value?.text;
                        var his = _hisController?.value?.text;
                        var sim = _simController?.value?.text;
                        var data = {
                          "ชื่อแพทย์ผู้รักษา": doctorName,
                          "วันที่": date,
                          "ชื่อคนไข้": paitientName,
                          "ประวัติการเข้ารับการรักษา": his,
                          "อาการเบื้องต้น": sim,
                        };
                        await store
                            .collection("appointment")
                            .add(data)
                            .then((value) {
                          print(value.documentID);
                          Navigator.pop(
                            context,
                          );
                          Navigator.pop(
                            context,
                          );
                          Navigator.pop(
                            context,
                          );
                        }).catchError((err) {
                          print(err);
                        });
                      } else {
                        setState(() {
                          print("validation failed");
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
