import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Editll extends StatefulWidget {
  @override
  _EditllState createState() => _EditllState();
}

class _EditllState extends State<Editll> {
  final Firestore store = Firestore.instance;
  //final GlobalKey<FormState> _fbKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  TextEditingController _messController;
  @override
  void initState() { 
    super.initState();
    _messController = TextEditingController();
  }
  void reset() {
    _fbKey.currentState.reset();
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

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("เขียนบทความ"),
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
                         Text(
                            'บทความ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        TextFormField(
                            controller: _messController,
                            maxLines: 7,
                            style: TextStyle(fontSize: 18),
                            //onChanged: _onChanged,
                          ),
                        SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
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
                              "ยืนยัน",
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              _fbKey?.currentState?.save();
                              if (_fbKey?.currentState?.validate() ?? true) {
                                var messege = _messController?.value?.text;
                                var data = {
                                  "article" : messege,
                                };
                              await store.collection("article").add(data).then((value) {
                                  print(value.documentID);
                                }).catchError((err) {
                                  print(err);
                                });
                            } else {
                                  setState(() {
                                  print("validation failed");
                              });
                             }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
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
                              _fbKey.currentState.reset();
                            },
                          ),
                        ),
                      ],
                    ),
          ],
        ),
      ),

    )
  );
}
  
}
 