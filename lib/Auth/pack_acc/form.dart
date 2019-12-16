import 'package:flutter/material.dart';

import 'package:nuxyoung/package/screenutil/flutter_screenutil.dart';

class FormCard extends StatefulWidget {
  final String validation;
  final saveemail;
  final savepwd;

  FormCard({this.saveemail, this.savepwd, this.validation});

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  bool isPasswordVisible = false;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email can\'t be empty';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Email format is invalid';
      } else {
        return null;
      }
    }
  }

  String pwdValidator(String value) {
    if (value.isEmpty) {
      return 'Password can\'t be empty';
    } else {
      if (value.length < 8) {
        return 'Password must be longer than 8 characters';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //resizeToAvoidBottomInset: false,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("เข้าสู่ระบบ",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(15),
                ),
                Text("อีเมล",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                    //keyboardAppearance: Brightness.dark,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "อีเมล",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    obscureText: false,
                    validator: emailValidator,
                    onSaved: widget.saveemail),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text(
                  "รหัสผ่าน",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil.getInstance().setSp(26)),
                ),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "รหัสผ่าน",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                    validator: pwdValidator,
                    onSaved: widget.savepwd),
              ],
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(55),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "หากกรณีลืมบัญชีผู้ใช้งาน",
                  style: TextStyle(
                      color: Color(0xD4D32F2F),
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil.getInstance().setSp(26)),
                ),
                Text(
                  "กรุณาติดต่อเจ้าหน้าที่ที่เกี่ยวข้อง",
                  style: TextStyle(
                      color: Color(0xD4D32F2F),
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil.getInstance().setSp(24)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
