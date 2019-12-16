import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:nuxyoung/Pages/aleart.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:nuxyoung/Pages/homepage.dart';
import 'package:nuxyoung/Pages/UserAppointments.dart';
import 'package:nuxyoung/Pages/me.dart';

import 'Teb_iteam.dart';

int currentSelected = 2;

class FancyTabBar extends StatefulWidget {
  @override
  _FancyTabBarState createState() => _FancyTabBarState();
}

class _FancyTabBarState extends State<FancyTabBar>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;

  IconData nextIcon = Icons.home;
  IconData activeIcon = Icons.home;

  @override
  void initState() {
    super.initState();
    currentSelected = 2;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIM_DURATION));

    _positionTween = Tween<double>(begin: 0, end: 0);
    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    _loadCurrentUser();
  }

  FirebaseUser currentUser;
  void _loadCurrentUser() {
    FirebaseAuth?.instance?.currentUser()?.then((FirebaseUser user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          callPage(currentUser),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 55,
              minWidth: double.maxFinite,
            ),
            child: new DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -1),
                      blurRadius: 8)
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            margin: (currentSelected == 2) && (nextIcon == Icons.home)
                ? EdgeInsets.only(top: 0)
                : EdgeInsets.only(top: 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TabItem(
                  selected: currentSelected == 0,
                  iconData: Icons.local_hospital,
                  title: "บุคลากร",
                  callbackFunction: () {
                    setState(() {
                      currentSelected = 2;
                      if (currentUser?.uid != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              contentPadding: EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              children: <Widget>[
                                Container(
                                  constraints: new BoxConstraints(
                                    maxHeight: double.infinity,
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  color: Colors.white,
                                  margin: EdgeInsets.all(0.0),
                                  padding: EdgeInsets.only(
                                      bottom: 10.0,
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0),
                                  height: 200.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.error,
                                          size: 80.0,
                                          color: Colors.redAccent[200],
                                        ),
                                        margin: EdgeInsets.only(bottom: 10.0),
                                      ),
                                      Text(
                                        'คุณไม่ได้รับสิทธิใช้งานในส่วนนี้',
                                        style: TextStyle(
                                            color: Colors.blueGrey[700],
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0),
                                        child: Text(
                                          'บุคลากรหรือแพทย์เท่านั้น',
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.0, 8.0, 8.0, 15.0),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  50.0, 10.0, 50.0, 10.0),
                                              child: Text(
                                                'ยืนยัน',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          )),
                                    )),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              contentPadding: EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                              children: <Widget>[
                                Container(
                                  constraints: new BoxConstraints(
                                    maxHeight: double.infinity,
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  color: Colors.white,
                                  margin: EdgeInsets.all(0.0),
                                  padding: EdgeInsets.only(
                                      bottom: 10.0,
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0),
                                  height: 200.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.warning,
                                          size: 80.0,
                                          color: Colors.amberAccent[100],
                                        ),
                                        margin: EdgeInsets.only(bottom: 10.0),
                                      ),
                                      Text(
                                        'โปรดเข้าสู่ระบบ',
                                        style: TextStyle(
                                            color: Colors.blueGrey[700],
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0),
                                        child: Text(
                                          'เพื่อใช้งานในส่วนนี้',
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.0, 8.0, 8.0, 15.0),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  50.0, 10.0, 50.0, 10.0),
                                              child: Text(
                                                'ยืนยัน',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                          )),
                                    )),
                              ],
                            );
                          },
                        ).then((vulue) {
                          currentSelected = 2;
                        });
                      }
                    });
                  },
                ),
                TabItem(
                    selected: currentSelected == 1,
                    iconData: Icons.date_range,
                    title: "นัดหมาย",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.date_range;
                        if (currentUser != null)
                          currentSelected = 1;
                        else
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new Loginpage(),
                            ),
                          ).then((onValue) {
                            currentSelected = 2;
                          });
                      });
                    }),
                TabItem(
                    selected: currentSelected == 2, //กำหนดIconเริ่มต้น
                    title: "หน้าแรก",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.home;
                        currentSelected = 2;
                      });
                    },
                    iconData: null),
                TabItem(
                    selected: currentSelected == 3,
                    iconData: Icons.notifications,
                    title: "แจ้งเตือน",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.notifications;
                        if (currentUser != null)
                          currentSelected = 3;
                        else {
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new Loginpage(),
                            ),
                          ).then((onValue) {
                            currentSelected = 2;
                          });
                        }
                      });
                    }),
                TabItem(
                    selected: currentSelected == 4,
                    iconData: Icons.person,
                    title: "ฉัน",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.person;
                        if (currentUser != null)
                          currentSelected = 4;
                        else {
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new Loginpage(),
                            ),
                          ).then((onValue) {
                            currentSelected = 2;
                          });
                        }
                      });
                    }),
              ],
            ),
          ),
          IgnorePointer(
            child: (currentSelected == 2)
                ? Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Align(
                      heightFactor: 1,
                      alignment: Alignment(_positionAnimation.value, 0),
                      child: FractionallySizedBox(
                        widthFactor: 1 / 5,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 108,
                              width: 90,
                              child: ClipRect(
                                  clipper: HalfClipper(),
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 8)
                                              ])),
                                    ),
                                  )),
                            ),
                            SizedBox(
                                height: 60,
                                width: 80,
                                child: CustomPaint(
                                  painter: HalfPainter(),
                                )),
                            SizedBox(
                              height: 55,
                              width: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: THEME,
                                    border: Border.all(
                                        color: Colors.grey[100],
                                        width: 5,
                                        style: BorderStyle.none)),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.home,
                                    size: 25,
                                    color: Colors.blueGrey[900],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Align(
                      heightFactor: 1,
                      alignment: Alignment(_positionAnimation.value, 0),
                      child: FractionallySizedBox(
                        widthFactor: 1 / 5,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 105,
                              width: 90,
                              child: ClipRect(
                                  clipper: HalfClipper(),
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 8)
                                              ])),
                                    ),
                                  )),
                            ),
                            SizedBox(
                                height: 60,
                                width: 80,
                                child: CustomPaint(
                                  painter: HalfPainter(),
                                )),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                    border: Border.all(
                                        color: Colors.grey[100],
                                        width: 5,
                                        style: BorderStyle.none)),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.home,
                                    size: 25,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

Widget callPage(FirebaseUser currentUser) {
  if (currentSelected == 2) {
    return Home(); //
  } else if (currentSelected == 1) {
    return UserAppointments(currentUser);
  } else if (currentSelected == 3) {
    return Aleart();
  } else if (currentSelected == 4) {
    return ME();
  } else {
    return Home();
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
        Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.grey[100]);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
