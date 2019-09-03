import 'package:flutter/material.dart';

import 'package:nuxyong_app/Pages/layout/article.dart';
import 'package:nuxyong_app/Pages/layout/proflieDoc.dart';
import 'package:nuxyong_app/pull_to_refresh.dart';
import './pop_up_item/color_loader.dart';
import 'layout/header.dart';

// import 'dart:math';
// import 'pop_up_item/color_loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool selected = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/homewall.png'),
              colorFilter: new ColorFilter.mode(
                  Colors.grey[50].withOpacity(0.3), BlendMode.dstATop),
            ),
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