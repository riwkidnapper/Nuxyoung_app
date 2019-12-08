import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuxyoung/package/chewie/src/chewie_player.dart';
import 'package:nuxyoung/package/video_player.dart';

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
      @required this.reason})
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
      zipcode);
}

class _ListPaitientState extends State<ListPaitient> {
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
      this.zipcode);
  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(video);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
    );
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
    num birthdayOfyear = birthdays.year;
    num age = nowYear - birthdayOfyear;
    num nowMonth = date.month;
    num birthdaymoth = birthdays.month;
    num birthdayOfMonth;
    num nowDay = date.day;
    num birthdaydate = birthdays.day;
    num birthdayOfday;
    if (date.compareTo(birthdays) >= 0) {
      if (nowYear > birthdayOfyear) {
        if (nowMonth > birthdaymoth) {
          birthdayOfMonth = nowMonth - birthdaymoth;
          if (birthdaydate > nowDay) {
            birthdayOfMonth--;
            if (birthdaymoth == 1 ||
                birthdaymoth == 3 ||
                birthdaymoth == 5 ||
                birthdaymoth == 7 ||
                birthdaymoth == 8 ||
                birthdaymoth == 10 ||
                birthdaymoth == 12) {
              birthdayOfday = (31 - birthdaydate) + nowDay;
            } else if (birthdaymoth == 4 ||
                birthdaymoth == 6 ||
                birthdaymoth == 9 ||
                birthdaymoth == 11) {
              birthdayOfday = (30 - birthdaydate) + nowDay;
            } else {
              if ((birthdayOfyear - 543) % 4 == 0) {
                if (birthdayOfyear % 100 == 0) {
                  if (birthdayOfyear % 400 == 0) {
                    birthdayOfday = (29 - birthdaydate) + nowDay;
                  } else {
                    birthdayOfday = (28 - birthdaydate) + nowDay;
                  }
                } else {
                  birthdayOfday = (29 - birthdaydate) + nowDay;
                }
              } else {
                birthdayOfday = (28 - birthdaydate) + nowDay;
              }
            }
          } else if (birthdaydate == nowDay) {
            birthdayOfday = birthdaydate - nowDay;
          } else {
            birthdayOfMonth = nowMonth - birthdaymoth;
            birthdayOfday = nowDay - birthdaydate;
          }
        }
        if (nowMonth == birthdaymoth) {
          if (birthdaydate > nowDay) {
            age--;
            birthdayOfMonth = nowMonth;
            if (birthdaymoth == 1 ||
                birthdaymoth == 3 ||
                birthdaymoth == 5 ||
                birthdaymoth == 7 ||
                birthdaymoth == 8 ||
                birthdaymoth == 10 ||
                birthdaymoth == 12) {
              birthdayOfday = (31 - birthdaydate) + nowDay;
            } else if (birthdaymoth == 4 ||
                birthdaymoth == 6 ||
                birthdaymoth == 9 ||
                birthdaymoth == 11) {
              birthdayOfday = (30 - birthdaydate) + nowDay;
            } else {
              if ((birthdayOfyear - 543) % 4 == 0) {
                if (birthdayOfyear % 100 == 0) {
                  if (birthdayOfyear % 400 == 0) {
                    birthdayOfday = (29 - birthdaydate) + nowDay;
                  } else {
                    birthdayOfday = (28 - birthdaydate) + nowDay;
                  }
                } else {
                  birthdayOfday = (29 - birthdaydate) + nowDay;
                }
              } else {
                birthdayOfday = (28 - birthdaydate) + nowDay;
              }
            }
          } else if (birthdaydate == nowDay) {
            birthdayOfMonth = nowMonth - birthdaymoth;
            birthdayOfday = birthdaydate - nowDay;
          } else {
            birthdayOfMonth = nowMonth - birthdaymoth;
            birthdayOfday = nowDay - birthdaydate;
          }
        } else {
          birthdayOfMonth = nowMonth;
          if (birthdaydate > nowDay) {
            birthdayOfMonth = nowMonth - birthdaymoth;
            birthdayOfMonth--;
            if (birthdaymoth == 1 ||
                birthdaymoth == 3 ||
                birthdaymoth == 5 ||
                birthdaymoth == 7 ||
                birthdaymoth == 8 ||
                birthdaymoth == 10 ||
                birthdaymoth == 12) {
              birthdayOfday = (31 - birthdaydate) + nowDay;
            } else if (birthdaymoth == 4 ||
                birthdaymoth == 6 ||
                birthdaymoth == 9 ||
                birthdaymoth == 11) {
              birthdayOfday = (30 - birthdaydate) + nowDay;
            } else {
              if ((birthdayOfyear - 543) % 4 == 0) {
                if (birthdayOfyear % 100 == 0) {
                  if (birthdayOfyear % 400 == 0) {
                    birthdayOfday = (29 - birthdaydate) + nowDay;
                  } else {
                    birthdayOfday = (28 - birthdaydate) + nowDay;
                  }
                } else {
                  birthdayOfday = (29 - birthdaydate) + nowDay;
                }
              } else {
                birthdayOfday = (28 - birthdaydate) + nowDay;
              }
            }
          } else if (birthdaydate == nowDay) {
            age--;
            birthdayOfMonth = nowMonth;
            birthdayOfday = birthdaydate - nowDay;
          } else {
            birthdayOfMonth = nowMonth - birthdaymoth;
            birthdayOfday = nowDay - birthdaydate;
          }
        }
      } else {
        if (nowMonth > birthdaymoth) {
          birthdayOfMonth = nowMonth - birthdaymoth;
          if (nowDay >= birthdaydate) {
            birthdayOfday = nowDay - birthdaydate;
          } else {
            if (birthdaydate > nowDay) {
              birthdayOfMonth--;
              if (birthdaymoth == 1 ||
                  birthdaymoth == 3 ||
                  birthdaymoth == 5 ||
                  birthdaymoth == 7 ||
                  birthdaymoth == 8 ||
                  birthdaymoth == 10 ||
                  birthdaymoth == 12) {
                birthdayOfday = (31 - birthdaydate) + nowDay;
              } else if (birthdaymoth == 4 ||
                  birthdaymoth == 6 ||
                  birthdaymoth == 9 ||
                  birthdaymoth == 11) {
                birthdayOfday = (30 - birthdaydate) + nowDay;
              } else {
                if ((birthdayOfyear - 543) % 4 == 0) {
                  if (birthdayOfyear % 100 == 0) {
                    if (birthdayOfyear % 400 == 0) {
                      birthdayOfday = (29 - birthdaydate) + nowDay;
                    } else {
                      birthdayOfday = (28 - birthdaydate) + nowDay;
                    }
                  } else {
                    birthdayOfday = (29 - birthdaydate) + nowDay;
                  }
                } else {
                  birthdayOfday = (28 - birthdaydate) + nowDay;
                }
              }
            }
          }
        } else if (nowMonth == birthdaymoth) {
          birthdayOfMonth = nowMonth - birthdaymoth;
          birthdayOfday = nowDay - birthdaydate;
        }
      }
    }
    //timelist = times.split("., ").join("\n\n");
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
                  "ชื่อผู้ป่วย :: " + paitientName,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "รหัสประชาชน :: " + idnumber,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "วัน เดือน ปี เกิด :: " + dateOfBirthbay,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "อายุ :: " +
                      age.toString() +
                      " ปี " +
                      birthdayOfMonth.toString() +
                      " เดือน " +
                      birthdayOfday.toString() +
                      " วัน",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("เพศ :: " + gender, style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("ที่อยู่ :: " + address + " ตำบล :: " + district,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("อำเภอ :: " + amphures, style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("จังหวัด :: " + reason, style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("รหัสไปรษณีย์ :: " + zipcode,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("วันที่เข้ารับการรักษา :: " + timetoheal.toString(),
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("เหตุผลในการส่งต่อ :: " + provinces,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("ลักษณะอาการเบื้องต้น :: " + symptoms,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("ประวัติการเข้ารับการรักษา :: " + treatment,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
                Text("การวินิจฉัยเบื้องต้น :: " + diagnosis,
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
