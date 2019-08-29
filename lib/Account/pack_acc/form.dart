import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FormCard extends StatelessWidget {
  String validation;
 final saveemail;
 final savepwd;
  FormCard({this.saveemail,this.savepwd,this.validation});


   //save;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(525),
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
              decoration: InputDecoration(
                  hintText: "อีเมล",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                obscureText: false,
                validator: (value)=>
                value.isEmpty ? validation: null,
                onSaved:saveemail
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("รหัสผ่าน",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil.getInstance().setSp(26)),),
            TextFormField(

              decoration: InputDecoration(
                  hintText: "รหัสผ่าน",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              obscureText: true,
              validator: (value)=>
              value.isEmpty ? validation: null,
              onSaved: savepwd

            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "ลืมบัญชีผู้ใช้ใช่หรือไม่?",
                  style: TextStyle(
                      color: Colors.lightBlue[800],
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil.getInstance().setSp(28)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
