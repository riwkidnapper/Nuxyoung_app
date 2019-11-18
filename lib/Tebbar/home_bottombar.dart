
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:nuxyoung/Auth/login_page.dart';
// import 'package:nuxyoung/Account/register_page.dart';

import 'package:nuxyoung/Tebbar/Teb_iteam.dart';
import 'package:nuxyoung/Tebbar/bomtombar.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser currentUser;
  
  void initState() {
    super.initState();
    _loadCurrentUser();
   
  }


  void _loadCurrentUser() {
    FirebaseAuth?.instance?.currentUser()?.then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  void _logIn() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
        ModalRoute.withName('/'));
  }

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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
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
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        endDrawer: new Drawer(
          child: SafeArea(
            child: new ListView(
              children: <Widget>[
                ListTile(
                  title: new Text(
                    "โปรดล็อคอินเพื่อเข้าใช้งานระบบ",
                  ),
                ),
                Divider(),
                ListTile(
                  trailing: new Icon(Icons.lock_open),
                  title: new Text(
                    "เข้าสู่ระบบ",
                  ),
                  onTap: _logIn,
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
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            gradient: LinearGradient(colors: [THEME, Colors.blueGrey[900]])),
        body: SafeArea(child: FancyTabBar()),
      );
    } else {
      return Scaffold(
        endDrawer: new Drawer(
          child: SafeArea(
            child: new ListView(
              children: <Widget>[
                ListTile(
                  title: new Text(
                    currentUser.email,
                  ),
                ),
                Divider(),
                ListTile(
                  trailing: new Icon(Icons.exit_to_app),
                  title: new Text(
                    "ออกจากระบบ",
                  ),
                  onTap: _logOut,
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
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            gradient: LinearGradient(colors: [THEME, Colors.blueGrey[900]])),
        body: SafeArea(child: FancyTabBar()),
      );
    }
  }
}
