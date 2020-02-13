import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuxyoung/Pages/doctor_page/extension/date_picker.dart';
import 'package:nuxyoung/provider/tabbar.dart';
import 'package:video_player/video_player.dart';

class ListPaitient extends StatefulWidget {
  final String paitientName;
  final timetoheal;
  final symptoms;
  final video;
  final address;
  final amphures;
  final district;
  final provinces;
  final zipcode;
  final treatment;
  final gender;
  final idnumber;
  final diagnosis;
  final birthday;
  final reason;
  final uid;

  const ListPaitient(
      {Key key,
      @required this.paitientName,
      @required this.timetoheal,
      @required this.symptoms,
      @required this.video,
      @required this.address,
      @required this.amphures,
      @required this.district,
      @required this.provinces,
      @required this.zipcode,
      @required this.treatment,
      @required this.gender,
      @required this.idnumber,
      @required this.diagnosis,
      @required this.birthday,
      @required this.reason,
      @required this.uid})
      : super(key: key);
  @override
  _ListPaitientState createState() => _ListPaitientState(
        paitientName,
        address,
        amphures,
        birthday,
        diagnosis,
        district,
        gender,
        idnumber,
        reason,
        provinces,
        symptoms,
        timetoheal,
        treatment,
        video,
        zipcode,
        uid,
      );
}

