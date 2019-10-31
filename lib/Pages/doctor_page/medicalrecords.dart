import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuxyoung/Pages/doctor_page/register.dart';
import 'package:nuxyoung/Pages/doctor_page/toolCalen.dart/formsign.dart';

import 'extension/date.dart';

class Medicalrec extends StatefulWidget {
  final String name;
  final String idnumber;
  final DateTime birthday;
  final String gender;
  const Medicalrec({
    Key key,
    @required this.name,
    @required this.idnumber,
    @required this.birthday,
    @required this.gender,
  }) : super(key: key);
  @override
  _MedicalrecState createState() =>
      _MedicalrecState(name, idnumber, birthday, gender);
}

class _MedicalrecState extends State<Medicalrec> {
  var data;
  bool autoValidate = true;
  final Firestore store = Firestore.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final date = DateTime(
      DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
  ValueChanged _onChanged = (val) => (val);

  final String name;
  final String idnumber;
  final DateTime birthday;
  final String gender;
  _MedicalrecState(this.name, this.idnumber, this.birthday, this.gender);
  void _clear() {
    _fbKey.currentState?.reset();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Medicalrec(
                name: name,
                idnumber: idnumber,
                birthday: birthday,
                gender: gender,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //// var dayofbirth = birthday.day;
    //// var mothofbirth = birthday.month;

    if (date.compareTo(birthday) > 0) throw ("Can't be born in the future");
    num nowYear = date.year;
    num birthdayOfyear = birthday.year;
    num age = nowYear - birthdayOfyear;
    num nowMonth = date.month;
    num birthdayOfMonth = birthday.month;
    if (birthdayOfMonth > nowMonth) {
      age--;
    } else if (nowMonth == birthdayOfMonth) {
      num nowDay = date.day;
      num birthdayOfday = birthday.day;
      if (birthdayOfday > nowDay) {
        age--;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "กรอกประวัติผู้ป่วย",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormBuilder(
                  // context,
                  key: _fbKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      DateTimePicker(
                        locale: Locale("th", "TH"),
                        attribute: "date",
                        onChanged: _onChanged,
                        inputType: InputTypedate.date,
                        decoration: InputDecoration(
                          labelText: "วันเวลาที่เข้ารับการรักษา",
                        ),
                        // readonly: true,
                      ),
                      TextFormField(
                        initialValue: birthdayOfMonth.toString(),
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "ประวัติการเข้ารับการรักษา",
                            hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                      ),
                      TextFormField(
                        initialValue: age.toString(),
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "การวินิจฉัยเบื้องต้น", hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                      ),
                      TextFormField(
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "เหตุผลในการส่งต่อ", hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FormBuilderSignature(
                          decoration: InputDecoration(labelText: "ลงชื่อ"),
                          attribute: "signature",
                          height: 200,
                          clearButtonText: "ลองใหม่อีกครั้ง",
                          //onChanged: _onChanged,
                        ),
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
                                // var data = <String, dynamic>{};
                                // data["name"] = name;
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
                                // await store
                                //     .colle record")
                                //     .add(data)
                                //     .then((value) {
                                //   print(value.documentID);
                                // }).catchError((err) {
                                //   print(err);
                                // });
                              } else {
                                print(_fbKey.currentState.value);
                                print("validation failed");
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(
                                    idnumber: idnumber,
                                  ),
                                ),
                              );
                            })),
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
                        onPressed: () => _clear(),
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
        ),
      ),
    );
  }
}
