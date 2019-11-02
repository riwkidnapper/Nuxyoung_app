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
    num nowYear = date.year;
    num birthdayOfyear = birthday.year;
    num age = nowYear - birthdayOfyear;
    num nowMonth = date.month;
    num birthdaymoth = birthday.month;
    num birthdayOfMonth;
    num nowDay = date.day;
    num birthdaydate = birthday.day;
    num birthdayOfday;
    if (date.compareTo(birthday) >= 0) {
      if (nowMonth > birthdaymoth) {
        birthdayOfMonth = nowMonth - birthdaymoth;
        if (birthdaydate > nowDay) {
          birthdayOfMonth--;
          if (birthdaymoth == 1 ||
              birthdaymoth == 3 ||
              birthdaymoth == 5 ||
              birthdaymoth == 7 ||
              birthdaymoth == 8 ||
              birthdaymoth == 10 ||
              birthdaymoth == 12) {
            birthdayOfday = (31 - birthdaydate) + nowDay;
          } else if (birthdaymoth == 4 ||
              birthdaymoth == 6 ||
              birthdaymoth == 9 ||
              birthdaymoth == 11) {
            birthdayOfday = (30 - birthdaydate) + nowDay;
          } else {
            if ((birthdayOfyear - 543) % 4 == 0) {
              if (birthdayOfyear % 100 == 0) {
                if (birthdayOfyear % 400 == 0) {
                  birthdayOfday = (29 - birthdaydate) + nowDay;
                } else {
                  birthdayOfday = (28 - birthdaydate) + nowDay;
                }
              } else {
                birthdayOfday = (29 - birthdaydate) + nowDay;
              }
            } else {
              birthdayOfday = (28 - birthdaydate) + nowDay;
            }
          }
        } else if (birthdaydate == nowDay) {
          birthdayOfday = birthdaydate - nowDay;
        } else {
          birthdayOfday = nowDay - birthdaydate;
        }
      } else if (nowMonth == birthdaymoth) {
        if (birthdaydate > nowDay) {
          if (birthdaymoth == 1 ||
              birthdaymoth == 3 ||
              birthdaymoth == 5 ||
              birthdaymoth == 7 ||
              birthdaymoth == 8 ||
              birthdaymoth == 10 ||
              birthdaymoth == 12) {
            birthdayOfday = (31 - birthdaydate) + nowDay;
          } else if (birthdaymoth == 4 ||
              birthdaymoth == 6 ||
              birthdaymoth == 9 ||
              birthdaymoth == 11) {
            birthdayOfday = (30 - birthdaydate) + nowDay;
          } else {
            if ((birthdayOfyear - 543) % 4 == 0) {
              if (birthdayOfyear % 100 == 0) {
                if (birthdayOfyear % 400 == 0) {
                  birthdayOfday = (29 - birthdaydate) + nowDay;
                } else {
                  birthdayOfday = (28 - birthdaydate) + nowDay;
                }
              } else {
                birthdayOfday = (29 - birthdaydate) + nowDay;
              }
            } else {
              birthdayOfday = (28 - birthdaydate) + nowDay;
            }
          }
        } else if (birthdaydate == nowDay) {
          birthdayOfday = birthdaydate - nowDay;
        } else {
          birthdayOfday = nowDay - birthdaydate;
        }
      }
    } else {
      throw (date.compareTo(birthday));
    }

    // if (birthdaymoth > nowMonth) {
    //   age--;
    //   birthdayOfMonth = nowMonth;
    // } else if (nowMonth == birthdaymoth) {
    //   if (birthdayOfday == nowDay) {
    //     birthdayOfday = birthdayOfday - nowDay;
    //     birthdayOfMonth = birthdaymoth - nowMonth;
    //   } else if (nowDay > birthdayOfday) {
    //     birthdayOfday = nowDay - birthdayOfday;
    //     birthdayOfMonth = nowMonth - birthdaymoth;
    //   } else {
    //     age--;
    //     birthdayOfMonth = birthday.month;
    //   }
    // } else {
    //   birthdayOfMonth = nowMonth - birthdaymoth;

    //   if (birthdayOfday > nowDay) {
    //     birthdayOfMonth--;
    //   }
    // }
// if (birthdayOfMonth == 1 ||
//             birthdayOfMonth == 3 ||
//             birthdayOfMonth == 5 ||
//             birthdayOfMonth == 7 ||
//             birthdayOfMonth == 8 ||
//             birthdayOfMonth == 12) {
//           birthdayOfday = (31 - birthdayOfday) + nowDay;
//         } else if (birthdayOfMonth == 4 ||
//             birthdayOfMonth == 6 ||
//             birthdayOfMonth == 9 ||
//             birthdayOfMonth == 11) {
//           birthdayOfday = (30 - birthdayOfday) + nowDay;
//         } else if (birthdayOfMonth == 2) {
//           birthdayOfday = (28 - birthdayOfday) + nowDay;
//         }
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
                        initialValue: age.toString(),
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
                        initialValue: "อายุ" + birthdayOfMonth.toString(),
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "การวินิจฉัยเบื้องต้น", hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                      ),
                      TextFormField(
                        initialValue: "วัน" + birthdayOfday.toString(),
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
