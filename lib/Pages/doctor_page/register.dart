import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class Register extends StatelessWidget {
  final  idnumber;

  const Register({
    Key key,
    @required this.idnumber,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ลงทะเบียนผู้ใช้งาน",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 60.0, 10.0, 15.0),
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "email",
                    decoration: InputDecoration(
                      labelText: "อีเมล์",
                    ),
                  ),
                  FormBuilderTextField(
                    initialValue: idnumber,
                    keyboardType: TextInputType.number,
                    attribute: "identification number",
                    decoration: InputDecoration(
                      labelText: "เลขบัตรประจำตัวประชาชน",
                    ),
                  ),
                  FormBuilderTextField(
                    obscureText: true,
                    attribute: "password",
                    decoration: InputDecoration(
                      labelText: "รหัสผ่าน",
                    ),
                  ),
                  FormBuilderTextField(
                    obscureText: true,
                    attribute: "Cofirmpassword",
                    decoration: InputDecoration(
                      labelText: "โปรดยืนยันรหัสผ่าน",
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: RaisedButton.icon(
                            icon: Icon(
                              Icons.assignment_turned_in,
                              color: Colors.blueGrey[700],
                            ),
                            color: Colors.blueGrey[300],
                            label: Text(
                              "ลงทะเบียน",
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {}
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Register(),
                            //   ),
                            // );
                            ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: RaisedButton.icon(
                            icon: Icon(
                              Icons.rotate_right,
                              color: Colors.blueGrey[700],
                            ),
                            color: Colors.blueGrey[300],
                            label: Text(
                              "ข้ามขั้นตอนนี้",
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {}
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Register(),
                            //   ),
                            // );
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
