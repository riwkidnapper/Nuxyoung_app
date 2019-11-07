import 'package:flutter/material.dart';
import 'package:flutter_thailand_provinces/dao/amphure_dao.dart';
import 'package:flutter_thailand_provinces/dao/district_dao.dart';
import 'package:flutter_thailand_provinces/dao/province_dao.dart';
import 'package:flutter_thailand_provinces/provider/amphure_provider.dart';
import 'package:flutter_thailand_provinces/provider/district_provider.dart';
import 'package:flutter_thailand_provinces/provider/province_provider.dart';
import 'extension/ProvinceDialog.dart';
import 'extension/ZipcodeDialog.dart';
import 'extension/choose_dialog.dart';
import 'extension/date.dart';
import 'extension/districtDialog.dart';
import 'medicalrecords.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import './data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilerecord extends StatefulWidget {
  @override
  _ProfilerecordState createState() => _ProfilerecordState();
}

class _ProfilerecordState extends State<Profilerecord> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _amphures = new TextEditingController();
  TextEditingController _district = new TextEditingController();
  TextEditingController _zipcode = new TextEditingController();
  AmphureDao amphureSelected;
  DistrictDao districtSelected;
  ProvinceDao province;
  ProvinceDao provinceSelected;

  final Firestore store = Firestore.instance;
  ValueChanged _onChanged = (val) => (val);
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String zipcode;

  void _clear() {
    _fbKey.currentState?.reset();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Profilerecord()),
    );
  }

  bool onClick = false;
  @override
  Widget build(BuildContext context) {
    String idnumber;
    String name;
    String address;
    String provinces;
    String amphures;
    String district;
    String zipcode;
    return Scaffold(
        key: _scaffoldKey,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "ชื่อ-นามสกุล"),
                          autocorrect: true,
                          // readonly: true,
                          onChanged: _onChanged,
                          // validator: (value) =>
                          //     value.isEmpty ? 'ชื่อ-นามสกุลไม่ควรเว้นว่าง' : null,
                          onSaved: (val) => name = val,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "เลขบัตรประจำตัวประชาชน",
                          ),
                          onChanged: _onChanged,
                          // validator: (val) => val.isEmpty
                          //     ? 'เลขบัตรประจำตัวประชาชนไม่ควรเว้นว่าง'
                          //     : null,
                          onSaved: (val) => idnumber = val,
                        ),
                        DateTimePicker(
                          firstDate: DateTime(DateTime.now().year - 162),
                          lastDate: DateTime(DateTime.now().year + 138),
                          locale: Locale("th", "TH"),
                          attribute: "birthday",
                          onChanged: _onChanged,
                          inputType: InputTypedate?.date ?? false,
                          decoration:
                              InputDecoration(labelText: "วันเดือนปีเกิด"),
                        ),
                        FormBuilderDropdown(
                          attribute: "gender",
                          decoration: InputDecoration(
                            labelText: "ระบุเพศ",
                          ),
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
                        TextFormField(
                          decoration: InputDecoration(labelText: "ที่อยู่"),
                          onChanged: _onChanged,
                          onSaved: (val) => address = val,
                          // validator: (_controller) {
                          //   if (_controller.isEmpty) {
                          //     return 'ที่อยู่ไม่ควรเว้นว่าง';
                          //   }
                          //   return null;
                          // },
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: (TextFormField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: "จังหวัด",
                                ),
                                controller: _controller,
                                onSaved: (val) => provinces = val,
                              )),
                            ),
                            GestureDetector(
                              onTap: () async {
                                List list = await ProvinceProvider.all();
                                province = await ProvinceDialog.show(
                                  context,
                                  listProvinces: list,
                                );
                                setState(() {
                                  provinceSelected = province;
                                  _controller.text =
                                      provinceSelected?.nameTh ?? "";
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(18, 16, 10, 16),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 30.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: "เขต/อำเภอ",
                                ),

                                controller: _amphures,
                                onSaved: (val) => amphures = val,
                                // validator: (_controller) {
                                //   if (_controller.isEmpty) {
                                //     return 'กรุณาระบุจังหวัด';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                List list = await AmphureProvider.all(
                                  provinceId: province?.id ??
                                      _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: Text(
                                            'กรุณาระบุจังหวัด',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          duration:
                                              Duration(milliseconds: 2500),
                                          backgroundColor: Colors.grey[600],
                                        ),
                                      ),
                                );

                                AmphureDao amphure =
                                    await ChooseAmphreDialog.show(
                                  context,
                                  listProvinces: list,
                                );
                                setState(() {
                                  amphureSelected = amphure;
                                  _amphures.text =
                                      amphureSelected?.nameTh ?? "";
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(18, 16, 10, 16),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 30.0,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: "แขวง/ตำบล",
                                ),
                                controller: _district,
                                onSaved: (val) => district = val,
                                // validator: (_amphures) {
                                //   if (_amphures.isEmpty) {
                                //     return 'กรุณาระบุจังหวัดและอำเภอ';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                List list = await DistrictProvider.all(
                                  amphureId: amphureSelected?.id ??
                                      _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: Text(
                                            'กรุณาระบุจังหวัดแะลระบุอำเภอ',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          duration:
                                              Duration(milliseconds: 2500),
                                          backgroundColor: Colors.grey[600],
                                        ),
                                      ),
                                );

                                DistrictDao districtDao =
                                    await DistrictDialog.show(
                                  context,
                                  listProvinces: list,
                                );
                                setState(() {
                                  districtSelected = districtDao;
                                  _district.text =
                                      districtSelected?.nameTh ?? "";
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(18, 16, 10, 16),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 30.0,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  labelText: "รหัสไปรษณีย์",
                                ),
                                controller: _zipcode,
                                onSaved: (val) => zipcode = val,
                                // validator: (_amphures) {
                                //   if (_amphures.isEmpty) {
                                //     return 'กรุณาระบุจังหวัดและอำเภอ';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                List list = await DistrictProvider.all(
                                  amphureId: amphureSelected?.id ??
                                      _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: Text(
                                            'กรุณาระบุจังหวัดแะลระบุอำเภอ',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          duration:
                                              Duration(milliseconds: 2500),
                                          backgroundColor: Colors.grey[600],
                                        ),
                                      ),
                                );

                                DistrictDao districtDao =
                                    await ZipcodeDialog.show(
                                  context,
                                  listProvinces: list,
                                );
                                setState(() {
                                  districtSelected = districtDao;
                                  _zipcode.text =
                                      districtSelected?.zipCode ?? "";
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(18, 16, 10, 16),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 30.0,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
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

                          if (_fbKey.currentState.validate()) {
                            var values = _fbKey.currentState.value;
                            final DateTime hbd = values["birthday"];

                            print(values);
                            if (DateTime(
                                        DateTime.now().year + 543,
                                        DateTime.now().month,
                                        DateTime.now().day)
                                    .compareTo(hbd) >=
                                0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Medicalrec(
                                    idnumber: idnumber,
                                    name: name,
                                    gender: values["gender"],
                                    birthday: values["birthday"],
                                    address: address,
                                    provinces: provinces,
                                    amphures: amphures,
                                    district: district,
                                    zipcode: zipcode,
                                  ),
                                ),
                              );
                            } else
                              _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(
                                content: Text(
                                  'วันเดือนปีเกิดไม่ถูกต้อง/ไม่สามารถระบุวันเดือนเกิดในอนาคตได้',
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(milliseconds: 2500),
                                backgroundColor: Colors.red,
                              ));
                          }
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
                            onPressed: () => {
                                  _clear(),
                                }),
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
        ));
  }
}
