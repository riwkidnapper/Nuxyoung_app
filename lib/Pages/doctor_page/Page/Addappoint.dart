import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nuxyoung/package/picker.dart';

bool clear = false;

class Addappoint extends StatefulWidget {
  final String doctorName;
  Addappoint({Key key, @required this.doctorName}) : super(key: key);

  @override
  _AddappointState createState() => _AddappointState(doctorName);
}

class _AddappointState extends State<Addappoint> {
  FirebaseUser user;
  final Firestore store = Firestore.instance;
  final t = new DateFormat('HH:mm');
  final d = new DateFormat('dd MMMM yyyy', "th_TH");
  final od = new DateFormat('yyyy-MM-dd');
  DateTime dateAppoint;
  DateTime dateAppoint2;
  DateTime timeAppoint;

  DateTime dateandtime;
  final String doctorName;
  final GlobalKey<FormState> _fbKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _hisController;
  TextEditingController _simController;
  var selectedCurrency, selectedType;
  String timeAppointment;
  String dateAppointment;
  String datead;
  var uid;
  var admissionhistory;
  var symptoms;
  var diagnosis;
  String cloudUID;
  _AddappointState(this.doctorName);
  @override
  void initState() {
    super.initState();
    dateAppoint = DateTime(
        DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
    dateAppoint2 =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _nameController = TextEditingController();
    _hisController = TextEditingController();
    _simController = TextEditingController();
    timeAppointment = t.format(DateTime.now());
    dateAppointment = d.format(dateAppoint);
    datead = od.format(dateAppoint2);
  }

  var items = [
    'วันพุธ, 9.00 น. - 12.00 น.',
    'วันศุกร์, 9.00 น. - 12.00 น.',
  ];

  void changState() {
    Navigator.pop(
      context,
    );
  }

  void setstate() {
    setState(() {
      clear = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "การนัดหมาย",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            //padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'เลือกแพทย์',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => changState(),
                      icon: Icon(Icons.clear),
                    ),
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    hintText: doctorName,
                    hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'ระบุวันที่',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                DatePicker(
                  currentDate: dateAppoint,
                  onSelect: (DateTime date) {
                    var selectday =
                        DateTime(date.year - 543, date.month, date.day);
                    setState(() {
                      dateAppoint = date;
                      dateAppointment = d.format(date);
                      datead = od.format(selectday);
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'เลือกเวลา',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TimePicker(
                  currentTime: timeAppoint,
                  onSelect: (DateTime time) {
                    setState(() {
                      timeAppoint = time;
                      timeAppointment = t.format(timeAppoint);
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      ?.collection('profliePaitient')
                      ?.orderBy('ชื่อคนไข้')
                      ?.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap['ชื่อคนไข้'],
                              style: TextStyle(fontSize: 18.0),
                            ),
                            value: "${snap['ชื่อคนไข้']}",
                          ),
                        );
                      }
                      return Row(
                        children: <Widget>[
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                              print(selectedCurrency);
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              'ชื่อ - นามสกุลคนไข้\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blueGrey[700],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                StreamBuilder(
                    stream: store
                        .collection('profliePaitient')
                        .where('ชื่อคนไข้', isEqualTo: selectedCurrency)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                          ),
                        );
                      }
                      admissionhistory = snapshot?.data?.documents[0]
                          ['ประวัติการเข้ารับการรักษา'];
                      symptoms =
                          snapshot?.data?.documents[0]['ลักษณะอาการเบื้องต้น'];
                      diagnosis =
                          snapshot?.data?.documents[0]['การวินิจฉัยเบื้องต้น'];
                      uid = snapshot?.data?.documents[0]['uid'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "ประวัติการเข้ารับการรักษา",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          selectedCurrency != null
                              ? Text(
                                  ' : $admissionhistory',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : TextFormField(
                                  controller: _hisController,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 18),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'อาการเบื้องต้น',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          selectedCurrency != null
                              ? Text(
                                  symptoms != null
                                      ? ' : $symptoms'
                                      : ' ⚠ ยังไม่ได้ระบุอาการเบื้องต้น !',
                                  style: symptoms != null
                                      ? TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        )
                                      : TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blueGrey,
                                        ),
                                )
                              : TextFormField(
                                  controller: _simController,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 18),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'การวินิจฉัยเบื้องต้น',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          selectedCurrency != null
                              ? Text(
                                  ' : $diagnosis',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : TextFormField(
                                  controller: _simController,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 18),
                                ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    }),
                Center(
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.assignment_turned_in,
                      color: Colors.blueGrey[700],
                    ),
                    color: Colors.blueGrey[300],
                    label: Text(
                      "ยืนยัน",
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      _fbKey?.currentState?.save();
                      if (_fbKey?.currentState?.validate() ?? true) {
                        var paitientName = selectedCurrency;

                        var datas = {
                          "ชื่อแพทย์ผู้รักษา": doctorName,
                          "วันเดือนปีที่นัดหมาย": datead,
                          "เวลาที่นัดหมาย": timeAppointment,
                          "ชื่อคนไข้": paitientName,
                          "ประวัติการเวลารับการรักษา": admissionhistory,
                          "อาการเบื้องต้น": symptoms,
                          "การวินิจฉัยเบื้องต้น": diagnosis,
                          'uid': uid
                        };
                        await store
                            .collection("appointment")
                            .add(datas)
                            .then((value) {
                          Firestore.instance.collection("notifications").add({
                            "uid": "IL1UgTTtYFXmshy1NbBQw7GvfXz2",
                            "title": "การนัดหมาย",
                            "body":
                                "มีการนัดตรวจวันพฤหัสบดีที่ 20 ธันวาคม 2562 เวลา 10.30 นาฬิกา \nโดย นพ:ตนุพล วิรุฬหการุญ"
                          }).then((value) {
                            print(value.documentID);
                            Navigator.pop(
                              context,
                            );
                            Navigator.pop(
                              context,
                            );
                            Navigator.pop(
                              context,
                            );
                          });
                        }).catchError((err) {
                          print(err);
                        });
                      } else {
                        setState(() {
                          print("validation failed");
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
