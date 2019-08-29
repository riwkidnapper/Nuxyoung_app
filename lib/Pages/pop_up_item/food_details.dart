import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FoodScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<FoodScreen> {
  String descriptionText =
      "The classic pile-up of toasted English muffins topped with seared Canadian bacon, "
      "poached eggs and creamy hollandaise sauce you usually reserve for weekend brunch plans.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text("Second Route"),
        ),*/
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      background: Image.asset(
                        'assets/images/dvm.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: Column(
              children: <Widget>[
                RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),
                SizedBox(height: 10.0),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: new Text(
                            "Doctor Strange",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30.0,
                                color: Colors.blueGrey),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            right: 12.0,
                          ),
                          child: new Text("6.2K\nCooked",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0,
                                  color: Colors.grey)))
                    ]),
                SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Master the king breakfast dish",
                        style: TextStyle(color: Colors.grey[600]),
                      )),
                ),
                SizedBox(height: 10),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Row(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                              left: 10.0,
                            ),
                           /* child: new StarRating(
                              size: 15.0,
                              rating: 3,
                              color: Colors.orange,
                              borderColor: Colors.grey,
                              starCount: 5,
                            )*/),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: new Text("(280 reviews)",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0,
                                    color: Colors.grey))),
                      ]),
                      Padding(
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: InkWell(
                              child: new Container(
                            width: 100.0,
                            height: 30.0,
                            decoration: new BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            child: new Center(
                              child: new Text(
                                'Add to Fav',
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[555],
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )))
                    ]),
                SizedBox(
                  height: 20.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Servings",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "2pp",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Prep Time",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          "20m",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Cook Time",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          "20m",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    descriptionText,
                    style: TextStyle(
                        wordSpacing: 2.0,
                        textBaseline: TextBaseline.alphabetic),
                  ),
                )
              ],
            )));
  }
}
