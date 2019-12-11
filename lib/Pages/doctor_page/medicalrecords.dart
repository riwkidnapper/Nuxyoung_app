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
  final String address;
  final String provinces;
  final String amphures;
  final String district;
  final String zipcode;
  const Medicalrec({
    Key key,
    @required this.name,
    @required this.idnumber,
    @required this.birthday,
    @required this.gender,
    @required this.address,
    @required this.provinces,
    @required this.amphures,
    @required this.district,
    @required this.zipcode,
  }) : super(key: key);
  @override
  _MedicalrecState createState() => _MedicalrecState(name, idnumber, birthday,
      gender, address, provinces, amphures, district, zipcode);
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
  final String address;
  final String provinces;
  final String amphures;
  final String district;
  final String zipcode;

  bool load = false;

  _MedicalrecState(this.name, this.idnumber, this.birthday, this.gender,
      this.address, this.provinces, this.amphures, this.district, this.zipcode);
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
                address: address,
                provinces: provinces,
                amphures: amphures,
                district: district,
                zipcode: zipcode,
              )),
    );
  }

  @override
  void initState() {
    load = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String medicalrecords;
    String diagnosis;
    String reasonOfforward;
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
                        attribute: "dateOfadmitted",
                        onChanged: _onChanged,
                        inputType: InputTypedate.date,
                        decoration: InputDecoration(
                          labelText: "วันเวลาที่เข้ารับการรักษา",
                        ),
                        // readonly: true,
                      ),
                      TextFormField(
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "ประวัติการเข้ารับการรักษา",
                            hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                        onSaved: (val) => medicalrecords = val,
                      ),
                      TextFormField(
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "การวินิจฉัยเบื้องต้น", hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                        onSaved: (val) => diagnosis = val,
                      ),
                      TextFormField(
                        autocorrect: true,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: "เหตุผลในการส่งต่อ", hintText: null),
                        keyboardType: TextInputType.multiline,
                        onChanged: _onChanged,
                        maxLines: null,
                        onSaved: (val) => reasonOfforward = val,
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
                load == false
                    ? Row(
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
                                      setState(() {
                                        load = true;
                                      });
                                      var values = _fbKey.currentState.value;
                                      var data = <String, dynamic>{};
                                      data["ชื่อคนไข้"] = name;
                                      data["รหัสประชาชน"] = idnumber.toString();
                                      data["วันเดือนปีเกิด"] = birthday;
                                      data["เพศ"] = gender;
                                      data["ที่อยู่"] = address;
                                      data["จังหวัด"] = provinces;
                                      data["อำเภอ"] = amphures;
                                      data["ตำบล"] = district;
                                      data["รหัสไปรษณีย์"] = zipcode;
                                      data["วันเวลาที่เข้ารับการรักษา"] =
                                          values["dateOfadmitted"];
                                      data["ประวัติการเข้ารับการรักษา"] =
                                          medicalrecords;
                                      data["การวินิจฉัยเบื้องต้น"] = diagnosis;
                                      data["เหตุผลในการส่งต่อ"] =
                                          reasonOfforward;
                                      await store
                                          .collection("profliePaitient")
                                          .add(data)
                                          .then((value) {
                                        setState(() {
                                          load = false;
                                        });
                                        print(value.documentID);
                                      }).catchError((err) {
                                        print(err);
                                      });
                                    } else {
                                      print(_fbKey.currentState.value);
                                      print("validation failed");
                                    }
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Register(
                                          idnumber: idnumber,
                                          name: name,
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
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                        ),
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
