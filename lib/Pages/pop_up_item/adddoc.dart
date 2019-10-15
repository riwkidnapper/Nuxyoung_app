import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        _asyncInputDialog(context);
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


Future<String> _asyncInputDialog(BuildContext context) async {
  ValueChanged _onChanged = (val) => print(val);
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(         
        title: Text('กรอกชื่อ-นามสกุล\nและตารางเวรของคุณที่นี่'),
          content: Container( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 200.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30.0,
                      ),
                      onPressed: () {
                        //getImage();
                      },
                    ),
                  ),
                TextFormField(
                  
                  decoration: InputDecoration(labelText: "ชื่อ-นามสกุล",hintText: null),   
                             
                  validator: (value){
                    if (value.isEmpty){
                      return 'Please Enter Text';
                    }
                    return null;
                  },
                  maxLines: 1,
                  maxLength: 30,
                  onChanged: _onChanged,
                ),  
                Row(
                  children: <Widget>[
                      Expanded(
                      child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                         _fbKey.currentState.save();
                          await store.collection("docname").add(data).then((value) {
                             print(value.documentID);
                           }).catchError((err) {
                             print(err);
                           });
                        
                      },
                    ),
                  ),
                  ],
                ),           
              ],
            ),
          ),
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
          );
    },
  );
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
