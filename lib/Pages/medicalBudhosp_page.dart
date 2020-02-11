import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:nuxyoung/Pages/doctor_page/appointment.dart';

import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
import 'package:nuxyoung/Pages/doctor_page/profile.dart';
import 'package:nuxyoung/Pages/doctor_page/register_medical.dart';
import 'package:nuxyoung/Pages/doctor_page/symptoms.dart';
import 'package:nuxyoung/Pages/pop_up_item/notify.dart';
import 'package:nuxyoung/Tebbar/Teb_iteam.dart';
// import 'package:nuxyoung/Pages/doctor_page/video.dart';

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
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String photoUser;

  _MedicalBudhospState(this.currentUser);
  void _logOut() async {
    {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              contentPadding:
                  EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
              children: <Widget>[
                Container(
                  color: THEME,
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  height: 120.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.exit_to_app,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      ),
                      Text(
                        'ออกจากระบบ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'คุณต้องการออกจากระบบใช่ไหม ?',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.cancel,
                          color: THEME,
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Text(
                        'CANCEL',
                        style: TextStyle(
                            color: THEME, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.check_circle,
                          color: THEME,
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                      ),
                      Text(
                        'YES',
                        style: TextStyle(
                            color: THEME, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            );
          })) {
        case 0:
          break;
        case 1:
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Loginpage(),
            ),
          );
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      await Firestore?.instance
          ?.collection("users")
          ?.where('uid', isEqualTo: currentUser.uid)
          ?.getDocuments()
          ?.then((docs) {
        Firestore?.instance
            ?.document('/users/${docs.documents[0].documentID}')
            ?.updateData({
          'devtoken': token,
        })?.then((onValue) {
          print("Token : $token");
        })?.catchError((e) {
          print(e);
        });
      })?.catchError((e) {
        print(e);
      });
    });
  }

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
              IconButton(
                icon: Icon(
                  const IconData(0xe801, fontFamily: 'chat'),
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Notify(),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 20.0,
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
                                        doctorname: doctorname,
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
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.blueGrey,
                        ),
                        title: Text('ออกจากระบบ'),
                        onTap: () {
                          _logOut();
                        },
                      )
                    ],
                  );
                })),
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
                              ?.orderBy('วันเวลาที่เข้ารับการรักษา',
                                  descending: true)
                              ?.orderBy('ชื่อคนไข้', descending: false)
                              ?.snapshots() ??
                          null,
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
                            return Container();
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
              ),
            ),
            
          ],
        ));
  }
}
