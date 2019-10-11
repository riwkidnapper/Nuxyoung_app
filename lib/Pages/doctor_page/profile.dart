import 'package:flutter/material.dart';
import 'medicalrecords.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import './data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilerecord extends StatefulWidget {
  @override
  Profile createState() {
    return Profile();
  }
}

class Profile extends State<Profilerecord> {
  PageController ctrl;
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final Firestore store = Firestore.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  ValueChanged _onChanged = (val) => (val);

  @override
  void initState() {
    ctrl = PageController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("กรอกประวัติผู้ป่วย"),
          backgroundColor: Colors.blueGrey[500],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: ctrl,
                children: <Widget>[
                  Padding(
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
                                FormBuilderTextField(
                                  decoration: InputDecoration(
                                      labelText: "ชื่อ-นามสกุล"),
                                  attribute: 'name',
                                  // readonly: true,
                                  onChanged: _onChanged,
                                  // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                                ),
                                FormBuilderTextField(
                                  keyboardType: TextInputType.number,
                                  attribute: "identification number",
                                  decoration: InputDecoration(
                                    labelText: "เลขบัตรประจำตัวประชาชน",
                                    /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                                  ),
                                  onChanged: _onChanged,
                                  //valueTransformer: (text) => num.tryParse(text),
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.max(9999999999999999),
                                  ],
                                ),
                                FormBuilderTextField(
                                  keyboardType: TextInputType.number,
                                  attribute: "age",
                                  decoration: InputDecoration(
                                    labelText: "อายุ",
                                    /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                                  ),
                                  onChanged: _onChanged,
                                  //valueTransformer: (text) => num.tryParse(text),
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.max(70),
                                  ],
                                ),
                                FormBuilderDropdown(
                                  attribute: "gender",
                                  decoration: InputDecoration(
                                    labelText: "ระบุเพศ",
                                    /*border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),*/
                                  ),
                                  // readOnly: true,
                                  initialValue: 'ชาย',
                                  items: [
                                    'ชาย',
                                    'หญิง',
                                  ].map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                FormBuilderTextField(
                                  decoration:
                                      InputDecoration(labelText: "ที่อยู่"),
                                  attribute: 'addres',
                                  // readonly: true,
                                  onChanged: _onChanged,
                                  // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                                ),
                                FormBuilderTypeAhead(
                                  decoration: InputDecoration(
                                    labelText: "จังหวัด",
                                  ),
                                  attribute: 'country',
                                  onChanged: _onChanged,
                                  itemBuilder: (context, country) {
                                    return ListTile(
                                      title: Text(country),
                                    );
                                  },
                                  suggestionsCallback: (query) {
                                    if (query.length != 0) {
                                      var lowercaseQuery = query.toLowerCase();
                                      return allCountries.where((country) {
                                        return country
                                            .toLowerCase()
                                            .contains(lowercaseQuery);
                                      }).toList(growable: false)
                                        ..sort((a, b) => a
                                            .toLowerCase()
                                            .indexOf(lowercaseQuery)
                                            .compareTo(b
                                                .toLowerCase()
                                                .indexOf(lowercaseQuery)));
                                    } else {
                                      return allCountries;
                                    }
                                  },
                                ),
                                new FormBuilderTextField(
                                  attribute: 'district',
                                  decoration: InputDecoration(
                                      labelText: "เขต/อำเภอ", hintText: null),
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onChanged,
                                  maxLines: 1,
                                ),
                                new FormBuilderTextField(
                                  attribute: 'subdistrict',
                                  decoration: InputDecoration(
                                      labelText: "แขวง/ตำบล", hintText: null),
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onChanged,
                                  maxLines: 1,
                                ),
                                new FormBuilderTextField(
                                  attribute: 'postcode',
                                  decoration: InputDecoration(
                                      labelText: "รหัสไปรษณีย์",
                                      hintText: null),
                                  keyboardType: TextInputType.number,
                                  onChanged: _onChanged,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              FlatButton.icon(
                                onPressed: () async {
                                  _fbKey.currentState.save();
                                  // if (_fbKey.currentState.validate()) {
                                  //   var values = _fbKey.currentState.value;
                                  //   print(values);
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
                                  //   //data["signature"] = values["signature"];
                                  //   await store.collection("form").add(data).then((value) {
                                  //     print(value.documentID);
                                  //   }).catchError((err) {
                                  //     print(err);
                                  //   });
                                  // } else {
                                  //   print(_fbKey.currentState.value);
                                  //   print("validation failed");
                                  // }
                                  await ctrl.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                icon: Icon(
                                  Icons.navigate_next,
                                  color: Colors.blueGrey[700],
                                ),
                                label: Text(
                                  "ถัดไป",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60,
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
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.hdr_weak,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Medicalrec(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
