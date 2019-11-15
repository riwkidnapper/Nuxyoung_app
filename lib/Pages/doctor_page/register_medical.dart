import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:nuxyoung/package/image_picker.dart';
import 'extension/timedialog.dart';
// import 'package:path/path.dart';

class MedicalRegister extends StatefulWidget {
  MedicalRegister({Key key}) : super(key: key);

  @override
  _MedicalRegisterState createState() => _MedicalRegisterState();
}

class _MedicalRegisterState extends State<MedicalRegister> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool checkboxValueCity = false;
  final Firestore store = Firestore.instance;

  static var _keyValidationForm = GlobalKey<FormState>();
  final FocusNode _passwordEmail = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();
  TextEditingController _textEditConName = TextEditingController();
  TextEditingController _textEditConEmail = TextEditingController();
  TextEditingController _textEditConPassword = TextEditingController();
  TextEditingController _textEditConConfirmPassword = TextEditingController();
  String _uploadedFileURL;
  bool isPasswordVisible = false;
  bool load = false;
  bool isConfirmPasswordVisible = false;
  String _emaildoc;
  String _password;
  String _conpassword;
  String namedoc;
  List<String> dateList = [
    "วันจันทร์, 9.00 น. - 12.00 น.",
    "วันอังคาร, 9.00 น. - 12.00 น.",
    "วันพุธ, 9.00 น. - 12.00 น.",
    "วันพฤหัส, 9.00 น. - 12.00 น.",
    "วันศุกร์, 9.00 น. - 12.00 น.",
    "วันเสาร์, 9.00 น. - 12.00 น.",
    "วันอาทิตย์, 9.00 น. - 12.00 น.",
  ];

  String errorMsg = "";
  List<String> list = [];
  String rule = 'แพทย์';
  List<String> selecteddateList = List();
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  _showdateDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("ช่วงเวลา"),
            content: MultiSelectChip(
              dateList,
              listNow: selecteddateList,
              onSelectionChanged: (selectedList) {
                if (selectedList == []) {
                  selecteddateList = [];
                } else {
                  setState(() {
                    selecteddateList = selectedList;
                    print(selecteddateList);
                  });
                }
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: FlatButton(
                  child: Text(
                    "ยืนยัน",
                    style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    load = false;
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void onSubmit() async {
    setState(() {
      load = true;
    });
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('Userimage/$_emaildoc');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileURL) async {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
    _keyValidationForm.currentState.save();
    if (_keyValidationForm.currentState.validate()) {
      if (rule == 'แพทย์' || rule == 'doctor') {
        rule = 'doctor';
      } else {
        rule = 'nurse';
      }
      var data = <String, dynamic>{};
      try {
        if (_password == _conpassword) {
          await _firebaseAuth
              .createUserWithEmailAndPassword(
            email: _emaildoc,
            password: _password,
          )
              .then((onValue) async {
            if (rule == 'doctor') {
              data['photoUser'] =
                  "https://firebasestorage.googleapis.com/v0/b/nuxyoungapp.appspot.com/o/no-img.png?alt=media&token=38f8a945-9a15-45e3-aa3b-f907b5036a56";
              data["createAt"] = DateTime.now();
              data["email"] = _emaildoc;
              data["name"] = namedoc;
              data["rule"] = rule;
              data["เวลาออกตรวจ"] = selecteddateList;
              data["uid"] = onValue.user.uid;
              data["photoUser"] = _uploadedFileURL;
            } else {
              data['photoUser'] =
                  "https://firebasestorage.googleapis.com/v0/b/nuxyoungapp.appspot.com/o/no-img.png?alt=media&token=38f8a945-9a15-45e3-aa3b-f907b5036a56";
              data["createAt"] = DateTime.now();
              data["email"] = _emaildoc;
              data["name"] = namedoc;
              data["rule"] = rule;
              data["uid"] = onValue.user.uid;
              data["photoUser"] = _uploadedFileURL;
            }
            if (onValue != null && onValue.user != null)
              await store.collection("users").add(data).then((ref) {
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

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "ลงทะเบียนใช้งานสำหรับบุคลากร",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(11.0),
          padding: EdgeInsets.all(15.0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 1), blurRadius: 1)
            ],
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: _keyValidationForm,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 120.0,
                                  height: 120.0,
                                  child: (_image != null)
                                      ? Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.network(
                                          "https://firebasestorage.googleapis.com/v0/b/nuxyoungapp.appspot.com/o/no-img.png?alt=media&token=38f8a945-9a15-45e3-aa3b-f907b5036a56",
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 30.0,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "อัพโหลดรูปภาพโปรไฟล์",
                      style: TextStyle(fontSize: 16.0),
                    ),
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
                      onSaved: (val) => _emaildoc = val,
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
                    TextFormField(
                      controller: _textEditConName,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: _validateUserName,
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(_passwordEmail);
                      },
                      decoration: InputDecoration(
                          labelText: 'ชื่อ นามสกุล',
                          labelStyle: TextStyle(fontSize: 18.0),
                          icon: Icon(
                            Icons.perm_identity,
                            size: 30.0,
                          )),
                      onSaved: (val) => namedoc = val,
                    ),
                    FormBuilderDropdown(
                        attribute: "rule",
                        decoration: InputDecoration(
                            labelText: "เลือกประเภทผู้ใช้งาน",
                            labelStyle: TextStyle(fontSize: 18.0),
                            icon: Icon(
                              Icons.library_add,
                              size: 30.0,
                            )),
                        initialValue: 'แพทย์',
                        items: [
                          'แพทย์',
                          'พยาบาล',
                          'บุคลากร',
                        ].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            rule = value;
                            print(rule);
                          });
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    (rule == 'แพทย์' || rule == 'doctor')
                        ? Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 29.0, right: 8.0),
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "เลือกเวลาที่ออกตรวจ",
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          Text(
                                            "เว้นว่างไว้หากต้องการข้ามขั้นตอนนี้",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.redAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 26.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      _showdateDialog();
                                    },
                                  )
                                ],
                              ),
                              Text(
                                selecteddateList.join(" \n "),
                                style: TextStyle(fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: RaisedButton(
                          child: (load == false)
                              ? const Text(
                                  'ลงทะเบียน',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                  ),
                                )
                              : const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                          onPressed: () {
                            onSubmit();
                          },
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateUserName(String value) {
    return value.trim().isEmpty ? "ชื่อ นามสกุลไม่ควรเว้นว่าง" : null;
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
