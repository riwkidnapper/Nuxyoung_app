import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuxyoung/Pages/doctor_page/register.dart';
import 'package:nuxyoung/Pages/doctor_page/toolCalen.dart/formsign.dart';

class Medicalrec extends StatefulWidget {
  @override
  Records createState() {
    return Records();
  }
}

class Records extends State<Medicalrec> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final Firestore store = Firestore.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  // final GlobalKey<FormFieldState> _specifyTextFieldKey =
  //     GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => (val);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              autovalidate: true,
              // readonly: true,
              child: Column(
                children: <Widget>[
                  FormBuilderDateTimePicker(
                    attribute: "date",
                    onChanged: _onChanged,
                    inputType: InputType.date,
                    format: DateFormat("yyyy-MM-dd"),
                    initialValue: DateTime.now(),
                    decoration:
                        InputDecoration(labelText: "วันเวลาที่เข้ารับการรักษา"),
                    // readonly: true,
                  ),
                  FormBuilderTextField(
                    attribute: 'history',
                    decoration: InputDecoration(
                        labelText: "ประวัติการเข้ารับการรักษา", hintText: null),
                    keyboardType: TextInputType.multiline,
                    onChanged: _onChanged,
                    maxLines: null,
                  ),
                  FormBuilderTextField(
                    attribute: 'logic',
                    decoration: InputDecoration(
                        labelText: "เหตุผลในการส่งต่อ", hintText: null),
                    keyboardType: TextInputType.multiline,
                    onChanged: _onChanged,
                    maxLines: null,
                  ),
                  FormBuilderSignature(
                    decoration: InputDecoration(labelText: "ลงชื่อ"),
                    attribute: "signature",
                    height: 250,
                    clearButtonText: "ลองใหม่อีกครั้ง",
                    onChanged: _onChanged,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
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
                        _fbKey.currentState.save();
                        if (_fbKey.currentState.validate()) {
                          var values = _fbKey.currentState.value;
                          print(values);
                          //   var data = <String, dynamic>{};
                          //   data["name"] = values["name"];
                          //   data["identification number"] =
                          //       values["identification number"];
                          //   data["date"] = values["date"];
                          //   data["gender"] = values["gender"];
                          //   data["age"] = values["age"];
                          //   data["postcode"] = values["postcode"];
                          //   data["country"] = values["country"];
                          //   data["district"] = values["district"];
                          //   data["subdistrict"] = values["subdistrict"];
                          //   data["history"] = values["history"];
                          //   data["logic"] = values["logic"];
                          //   data["signature"] = values["signature"];
                          //   await store
                          //       .collection("form")
                          //       .add(data)
                          //       .then((value) {
                          //     print(value.documentID);
                          //   }).catchError((err) {
                          //     print(err);
                          //   });
                        } else {
                          print(_fbKey.currentState.value);
                          print("validation failed");
                        }
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.autorenew,
                      color: Colors.blueGrey[700],
                    ),
                    color: Colors.blueGrey[300],
                    label: Text(
                      "ล้างทั้งหมด",
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _fbKey.currentState.fields.clear();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Icon(
              Icons.hdr_strong,
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
}
