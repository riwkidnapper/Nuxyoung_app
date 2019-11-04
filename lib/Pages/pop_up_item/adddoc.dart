import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nuxyoung/package/picker.dart';
import 'package:nuxyoung/package/image_picker.dart';
import 'package:video_player/video_player.dart';

//import 'package:image_picker/image_picker.dart';
class AddproflieDoc extends StatefulWidget {
  @override
  _AddproflieStateDoc createState() => _AddproflieStateDoc();
}

class _AddproflieStateDoc extends State<AddproflieDoc> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final Firestore store = Firestore.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  DateTime date;
  File _imageFile;
  dynamic _pickImageError;
  //String _retrieveDataError;
  bool isVideo = false;
  VideoPlayerController _controller;
  
  Future<void> _playVideo(File file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      _controller = VideoPlayerController.file(file);
      await _controller.setVolume(1.0);
      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {});
    }
  }
  void _onImageButtonPressed(ImageSource source) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final File file = await ImagePicker.pickVideo(source: source);
      await _playVideo(file);
    } else {
      try {
        _imageFile = await ImagePicker.pickImage(source: source);
        setState(() {});
      } catch (e) {
        _pickImageError = e;
      }
    }
  }
  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
      _controller = null;
    }
  }
  
  @override
  void initState() {
    date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await _asyncInputDialog(context);
      },
      child: Icon(
        Icons.add,
        size: 30,
      ),
      heroTag: null,
      mini: true,
      foregroundColor: Colors.blueGrey[900],
      backgroundColor: Colors.blueGrey[200],
    );
  }

  Future<bool> _asyncInputDialog(BuildContext context) async {
    ValueChanged _onChanged = (val) => print(val);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("กรอกชื่อ-นามสกุล\nและตารางเวรของคุณที่นี่"),
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormBuilder(
                      key: _fbKey,
                      autovalidate: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FormBuilderTextField(
                                    decoration: InputDecoration(
                                        labelText: "ชื่อ"),
                                    attribute: 'name',
                                    // readonly: true,
                                    onChanged: _onChanged,
                                    // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                                  ),
                          FormBuilderTextField(
                                    decoration: InputDecoration(
                                        labelText: "นามสกุล"),
                                    attribute: 'last',
                                    // readonly: true,
                                    onChanged: _onChanged,
                                    // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                                  ),
                        ],
                      ),
                    ),
                    DatePicker(
                      //title: "Date",
                      currentDate: date,
                      onSelect: (DateTime d) {
                        setState(() {
                          date = d;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   child: _image == null
                    //   ? Text ('No image Selected')
                    //   : Image.file(_image),                     
                    // ),
                    // FlatButton(
                    //   color: Colors.blueGrey[300],
                    //   textColor: Colors.blueGrey[800],
                    //   disabledColor: Colors.grey,
                    //   disabledTextColor: Colors.black,
                    //   padding: EdgeInsets.all(10.0),
                    //   splashColor: Colors.blueAccent,
                    //   onPressed: () async {
                    //     var image = await ImagePicker.pickImage(source: ImageSource.camera);
                    //     setState(() {
                    //       _image = image;
                    //     });
                    //   },                 
                    //   child: Text("Upload image"),
                    // ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton.icon(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.cyan[900],
                            ),
                            color: Colors.blueGrey[300],
                            label: Text(
                              "Upload Image",
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: (){
                                isVideo = false;
                              _onImageButtonPressed(ImageSource.gallery);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton.icon(
                            icon: Icon(
                              Icons.check_box,
                              color: Colors.cyan[900],
                            ),
                            color: Colors.blueGrey[300],
                            label: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                                _fbKey?.currentState?.save();
                                if (_fbKey?.currentState?.validate() ?? true) {
                                  //var name = _nameController.value.text;
                                  //var last = _lastController.value.text;
                                      var values = _fbKey?.currentState?.value;
                                      print(values);
                                      var data = <String, dynamic>{};
                                      data["name"] = values["name"] ?? "";
                                      //data["name"] = name;
                                      //data["last"] = last;
                                      data["last"] = values["last"] ?? "";
                                      data["date"] = date;
                                      await store.collection("pro_doc").add(data).then((value) {
                                        print(value.documentID);
                                      }).catchError((err) {
                                        print(err);
                                      });
                                    } else {
                                      print(_fbKey.currentState.value);
                                      print("validation failed");
                                    }
                            },
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ));
  }
  // showDialog<String>(
  //   context: context,
  //   barrierDismissible:
  //       false, // dialog is dismissible with a tap on the barrier
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: Text('กรอกชื่อ-นามสกุล\nและตารางเวรของคุณที่นี่'),
  //       content: Column(
  //         children: <Widget>[
  //           Expanded(
  //             child: TextField(
  //               autofocus: true,
  //               decoration: InputDecoration(
  //                   labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
  //               onChanged: (value) {
  //                 teamName = value;
  //               },
  //             ),
  //           ),
  //           Expanded(
  //             child: TextField(
  //               autofocus: true,
  //               decoration: InputDecoration(
  //                   labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
  //               onChanged: (value) {
  //                 teamName = value;
  //               },
  //             ),
  //           ),
  //           Expanded(
  //             child: TextField(
  //               autofocus: true,
  //               decoration: InputDecoration(
  //                   labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
  //               onChanged: (value) {
  //                 teamName = value;
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text('Ok'),
  //           onPressed: () {
  //             Navigator.of(context).pop(teamName);
  //           },
  //         ),
  //       ],
  //     );
  //   },
  // );
}
