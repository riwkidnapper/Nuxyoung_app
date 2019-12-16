// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'listPaitient.dart';

// import 'package:nuxyoung/Pages/chat/chat.dart';

class PaitientCard extends StatefulWidget {
  PaitientCard({
    @required this.paitientName,
    @required this.timetoheal,
    @required this.symptoms,
  });
  final timetoheal;
  final paitientName;

  final symptoms;

  @override
  _PaitientCardState createState() => _PaitientCardState(
        paitientName: paitientName,
        timetoheal: timetoheal,
        symptoms: symptoms,
      );
}

class _PaitientCardState extends State<PaitientCard> {
  FirebaseUser currentUser;
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  _PaitientCardState(
      {@required this.paitientName,
      @required this.timetoheal,
      @required this.symptoms});

  final paitientName;
  final timetoheal;
  final symptoms;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: const Color(0xFFBDBDBD)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[50],
          ),
          //

          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('profliePaitient')
                  .where('ชื่อคนไข้', isEqualTo: paitientName)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                    ),
                  );
                } else {
                  if (snapshot.data.documents.length == 0) {
                    return null;
                  } else {
                    final documents = snapshot.data?.documents[0];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListPaitient(
                              treatment: documents['ประวัติการเข้ารับการรักษา'],
                              reason: documents['เหตุผลในการส่งต่อ'],
                              symptoms: symptoms,
                              timetoheal: timetoheal,
                              video: documents['วิดีโออาการเบื้องต้น'],
                              zipcode: documents['รหัสไปรษณีย์'],
                              address: documents['ที่อยู่'],
                              amphures: documents['อำเภอ'],
                              birthday: documents['วันเดือนปีเกิด'],
                              diagnosis: documents['การวินิจฉัยเบื้องต้น'],
                              district: documents['ตำบล'],
                              gender: documents['เพศ'],
                              idnumber: documents['รหัสประชาชน'],
                              provinces: documents['จังหวัด'],
                              paitientName: paitientName,
                              uid: documents['uid'],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'ชื่อคนไข้ : $paitientName',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                Text(
                                  symptoms != null
                                      ? 'อาการเบื้องต้น : $symptoms'
                                      : '',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'วันที่เข้ารับการรักษา : $timetoheal',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 14,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.insert_emoticon,
                                  size: 40.0,
                                  color: Colors.blueGrey,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                }
              })),
    );
  }
}
