import 'package:firebase_auth/firebase_auth.dart';

import 'Tools/customCard.dart';
import 'Tools/custom_heading.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuxyoung/Pages/medicalBudhosp_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    // Navigator.of(context).pop();
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ChatScreen()),
    // );
  }

  FirebaseUser currentUser;
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Text('🌀', style: TextStyle(fontSize: 20)),
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.blueGrey[800],
              ),
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => MedicalBudhosp()));
              }),
        ],
        title: Text(
          'Chat\t💬',
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
          child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.failed) {
              body = Text("");
            } else {
              body = Text("");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomHeading(
                title: 'Direct Messages',
              ),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .orderBy('createAt')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        final documents = snapshot.data.documents[index];
                        if ((documents['rule'] == "doctor") ||
                            (documents['rule'] == "nurse") &&
                                (documents['rule'] != "")) {
                          if ((documents['uid'] != currentUser?.uid)) {
                            return Customcard(
                              photoUser: documents['photoUser'],
                              username: documents['name'],
                              email: documents['email'],
                              uid: documents['uid'],
                              fromUid: currentUser.uid,
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

//  child: Row(
//                           children: <Widget>[
//                             Stack(
//                               children: <Widget>[
//                                 Container(
//                                   child: CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                         'https://i.pravatar.cc/11$index'),
//                                     minRadius: 35,
//                                     backgroundColor: Colors.grey[200],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 10),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     'Jocelyn',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 5),
//                                   ),
//                                   Text(
//                                     'Hi How are you ?',
//                                     style: TextStyle(
//                                       color: Colors.blueGrey,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 5),
//                                   ),
//                                   Text(
//                                     '11:00 AM',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Column(
//                               children: <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 15),
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     size: 18,
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
