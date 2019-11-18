import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:nuxyoung/Pages/doctor_page/appointment.dart';

import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
import 'package:nuxyoung/Pages/doctor_page/profile.dart';
import 'package:nuxyoung/Pages/doctor_page/register_medical.dart';
import 'package:nuxyoung/Pages/doctor_page/symptoms.dart';
// import 'package:nuxyoung/Pages/doctor_page/video.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

import 'chat/Tools/custom_heading.dart';
import 'chat/Tools/screenloadingchat.dart';
import 'doctor_page/Page/PaitientCard.dart';

class MedicalBudhosp extends StatefulWidget {
  final FirebaseUser currentUser;

  const MedicalBudhosp({Key key, this.currentUser}) : super(key: key);

  @override
  _MedicalBudhospState createState() => _MedicalBudhospState(currentUser);
}

class _MedicalBudhospState extends State<MedicalBudhosp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseUser currentUser;
  String userEmail;

  String doctorname;
  String photoUser;

  _MedicalBudhospState(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: GradientAppBar(
            leading: new IconButton(
              icon: new Icon(
                Icons.menu,
                color: Colors.blueGrey,
              ),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            title: Text(
              'Medical',
              style: TextStyle(
                color: Colors.blueGrey[700],
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  const IconData(0xe800, fontFamily: 'chat'),
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new HomePage(),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                icon: Icon(
                  const IconData(0xe811, fontFamily: 'chat'),
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new LoadingChat(),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                icon: Icon(
                  const IconData(0xe801, fontFamily: 'chat'),
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Container(),
                    ),
                  );
                },
              ),
            ],
            gradient:
                LinearGradient(colors: [Colors.white, Colors.blueGrey[50]])),
        /************************************************************************ */
        drawer: new Drawer(
            elevation: 20.0,
            child: StreamBuilder(
                stream: currentUser.uid != null
                    ? Firestore?.instance
                        ?.collection('users')
                        ?.where('uid', isEqualTo: currentUser.uid)
                        ?.snapshots()
                    : null,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                      ),
                    );
                  }
                  var doctorname = snapshot.data?.documents[0]['name'];
                  var photoUser = snapshot.data?.documents[0]['photoUser'];
                  userEmail = currentUser.email;
                  return ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(doctorname),
                        accountEmail: Text(
                          userEmail,
                        ),
                        currentAccountPicture: Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: NetworkImage(
                                photoUser,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: new BorderRadius.all(
                              new Radius.circular(100.0),
                            ),
                            border: new Border.all(
                              color: Colors.blueGrey[600],
                              width: 2.0,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[400],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.content_paste,
                          color: Colors.blueGrey,
                        ),
                        title: Text('กรอกประวัติผู้ป่วย'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profilerecord(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.healing,
                          color: Colors.blueGrey,
                        ),
                        title: Text('อาการเบื้องต้น'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Symptom()));
                        },
                      ),
                      // ListTile(
                      //   leading: Icon(
                      //     Icons.videocam,
                      //     color: Colors.blueGrey,
                      //   ),
                      //   title: Text('วิดีโอ'),
                      //   onTap: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) => ChewieDemo()));
                      //   },
                      // ),
                      ListTile(
                        leading: Icon(
                          Icons.today,
                          color: Colors.blueGrey,
                        ),
                        title: Text('ตารางแพทย์เวร'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CaLenDar()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.add_to_queue,
                          color: Colors.blueGrey,
                        ),
                        title: Text('การนัดหมาย'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Appointment(),
                              ));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.group_add,
                          color: Colors.blueGrey,
                        ),
                        title: Text('ลงทะเบียนบุคลากร'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicalRegister(),
                              ));
                        },
                      )
                    ],
                  );
                })),
        // body: ListView.builder(
        //   itemBuilder: (context, position){
        //     return Card(
        //       child: Padding(
        //         padding: const EdgeInsets.all(40.0),
        //         child: Text(position.toString(),style: TextStyle(fontSize: 22.0),
        //         ),
        //       ),);
        //   },
        // ),
        /****************************************************************************** */
        body: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/homewall.png'),
                    colorFilter: new ColorFilter.mode(
                        Colors.grey[50].withOpacity(0.3), BlendMode.dstATop),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      CustomHeading(title: 'รายชื่อผู้ป่วย'),
                      StreamBuilder(
                        stream: Firestore?.instance
                            ?.collection('profliePaitient')
                            ?.orderBy('วันเวลาที่เข้ารับการรักษา')
                            ?.orderBy('ชื่อคนไข้')
                            ?.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blueGrey),
                              ),
                            );
                          } else {
                            if (snapshot.data.documents.length == 0) {
                              return null;
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  final documents =
                                      snapshot.data?.documents[index];
                                  Timestamp t =
                                      documents['วันเวลาที่เข้ารับการรักษา'];
                                  var times = t.toDate();
                                  final f =
                                      new DateFormat('dd MMMM yyyy', "th_TH");

                                  String timetoheal = f.format(times);
                                  return PaitientCard(
                                    paitientName: documents['ชื่อคนไข้'],
                                    symptoms: documents['ลักษณะอาการเบื้องต้น'],
                                    timetoheal: timetoheal,
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
