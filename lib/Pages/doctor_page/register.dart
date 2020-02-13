part of doctorpage;

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class Register extends StatefulWidget {
  final String idnumber;
  final String name;
  const Register({
    Key key,
    @required this.idnumber,
    @required this.name,
  }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState(name, idnumber);
}

class _RegisterState extends State<Register> {
  final String name;
  final String idnumber;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore store = Firestore.instance;
  GlobalKey<ScaffoldState> _scaffoldKey;
  final FocusNode _passwordEmail = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConPassword = TextEditingController();
  TextEditingController _textEditConConfirmPassword = TextEditingController();
  String _email;
  String _password;
  String _conpassword;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool load = false;
  String errorMsg = "";

  _RegisterState(this.name, this.idnumber);
  @override
  void initState() {
    super.initState();
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    load = false;
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void onSubmit() async {
    _fbKey.currentState.save();
    if (_fbKey.currentState.validate()) {
      setState(() {
        load = true;
      });

      var data = <String, dynamic>{};
      try {
        if (_password == _conpassword) {
          await _firebaseAuth
              .createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          )
              .then((onValue) async {
            data['photoUser'] =
                "https://firebasestorage.googleapis.com/v0/b/nuxyoungapp.appspot.com/o/no-img.png?alt=media&token=38f8a945-9a15-45e3-aa3b-f907b5036a56";
            data["createAt"] = DateTime.now();
            data["email"] = _email;
            data["name"] = name;
            data["rule"] = 'user';
            data["uid"] = onValue.user.uid;
            data["devtoken"]= 10000000.toString();
            if (onValue != null && onValue.user != null)
              await store.collection("users").add(data).then((ref) async {
                await store
                    .collection("profliePaitient")
                    .where('ชื่อคนไข้', isEqualTo: name)
                    .getDocuments()
                    .then((docs) {
                  Firestore.instance
                      .document(
                          '/profliePaitient/${docs.documents[0].documentID}')
                      .updateData({
                    'uid': onValue.user.uid,
                  }).then((val) {
                    setState(() {
                      load = false;
                    });
                    if (ref != null && ref.documentID.isNotEmpty) {
                      FirebaseAuth.instance.signOut();
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        backgroundColor: Colors.lightGreenAccent[700],
                        content: Text(
                          'Success',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ));
                      Future.delayed(new Duration(milliseconds: 1000), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginpage(),
                          ),
                        );
                      });
                    }
                  }).catchError((e) {
                    print(e);
                  });
                }).catchError((e) {
                  print(e);
                });
              }).catchError((err) {
                print(err);
              });
          });
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Password and Confirm Password is not match',
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ));
        }
      } catch (error) {
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            {
              setState(() {
                load = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  'อีเมล์นี้มีถูกใช้แล้ว',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ));
            }
            break;
          case "ERROR_WEAK_PASSWORD":
            {
              setState(() {
                load = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  'พาสเวิร์ดควรมียาวมากกว่า 8\n ตัวอักษรและตัวมีตัวอักษรและตัวเลข',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ));
            }
            break;
          default:
            {
              setState(() {
                load = false;
                errorMsg = "";
              });
            }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 60.0, 10.0, 15.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _textEditConEmail,
                    focusNode: _passwordEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: _validateEmail,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 18.0),
                      icon: Icon(
                        Icons.email,
                        size: 30.0,
                      ),
                    ),
                    onSaved: (val) => _email = val,
                  ),
                  FormBuilderTextField(
                    initialValue: widget.idnumber.toString(),
                    keyboardType: TextInputType.number,
                    attribute: "identification number",
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.recent_actors,
                        size: 30.0,
                      ),
                      labelText: "เลขบัตรประจำตัวประชาชน",
                    ),
                  ),
                  TextFormField(
                    controller: _textEditConPassword,
                    focusNode: _passwordFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: _validatePassword,
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context)
                          .requestFocus(_passwordConfirmFocus);
                    },
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 18.0),
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
                      icon: Icon(
                        Icons.vpn_key,
                        size: 30.0,
                      ),
                    ),
                    onSaved: (val) => _password = val,
                  ),
                  TextFormField(
                    controller: _textEditConConfirmPassword,
                    focusNode: _passwordConfirmFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: _validateConfirmPassword,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: 18.0),
                      suffixIcon: IconButton(
                        icon: Icon(isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                      ),
                      icon: Icon(
                        Icons.vpn_key,
                        size: 30.0,
                      ),
                    ),
                    onSaved: (val) => _conpassword = val,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: load == false
                            ? RaisedButton.icon(
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
                                onPressed: () {
                                  onSubmit();
                                })
                            : (RaisedButton(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                onPressed: () {},
                                color: Colors.blueGrey[300],
                              )),
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
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                              Navigator.pop(
                                context,
                              );
                              Navigator.pop(
                                context,
                              );
                            }
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

String _validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Invalid Email';
  } else {
    return null;
  }
}

String _validatePassword(String value) {
  return value.length < 8
      ? 'พาสเวิร์ดควรมียาวมากกว่า 8\n ตัวอักษรและตัวมีตัวอักษรและตัวเลข'
      : null;
}

String _validateConfirmPassword(String value) {
  return value.length < 8
      ? 'พาสเวิร์ดควรมียาวมากกว่า 8 \nตัวอักษรและตัวมีตัวอักษรและตัวเลข'
      : null;
}
