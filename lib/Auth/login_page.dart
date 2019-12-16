import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/medicalBudhosp_page.dart';
import 'package:nuxyoung/Pages/pop_up_item/color_loader.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';
import 'package:nuxyoung/package/screenutil/flutter_screenutil.dart';
import 'package:nuxyoung/Auth/pack_acc/form.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<Color> colors = [
  Colors.blueGrey,
  Colors.blueGrey[400],
];

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FirebaseUser currentUser;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final AuthResult authResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        final FirebaseUser firebaseUser = authResult.user;

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: ColorLoader(
                  colors: colors,
                ),
              );
            });

        //print('Signed in: ${user.uid},${user.email}');
        Future.delayed(new Duration(milliseconds: 1500), () {
          if (firebaseUser != null) {
            Firestore.instance
                ?.collection("users")
                ?.where('uid', isEqualTo: firebaseUser?.uid)
                ?.where('email', isEqualTo: firebaseUser?.email)
                ?.getDocuments()
                ?.then((QuerySnapshot snapshot) {
              if (snapshot.documents[0]['rule'] == 'user') {
                Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        ModalRoute.withName('/'))
                    .catchError((err) => print(err));
              } else {
                Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalBudhosp(
                                  currentUser: firebaseUser,
                                )),
                        ModalRoute.withName('/medical'))
                    .catchError((err) => print(err));
              }
            });
          }
        });
      } catch (e) {
        print(e.message);
        if (e.message ==
            'Too many unsuccessful login attempts. Please try again later.') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color(0xFFFFFFFF),
                  content: SingleChildScrollView(
                      child: Center(
                          child: Column(
                    children: <Widget>[
                      Text('❗️มีบางอย่างผิดพลาด.'),
                      Text('\tโปรดลองใหม่อีกครั้ง'),
                    ],
                  ))),
                );
              });
        }
      }
    }
  }

  void signInAnonymously() async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: ColorLoader(
                colors: colors,
              ),
            );
          });

      // final AuthResult authanoResult =
      //     await FirebaseAuth.instance.signInAnonymously();
      // final FirebaseUser anouser = authanoResult.user;
      // print('Signed in: ${anouser.uid}');
      Future.delayed(new Duration(milliseconds: 1200), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            ModalRoute.withName('/'));
      });
    } catch (e) {
      print('Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: buildLogin(),
        ),
      ),
    );
  }

  List<Widget> buildLogin() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 120.0, top: 50.0),
              width: 1500.0,
              child: Image.asset("assets/images/login.png")),
          Expanded(
            child: Container(),
          ),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/dvmcity.gif"),
                    fit: BoxFit.fitWidth)),
          )
        ],
      ),
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Welcome to Login",
                  style: TextStyle(
                      fontFamily: "",
                      fontSize: ScreenUtil.getInstance().setSp(40),
                      letterSpacing: .6,
                      fontWeight: FontWeight.bold)),
              Text("**************",
                  style: TextStyle(
                      fontFamily: "",
                      fontSize: ScreenUtil.getInstance().setSp(35),
                      letterSpacing: .6,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(220),
              ),
              Form(
                  key: _formKey,
                  child: FormCard(
                    validation: 'required',
                    saveemail: (value) => _email = value,
                    savepwd: (value) => _password = value,
                  )),
              SizedBox(height: ScreenUtil.getInstance().setHeight(70)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 12.0,
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(330),
                      height: ScreenUtil.getInstance().setHeight(100),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: const FractionalOffset(0.1, 2.0),
                            end: const FractionalOffset(-0.2, 0.2),
                            colors: [
                              Colors.blueGrey[800],
                              Colors.blueGrey,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: validateAndSubmit,
                          child: Center(
                            child: Text("เข้าสู่ระบบ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "เข้าสู่ระบบแบบไม่ระบุตัวตน ? ",
                    style: TextStyle(
                        fontFamily: "",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blueGrey[900]),
                  ),
                  InkWell(
                    onTap: signInAnonymously,
                    child: Text("เช้าชม",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: "",
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
