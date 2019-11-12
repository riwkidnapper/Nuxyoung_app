import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nuxyoung/Pages/doctor_page/toolCalen.dart/data.dart';

class Symptom extends StatefulWidget {
  @override
  _SymptomState createState() => _SymptomState();
}

class _SymptomState extends State<Symptom> {
  PageController ctrl;

  final Firestore store = Firestore.instance;
  File newProfilePic;
  File _fileName;
  String _uploadedFileURL;
  File _video;
  bool _hasValidMime = false;
  FileType _pickingType;
  ValueChanged _onChanged = (val) => (val);
  TextEditingController _symptoms = new TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _sevekey = GlobalKey<FormBuilderState>();
  void _openFileExplorer() async {
    if (_pickingType != FileType.VIDEO || _hasValidMime) {
      try {
        _video = (await FilePicker.getFile(type: FileType.VIDEO));
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _fileName = _video ?? null;
      });
      print(_fileName);
    }
  }

  Future uploadFile(String name, String symptom) async {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('SymptomsVIDEO/$name');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_fileName);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then(
      (fileURL) async {
        setState(() {
          _uploadedFileURL = fileURL;
        });
        await store
            .collection("profliePaitient")
            .where('ชื่อคนไข้', isEqualTo: name)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/profliePaitient/${docs.documents[0].documentID}')
              .updateData({
            'วิดีโออาการเบื้องต้น': _uploadedFileURL,
            'ลักษณะอาการเบื้องต้น': symptom
          }).then((val) {
            print(_uploadedFileURL);
            print('File Uploaded');
          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      },
    ).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    String symptom;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อาการเบื้องต้น",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: ctrl,
          children: <Widget>[
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          FormBuilderTypeAhead(
                            decoration: InputDecoration(
                              labelText: 'ชื่อผู้ป่วย',
                              labelStyle: TextStyle(fontSize: 18.0),
                              icon: Icon(
                                Icons.portrait,
                                size: 30.0,
                              ),
                            ),
                            attribute: 'name',
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
                        ],
                      ),
                    ),
                  ),
                  FormBuilder(
                    key: _sevekey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            maxLines: 8,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _symptoms,
                            onSaved: (val) => symptom = val,
                            decoration: InputDecoration(
                              labelText: 'ลักษณะอาการเบื้องต้น',
                              labelStyle: TextStyle(fontSize: 18.0),
                              icon: Icon(
                                Icons.local_hospital,
                                size: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: RaisedButton.icon(
                        icon: Icon(
                          Icons.unarchive,
                          color: Colors.blueGrey[700],
                        ),
                        color: Colors.blueGrey[300],
                        onPressed: () {
                          _openFileExplorer();
                        }, //=> _openFileExplorer(),
                        label: new Text(
                          "เลือกวิดีโออาการผู้ป่วย",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () async {
                        _sevekey.currentState.save();
                        await uploadFile('อัครเดช เดทสิทธิ', symptom);
                      },
                      child: const Text(
                        'ยืนยันข้อมูล',
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
