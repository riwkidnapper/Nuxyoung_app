import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuxyong_app/Auth/login_page.dart';
// import 'package:nuxyong_app/Account/register_page.dart';
import 'package:nuxyong_app/Pages/homepage.dart';
import 'package:nuxyong_app/Pages/Pages2.dart';
import 'package:nuxyong_app/Pages/medicalBudhosp_page.dart';
import 'package:nuxyong_app/Pages/me.dart';
import 'package:nuxyong_app/Tebbar/Teb_iteam.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:gradient_app_bar/gradient_app_bar.dart';

int currentSelected = 2;

class HomePage extends StatefulWidget {
  // final FirebaseUser user;

  // HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
        ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: new Drawer(
        child: SafeArea(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new Text("widget.user.email"),
              ),
              new Divider(),
              new ListTile(
                title: new Text("Settings"),
                trailing: new Icon(Icons.settings),
                onTap: logOut,
              ),
              new ListTile(
                title: new Text("Login"),
                trailing: new Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
      appBar: new GradientAppBar(
        centerTitle: true,
        title: new Text(
          'นัดยัง',
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColorStart: THEME,
        backgroundColorEnd: Colors.blueGrey[900],
      ),

      // PreferredSize(
      //   child: new Container(
      //     padding:
      //         new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      //     child: new Padding(
      //       padding: const EdgeInsets.all(
      //         15,
      //       ), //ความกว้างสูงยาวAppbar
      //       child: new Text(
      //         'PROJECT',
      //         textAlign: TextAlign.center,
      //         style: new TextStyle(
      //             fontSize: 20.0,
      //             fontWeight: FontWeight.w500,
      //             color: Colors.white),
      //       ),
      //     ),

      //     decoration: new BoxDecoration(
      //       gradient: new LinearGradient(
      //         begin: const FractionalOffset(0.3, 2.0),
      //         end: const FractionalOffset(-0.2, 0.2),
      //         colors: [
      //           THEME,
      //           Colors.lightBlueAccent[700],

      //           /*THEME,
      //               Colors.blueGrey[800],*/
      //         ],
      //       ),
      //       /*boxShadow: [
      //           new BoxShadow(
      //             color: Colors.grey[500],
      //             blurRadius: 10.0,
      //             spreadRadius: 0.5,
      //           )
      //         ]*/
      //     ),
      //   ),
      //   preferredSize: new Size(
      //     MediaQuery.of(context).size.width,
      //     150.0,
      //   ),
      // ),
      body: SafeArea(child: FancyTabBar()),
    );
  }
}

class FancyTabBar extends StatefulWidget {
  @override
  _FancyTabBarState createState() => _FancyTabBarState();
}

class _FancyTabBarState extends State<FancyTabBar>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;

//กำหนดIconเริ่มต้น
  IconData nextIcon = Icons.home;
  IconData activeIcon = Icons.home;

  @override
  void initState() {
    super.initState();
//กำหนดเวลา
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIM_DURATION));

    _positionTween = Tween<double>(begin: 0, end: 0);
    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          callPage(),
          ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 68,
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
            height: 100, //100
            margin: (currentSelected == 2) && (nextIcon == Icons.home)
                ? EdgeInsets.only(top: 0)
                : EdgeInsets.only(top: 0), //535
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TabItem(
                  selected: currentSelected == 0,
                  iconData: Icons.local_hospital,
                  title: "เจ้าหน้าที่",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.local_hospital;
                      currentSelected = 2;
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new MedicalBudhosp(),
                        ),
                      );
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
                        currentSelected = 1;
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
                        currentSelected = 3;
                      });
                    }),
                TabItem(
                    selected: currentSelected == 4,
                    iconData: Icons.person,
                    title: "ฉัน",
                    callbackFunction: () {
                      setState(() {
                        nextIcon = Icons.person;
                        currentSelected = 4;
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
                              height: 135,
                              width: 90,
                              child: ClipRect(
                                  clipper: HalfClipper(),
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                          width: 70,
                                          height: 70,
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
                                height: 70,
                                width: 90,
                                child: CustomPaint(
                                  painter: HalfPainter(),
                                )),
                            SizedBox(
                              height: 60,
                              width: 60,
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
                                    size: 35,
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
                              height: 135,
                              width: 90,
                              child: ClipRect(
                                  clipper: HalfClipper(),
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                          width: 70,
                                          height: 70,
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
                                height: 70,
                                width: 90,
                                child: CustomPaint(
                                  painter: HalfPainter(),
                                )),
                            SizedBox(
                              height: 60,
                              width: 60,
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
                                    size: 35,
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

Widget callPage() {
  if (currentSelected == 2) {
    return Home(); //
  } else if (currentSelected == 1) {
    return Pagetwo();
  } else if (currentSelected == 3) {
    return Pagetwo();
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
