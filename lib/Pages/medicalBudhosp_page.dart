import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:nuxyoung/Pages/doctor_page/appointment.dart';

import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
import 'package:nuxyoung/Pages/doctor_page/profile.dart';
import 'package:nuxyoung/Pages/doctor_page/register_medical.dart';
import 'package:nuxyoung/Pages/doctor_page/symptoms.dart';
import 'package:nuxyoung/Pages/doctor_page/video.dart';
// import 'package:nuxyoung/Pages/doctor_page/video.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat/Tools/screenloadingchat.dart';

class MedicalBudhosp extends StatefulWidget {
  final String userEmail;

  const MedicalBudhosp({Key key, this.userEmail}) : super(key: key);
  @override
  _MedicalBudhospState createState() => _MedicalBudhospState(userEmail);
}

class _MedicalBudhospState extends State<MedicalBudhosp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String userEmail;

  _MedicalBudhospState(this.userEmail);
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
              'Welcome Doctor',
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
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Doctor Marnoj"),
                accountEmail: Text(
                  userEmail,
                ),
                currentAccountPicture: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage("assets/images/profiledoc.png"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Symptom()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.videocam,
                  color: Colors.blueGrey,
                ),
                title: Text('วิดีโอ'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChewieDemo()));
                },
              ),
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
                          builder: (context) => CaLenDar(
                                title: 'Calendar',
                              )));
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
          ),
        ),
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
            ),
          ],
        ));
  }
}
