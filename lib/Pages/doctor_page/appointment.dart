import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/doctor_page/Page/Addappoint.dart';
import 'package:nuxyoung/Pages/doctor_page/Page/selectdoc.dart';

class Appointment extends StatefulWidget {
  Appointment({Key key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with TickerProviderStateMixin {
  void _click(doctorName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Addappoint(
                doctorName: doctorName,
              )),
    );
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
        physics: ScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Text(
                  'เลือกแพทย์',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .where('rule', isEqualTo: 'doctor')
                    .orderBy('createAt')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading...");
                  } else {
                    final String docnum =
                        snapshot.data.documents.length.toString();
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5.0, 2.0, 220.0, 2.0),
                              child: FittedBox(
                                child: Text(
                                  'พบแพทย์จำนวน $docnum ราย',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            final documents = snapshot.data.documents[index];
                            List<String> times =
                                List.from(documents['เวลาออกตรวจ']);
                            return GestureDetector(
                                onTap: () => _click(documents['name']),
                                child: Selectdoc(
                                    doctorName: documents['name'],
                                    photoUser: documents['photoUser'],
                                    times: times.toString()));
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ]),
      ),
    );
  }
}
