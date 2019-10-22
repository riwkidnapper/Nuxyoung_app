import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
//import 'package:nuxyoung/Pages/doctor_page/calendar.dart';
//import 'package:nuxyoung/Pages/layout/proflieDoc.dart';
//import 'package:nuxyoung/pull_to_refresh.dart';



class Pagetwo extends StatefulWidget {
  PagetwoState createState() => PagetwoState();
}

class PagetwoState extends State<Pagetwo> {
  TextEditingController searchController = new TextEditingController();
  String filter;
   //List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
   //RefreshController _refreshController =
   //RefreshController(initialRefresh: false);

  //  void _onRefresh() async {
  //   monitor network fetch
  //    await Future.delayed(Duration(milliseconds: 1000));
  //   if failed,use refreshFailed()
  //   _refreshController.refreshCompleted();
  //  }

  // void _onLoading() async {
  //   monitor network fetch
  //  await Future.delayed(Duration(milliseconds: 1000));
  //   if failed,use loadFailed(),if no data return,use LoadNodata()
  //    items.add((items.length + 1).toString());
  //    if (mounted) setState(() {});
  //    _refreshController.loadComplete();
  //  }

  Widget build(BuildContext context) {
  return Scaffold(
    body: NestedScrollView(
      headerSliverBuilder: 
      (BuildContext context, bool innerBoxIsScrolled){
         return <Widget>[
                // SliverAppBar(
                //   automaticallyImplyLeading: true,
                //   backgroundColor: Colors.transparent,
                //   expandedHeight: 300.0,
                //   floating: false,
                //   pinned: true,
                //   flexibleSpace: FlexibleSpaceBar(
                //       centerTitle: true,
                //       collapseMode: CollapseMode.pin,
                //       background: Image.asset(
                //         'assets/images/a.jpg',
                //         fit: BoxFit.cover,
                //       )),
                // ),
              ];
      },
      body: Column(
        children: <Widget>[
          Container(
            child: ConstrainedBox(
             constraints: BoxConstraints(
               
               ),
               child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
             Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new ExactAssetImage('assets/images/p2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new BackdropFilter(filter: new ImageFilter.blur(sigmaX: 600.0, sigmaY: 1000.0)),
                    width: 400,
                    height: 200,
                  ),
                ),
              ),
              // new Padding(
              //   padding: new EdgeInsets.all(8.0),
              //   child: new TextField(
              //     controller: searchController,
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search),
              //       border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(32.0)),
              //       hintText: "ค้นหา",
              //     ),
              //   ),
              //   ),
              Container(
                    width: 320,
                    height: 150,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Calendar()
                        )
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.pink[100],
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          const ListTile(
                            //leading: Icon(Icons.album, size: 70.0, ),
                            title: Text('วันนัดหมายของคุณ', style: TextStyle(color: Colors.black,fontSize: 20.0),
                            textAlign: TextAlign.center),
                            subtitle: Text('21 พฤศจิกายน 62', style: TextStyle(color: Colors.black,fontSize: 24.0),
                            textAlign: TextAlign.center),
                        ),
                        ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                   child: RaisedButton.icon(
                     icon: Icon(
                       Icons.date_range,
                       color: Colors.blueGrey[700],
                     ),
                     color: Colors.blueGrey[300],
                      label: Text(
                        "เลื่อนเวลานัดหมาย",
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ), onPressed: () async {},
                   ),
                  ),

                  Container(
                   child: RaisedButton.icon(
                     icon: Icon(
                       Icons.assignment_turned_in,
                       color: Colors.blueGrey[700],
                     ),
                     color: Colors.blueGrey[300],
                      label: Text(
                        "เลื่อนเวลานัดหมาย",
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ), onPressed: () async {},
                   ),
                  ),
              // Container(
              //       width: 320,
              //       height: 150,
              //       child: Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.0),
              //         ),
              //         color: Colors.green[200],
              //         elevation: 10,
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             const ListTile(
              //           //   leading: Icon(Icons.album, size: 70.0, ),
              //             title: Text('เลื่อนเวลานัด', style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
              //           //   subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
              //           ),
              //           ],
              //         ),
              //       ),
              //     ),
            ],
          ),
            ),
          )
        ],
      ),
      ),
      );
  } 
}

    // return Scaffold(
    //   body: SmartRefresher(
    //     enablePullDown: true,
    //     enablePullUp: true,
    //     header: WaterDropHeader(),
    //     footer: CustomFooter(
    //       builder: (BuildContext context, LoadStatus mode) {
    //         Widget body;
    //         if (mode == LoadStatus.idle) {
    //           body = Text("pull up load");
    //         } else if (mode == LoadStatus.failed) {
    //           body = Text("Load Failed!Click retry!");
    //         } else {
    //           body = Text("No more Data");
    //         }
    //         return Container(
    //           height: 55.0,
    //           child: Center(child: body),
    //         );
    //       },
    //     ),
    //     controller: _refreshController,
    //     onRefresh: _onRefresh,
    //     onLoading: _onLoading,
    //     child: ListView.builder(
    //       itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
    //       itemExtent: 100.0,
    //       itemCount: items.length,
    //     ),
    //   ),
    // );

