import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Aleart extends StatefulWidget {
  @override
  _AleartState createState() => _AleartState();
}

class _AleartState extends State<Aleart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: NotifyWidget());
  }
}

class NotifyWidget extends StatefulWidget {
  final List<Notify> notify;

  NotifyWidget({
    Key key,
    this.notify,
  }) : super(key: key);

  @override
  _NotifyWidgetState createState() => _NotifyWidgetState();
}

class _NotifyWidgetState extends State<NotifyWidget> {
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth?.instance?.currentUser()?.then((FirebaseUser user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: currentUser?.uid != null
                ? Firestore.instance
                    ?.collection('appointment')
                    ?.where('uid', isEqualTo: currentUser?.uid)
                    ?.snapshots()
                : null,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 350.0, 0.0, 8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                    ),
                  ),
                );
              } else {
                if (snapshot.data.documents.length == 0) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 250.0, top: 10.0, left: 10.0),
                        child: Text(
                          "การแจ้งเตือน",
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 180.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(
                                        'assets/images/bell.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 120,
                                height: 120,
                              ),
                              Text(
                                'ยังไม่มีการแจ้งเตือน',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'การแจ้งเตือนจะปรากฏที่นี่เมื่อคุณได้รับ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 250.0, top: 10.0, left: 10.0, bottom: 10.0),
                        child: Text(
                          "การแจ้งเตือน",
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                      NotifyCard(
                        title: snapshot.data.documents[0]
                                ['วันเดือนปีที่นัดหมาย'] ??
                            "",
                        body:
                            snapshot.data.documents[0]['เวลาที่นัดหมาย'] ?? "",
                      ),
                    ],
                  );
                }
              }
            }));
  }
}

class Notify {
  //final num id;
  final String title;
  final String body;
  final DateTime date;

  Notify({
    //this.id,
    this.title,
    this.body,
    this.date,
  });

  factory Notify.fromMap(Map<String, dynamic> map) => Notify(
        //id: map["id"],
        title: map["วันเดือนปีที่นัดหมาย"],
        body: map["เวลาที่นัดหมาย"],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        //"id": this.id,
        "title": this.title,
        "body": this.body,
        "date": this.date,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Notify &&
          runtimeType == other.runtimeType &&
          //id == other.id &&
          title == other.title &&
          body == other.body &&
          date == other.date;

  @override
  int get hashCode => (
      //id.hashCode ^
      title.hashCode ^ body.hashCode ^ date.hashCode);
}

class NotifyCard extends StatelessWidget {
  final String title;
  final String body;

  NotifyCard({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            this.title ?? "",
          ),
          subtitle: Text(
            this.body ?? "",
          ),
        ),
      ),
    );
  }
}
