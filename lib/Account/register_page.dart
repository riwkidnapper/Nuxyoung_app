import 'package:flutter/material.dart';
import 'package:nuxyong_app/Tebbar/home_bottombar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuxyong_app/Account/login_page.dart';
import 'package:nuxyong_app/Account/pack_acc/form.dart';

class Resgister_page extends StatefulWidget {
  @override
  _Resgister_pageState createState() => _Resgister_pageState();
}

class _Resgister_pageState extends State<Resgister_page> {
  String _email;
  String _password;
  final _formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

/*  LoginUser(){
//    if (checkFields()){
////      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
////          .then((user){
////        print("signed in as ${user.uid}");
////        Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
////      }).catchError((e){
////        print(e);
////      });
////    }
  }*/

  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 200),
                child: Container(
                    height: 250,
                    child: Image.asset("assets/images/regislogo.png")),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/hospital.gif"),
                        fit: BoxFit.fitWidth)),
              )
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Welcome to Login",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold)),
                      Text("******************",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(275),
                  ),
                  Form(
                      key: _formKey,
                      child: FormCard(
                        validation: 'required',
                        saveemail: (value) => _email = value,
                        savepwd: (value) => _password = value,
                      )),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Remember me",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      InkWell(
                        onTap: doLogin,
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
                              onTap: doLogin,
                              child: Center(
                                child: Text("เข้าสู่ระบบ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
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
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Social Login",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                    ],
                  ),*/
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "ยังไม่มีบัญชีใช้งาน? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()));
                        },
                        child: Text("ลงทะเบียน",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      ),
                      Text(
                        " หรือ ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          doLogin();
                        },
                        child: Text("เช้าชม",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /*Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.blueGrey,
            //decoration: BoxDecoration(
            //image: DecorationImage(
            //fit: BoxFit.cover,
            //  image: AssetImage('assets/images/welcome.png')
            //),
            //),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) return 'กรุณาระบุชื่อผู้ใช้งาน';
                    },
                    controller: ctrlUsername,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 18.0),
                        prefixIcon: Icon(Icons.person_add),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) return 'กรุณาระบุรหัสผ่าน';
                    },
                    controller: ctrlPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 18.0),
                        prefixIcon: Icon(Icons.vpn_key),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        border: InputBorder.none),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => doLogin(),
                        color: Colors.lightGreen,
                        child: Text(
                          'Login to app',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.teal,
                        child: Text(
                          '   Register   ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Help Me Please?',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white30,
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }*/

  doLogin() {
//    if (_formKey.currentState.validate()) {
//      String username = ctrlUsername.text;
//      String password = ctrlPassword.text;
//
//      if (username == 'admin' && password == 'admin') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          user: null,
        ),
      ),
    );
    //}
    //}
  }
}
