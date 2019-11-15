import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nuxyoung/Pages/medicalBudhosp_page.dart';
import 'package:nuxyoung/package/chewie/src/chewie_player.dart';
import 'package:nuxyoung/package/video_player.dart';

final Firestore store = Firestore.instance;

class Symptom extends StatefulWidget {
  @override
  _SymptomState createState() => _SymptomState();
}

class _SymptomState extends State<Symptom> {
  PageController ctrl;
  String id;
  var selectedCurrency, selectedType;
  File newProfilePic;
  File _fileName;
  String _uploadedFileURL;
  File _video;
  bool load = false;
  bool _hasValidMime = false;
  FileType _pickingType;
  VideoPlayerController _videoPlayerController1;
  TextEditingController _symptoms = new TextEditingController();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _sevekey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ChewieController _chewieController;

  @override
  void initState() {
    load = false;
    super.initState();
  }

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
        _videoPlayerController1 = VideoPlayerController.file(_fileName);
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController1,
          aspectRatio: 3 / 2,
          autoPlay: true,
          looping: false,
        );
      });
      print(_fileName);
    }
  }

  Future uploadFile(String name, String symptom) async {
    setState(() {
      load = true;
    });
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
          store
              .document('/profliePaitient/${docs.documents[0].documentID}')
              .updateData({
            'วิดีโออาการเบื้องต้น': _uploadedFileURL,
            'ลักษณะอาการเบื้องต้น': symptom
          }).then((val) {
            setState(() {
              load = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MedicalBudhosp(),
              ),
            );
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
      key: _scaffoldKey,
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
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Form(
                key: _fbKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                  child: ListView(
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('profliePaitient')
                            .orderBy('ชื่อคนไข้')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return const Text("Loading.....");
                          else {
                            List<DropdownMenuItem> currencyItems = [];
                            for (int i = 0;
                                i < snapshot.data.documents.length;
                                i++) {
                              DocumentSnapshot snap =
                                  snapshot.data.documents[i];
                              currencyItems.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap['ชื่อคนไข้'],
                                  ),
                                  value: "${snap['ชื่อคนไข้']}",
                                ),
                              );
                            }
                            return Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.portrait,
                                  size: 30.0,
                                ),
                                SizedBox(width: 20.0),
                                DropdownButton(
                                  items: currencyItems,
                                  onChanged: (currencyValue) {
                                    setState(() {
                                      selectedCurrency = currencyValue;
                                    });
                                    print(selectedCurrency);
                                  },
                                  value: selectedCurrency,
                                  isExpanded: false,
                                  hint: new Text(
                                    "ชื่อผู้ป่วย            ",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
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
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: (_fileName != null)
                              ? Chewie(
                                  controller: _chewieController,
                                )
                              : Text(
                                  'ไม่มีวิดีโอที่จะแสดง',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 20.0),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
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
                              if (_sevekey.currentState.validate()) {
                                (_fileName != null)
                                    ? await uploadFile(
                                        selectedCurrency, symptom)
                                    : _scaffoldKey.currentState.showSnackBar(
                                        new SnackBar(
                                          content: Text(
                                            'ไม่มีวิดีโอที่จะทำการอัปโหลด',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          duration:
                                              Duration(milliseconds: 2500),
                                          backgroundColor: Colors.blueGrey[600],
                                        ),
                                      );
                              }
                            },
                            child: load == false
                                ? Text(
                                    'ยืนยันข้อมูล',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blueGrey),
                                  )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  searchByName() {
    StreamBuilder<QuerySnapshot>(
      stream: store.collection('profliePaitient').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
              children: snapshot.data.documents
                  .map((doc) => buildItem(doc))
                  .toList());
        } else {
          return SizedBox();
        }
      },
    );
  }
}

Text buildItem(DocumentSnapshot doc) {
  return Text(
    'name: ${doc.data['ชื่อคนไข้']}',
    style: TextStyle(fontSize: 24),
  );
}