class _ListPaitientState extends State<ListPaitient> {
  DateTime selectedDate;
  TimeOfDay _time;
  final String paitientName;
  final timetoheal;
  final symptoms;
  final video;
  final address;
  final amphures;
  final district;
  final provinces;
  final zipcode;
  final treatment;
  final gender;
  final idnumber;
  final diagnosis;
  final birthday;
  final reason;
  final uid;
  bool load = true;
   ChewieController _chewieController;
  VideoPlayerController _videoPlayerController1;
  _ListPaitientState(
      this.paitientName,
      this.address,
      this.amphures,
      this.birthday,
      this.diagnosis,
      this.district,
      this.gender,
      this.idnumber,
      this.provinces,
      this.reason,
      this.symptoms,
      this.timetoheal,
      this.treatment,
      this.video,
      this.zipcode,
      this.uid);
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(video);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 4,
      autoPlay: true,
      looping: false,
    );
  }

  Future<void> postpone() async {
    var d;
    final df = DateFormat('yyyy-MM-dd');
    final tf = DateFormat('hh:mm');
    var dateAppointment;
    var timeAppointment;
    final DateTime date = await showCustomDatePicker(
      context: context,
      locale: Locale("th", "TH"),
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.blueGrey[700],
            accentColor: Colors.blueGrey[400],
          ),
          child: child,
        );
      },
    );
    if (date != null) {
      final TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.blueGrey[700],
              accentColor: Colors.blueGrey[400],
            ),
            child: child,
          );
        },
      );
      if (date != null && time != null) {
        setState(() {
          _time = time;
          selectedDate = date;
        });
      } else {
        _time = null;
        selectedDate = null;
      }
    }
    d = DateTime(date.year, date.month, date.day, _time.hour, _time.minute);
    dateAppointment = df.format(d);
    timeAppointment = tf.format(d);
    await Firestore?.instance
        ?.collection("appointment")
        ?.where('ชื่อคนไข้', isEqualTo: paitientName)
        ?.where('uid', isEqualTo: uid)
        ?.getDocuments()
        ?.then((docs) {
      Firestore?.instance
          ?.document('/appointment/${docs.documents[0].documentID}')
          ?.updateData({
        'วันเดือนปีที่นัดหมาย': dateAppointment,
        'เวลาที่นัดหมาย': timeAppointment
      })?.then((onValue) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListPaitient(
              treatment: treatment,
              reason: reason,
              symptoms: symptoms,
              timetoheal: timetoheal,
              video: video,
              zipcode: zipcode,
              address: address,
              amphures: amphures,
              birthday: birthday,
              diagnosis: diagnosis,
              district: district,
              gender: gender,
              idnumber: idnumber,
              provinces: provinces,
              paitientName: paitientName,
              uid: uid,
            ),
          ),
        );
      })?.catchError((e) {
        print(e);
      });
    })?.catchError((e) {
      print(e);
    });
  }

  void deleteAddpoint() async {
    {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 0.0, bottom: 10.0),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  height: 150.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.cancel,
                          size: 60.0,
                          color: Colors.redAccent,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      ),
                      Text(
                        'ยกเลิกการนัดหมาย',
                        style: TextStyle(
                            color: THEME,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'คุณต้องการที่จะยกเลิกการนัดหมายครั้งนี้ใช่ไหม ?',
                        style: TextStyle(color: THEME, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
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
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
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
                ),
              ],
            );
          })) {
        case 0:
          break;
        case 1:
          Firestore.instance
              ?.collection("appointment")
              ?.where('uid', isEqualTo: uid)
              ?.getDocuments()
              ?.then((docs) {
            Firestore.instance
                ?.document('/appointment/${docs.documents[0].documentID}')
                ?.delete()
                ?.then((onValue) {
              setState(() {
                load = false;
              });
              Firestore.instance.collection("notifications").add({
                "uid": "IL1UgTTtYFXmshy1NbBQw7GvfXz2",
                "title": "การยกเลิกการนัดหมาย",
                "body": "แพทย์ได้ทำการทำการยกเลิกการนัดหมายแล้ว"
              });
            });
          });
          //sendNotification();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Timestamp bd = birthday;
    var birthdays = bd.toDate();
    final hbd = new DateFormat('dd MMMM yyyy', "th_TH");
    String dateOfBirthbay = hbd.format(birthdays);
    final date = DateTime(
        DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
    num nowYear = date.year;
    num nowMonth = date.month;
    num nowDay = date.day;
    num birthdayOfyear = birthdays.year;
    num age;

    num birthdaymoth = birthdays.month;
    num birthdayOfMonth;

    num birthdaydate = birthdays.day;
    num leapbirthday = birthdayOfyear - 543;
    num birthdayOfday;
    num leap;
    if ((leapbirthday % 4 == 0) &&
        ((leapbirthday % 100 != 0) || (leapbirthday % 400 == 0))) {
      leap = 29;
    } else {
      leap = 28;
    }

    var month = [31, leap, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (birthdaydate > nowDay) {
      nowMonth = nowMonth - 1;
      nowDay = nowDay + month[birthdaymoth - 1];
    }
    if (birthdaymoth > nowMonth) {
      nowYear = nowYear - 1;
      nowMonth = nowMonth + 12;
    }
    birthdayOfday = nowDay - birthdaydate;
    birthdayOfMonth = nowMonth - birthdaymoth;
    age = nowYear - birthdayOfyear;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ประวัติของ $paitientName",
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        margin: EdgeInsets.all(11.0),
        padding: EdgeInsets.all(15.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  paitientName != null ? "ชื่อผู้ป่วย :: " + paitientName : '',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  idnumber != null ? "รหัสประชาชน :: " + idnumber : '',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  idnumber != null
                      ? "วัน เดือน ปี เกิด :: " + dateOfBirthbay
                      : '',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  idnumber != null
                      ? "อายุ :: " +
                          age.toString() +
                          " ปี " +
                          birthdayOfMonth.toString() +
                          " เดือน " +
                          birthdayOfday.toString() +
                          " วัน"
                      : '',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(idnumber != null ? "เพศ :: " + gender : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    idnumber != null
                        ? "ที่อยู่ :: " + address + " ตำบล :: " + district
                        : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(idnumber != null ? "อำเภอ :: " + amphures : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(idnumber != null ? "จังหวัด :: " + reason : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(idnumber != null ? "รหัสไปรษณีย์ :: " + zipcode : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    idnumber != null
                        ? "วันที่เข้ารับการรักษา :: " + timetoheal.toString()
                        : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    idnumber != null ? "เหตุผลในการส่งต่อ :: " + provinces : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    symptoms != null
                        ? "ลักษณะอาการเบื้อต้น :: " + symptoms
                        : "ลักษณะอาการเบื้อต้น :: ",
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    idnumber != null
                        ? "ประวัติการเข้ารับการรักษา :: " + treatment
                        : '',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    idnumber != null
                        ? "การวินิจฉัยเบื้องต้น :: " + diagnosis
                        : '',
                    style: TextStyle(fontSize: 18.0)),
                StreamBuilder<QuerySnapshot>(
                  stream: load
                      ? Firestore.instance
                          ?.collection("appointment")
                          ?.orderBy('วันเดือนปีที่นัดหมาย', descending: true)
                          ?.orderBy('เวลาที่นัดหมาย', descending: true)
                          ?.where('uid', isEqualTo: uid)
                          ?.snapshots()
                      : null,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      if (snapshot.data.documents.length == 0) {
                        return Container();
                      } else {
                        var data = snapshot?.data?.documents[0];
                        var dateOfApppoint = snapshot?.data?.documents[0]
                            ['วันเดือนปีที่นัดหมาย'];
                        var dateApp = DateTime(
                            DateTime.parse(dateOfApppoint).year + 543,
                            DateTime.parse(dateOfApppoint).month,
                            DateTime.parse(dateOfApppoint).day);
                        var dateAppoint =
                            DateFormat("dd MMMM yyyy", "th_TH").format(dateApp);
                        var timeOfAddpoint =
                            snapshot?.data?.documents[0]['เวลาที่นัดหมาย'];
                        if (load == true) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Center(
                                child: Text("การนัดหมาย",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.blueGrey[400],
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  idnumber != null
                                      ? "วัน เดือน ปีในการนัดหมาย :: \n" +
                                          dateAppoint
                                      : '',
                                  style: TextStyle(fontSize: 18.0)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  idnumber != null
                                      ? "เวลาในการนัดหมาย :: " +
                                          timeOfAddpoint +
                                          " นาฬิกา"
                                      : '',
                                  style: TextStyle(fontSize: 18.0)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  idnumber != null
                                      ? "แพทย์ที่ทำการนัดหมาย :: \n" +
                                          data['ชื่อแพทย์ผู้รักษา']
                                      : '',
                                  style: TextStyle(fontSize: 18.0)),
                              SizedBox(
                                height: 25,
                              ),
                              ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                child: RaisedButton.icon(
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Colors.blueGrey[700],
                                  ),
                                  color: Colors.blueGrey[300],
                                  label: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "เลื่อนการนัดหมาย",
                                      style: TextStyle(
                                        color: Colors.blueGrey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    postpone().then((onValue) {
                                      Firestore.instance
                                          .collection("notifications")
                                          .add({
                                        "uid": "IL1UgTTtYFXmshy1NbBQw7GvfXz2",
                                        "title": "การเลื่อนนัดหมาย",
                                        "body":
                                            "แพทย์ได้ทำการเลื่อนเวลานัดหมายใหม่เป็น\tวันพฤหัสบดีที่ 20 ธันวาคม 2562 เวลา 11.00 นาฬิกา"
                                      });
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                child: RaisedButton.icon(
                                  icon: Icon(
                                    Icons.do_not_disturb_alt,
                                    color: Colors.blueGrey[700],
                                  ),
                                  color: Colors.blueGrey[300],
                                  label: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "ยกเลิกนัดหมาย",
                                      style: TextStyle(
                                        color: Colors.blueGrey[800],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    deleteAddpoint();
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
