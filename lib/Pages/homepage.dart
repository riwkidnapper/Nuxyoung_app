import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/layout/article.dart';
import 'package:nuxyoung/Pages/layout/proflieDoc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import './pop_up_item/color_loader.dart';
import 'layout/header.dart';

// import 'dart:math';
// import 'pop_up_item/color_loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FirebaseUser currentUser;

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();

    firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      await Firestore?.instance
          ?.collection("users")
          ?.where('uid', isEqualTo: currentUser.uid)
          ?.getDocuments()
          ?.then((docs) {
        Firestore?.instance
            ?.document('/users/${docs.documents[0].documentID}')
            ?.updateData({
          'token': token,
        })?.then((onValue) {
          print("Token : $token");
        })?.catchError((e) {
          print(e);
        });
      })?.catchError((e) {
        print(e);
      });
    });
  }

  void _loadCurrentUser() {
    FirebaseAuth?.instance?.currentUser()?.then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
          ),
        ),
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            backgroundColor: (Colors.blueGrey),
          ),
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
          onLoading: _onLoading,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Header(),
              Doctorproflie(),
              Article(),
            ],
          ),
        ),
      ],
    );
  }
}
