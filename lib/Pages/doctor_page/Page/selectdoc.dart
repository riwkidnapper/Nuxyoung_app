import 'package:flutter/material.dart';

class Selectdoc extends StatefulWidget {
  final String doctorName;
  final photoUser;
  final String times;
  const Selectdoc(
      {Key key,
      @required this.doctorName,
      @required this.photoUser,
      @required this.times})
      : super(key: key);
  @override
  _SelectdocState createState() =>
      _SelectdocState(doctorName, photoUser, times);
}

class _SelectdocState extends State<Selectdoc> {
  final String doctorName;
  final photoUser;
  final String times;
  String timelist = "";
  String t = "";

  _SelectdocState(this.doctorName, this.photoUser, this.times);

  @override
  Widget build(BuildContext context) {
    //print(times);
    timelist = times.split(', ').join(']\n[').toString();
    t = timelist.split('\n').join('\n\n');
    //print(timelist);
    if (t == '[วันจันทร์: 9.00 น. - 12.00 น.]') {
      print('test');
    }
    return Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.all(15.0),
      height: 270,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black38, offset: Offset(0, 1), blurRadius: 1)
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[100],
                      child: Container(
                        width: 250.0,
                        height: 300.0,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: NetworkImage(
                              photoUser,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          doctorName,
                          style:
                              TextStyle(fontSize: 40, color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "วันเวลาออกตรวจ",
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Table(
                          defaultColumnWidth: FixedColumnWidth(380.0),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            verticalInside: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          children: [
                            TableRow(
                              children: t.split(',').map((name) {
                                return t.contains('วันจันทร์')
                                    ? Container(
                                        color: Colors.amberAccent[100],
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 20.0, 20.0, 20.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                name,
                                                style:
                                                    TextStyle(fontSize: 26.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ))
                                    : t.contains('วันอังคาร')
                                        ? Container(
                                            color: Colors.pink[100],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20.0, 20.0, 20.0, 20.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    name,
                                                    style: TextStyle(
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ))
                                        : t.contains('วันพุธ')
                                            ? Container(
                                                color: Colors
                                                    .lightGreenAccent[100],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20.0,
                                                          20.0,
                                                          20.0,
                                                          20.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        name,
                                                        style: TextStyle(
                                                            fontSize: 26.0),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : t.contains('วันพฤหัสบดี')
                                                ? Container(
                                                    color: Colors
                                                        .orangeAccent[100],
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(20.0,
                                                          20.0, 20.0, 20.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            name,
                                                            style: TextStyle(
                                                                fontSize: 26.0),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                : t.contains('วันศุกร์')
                                                    ? Container(
                                                        color: Colors
                                                            .lightBlue[100],
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  20.0,
                                                                  20.0,
                                                                  20.0,
                                                                  20.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                name,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        26.0),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                    : t.contains('วันเสาร์')
                                                        ? Container(
                                                            color: Colors
                                                                    .deepPurpleAccent[
                                                                100],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20.0,
                                                                      20.0,
                                                                      20.0,
                                                                      20.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            26.0),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            ))
                                                        : Container(
                                                            color: Colors
                                                                .redAccent[100],
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20.0,
                                                                      20.0,
                                                                      20.0,
                                                                      20.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            26.0),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                              }).toList(),
                            ),
                            // buildTablehead("วันที่: เวลา"),
                            // buildTableWed("วันพุธ: 9.00 น. - 12.00 น."),
                            // buildTableFri("วันศุกร์: 9.00 น. - 12.00 น.")
                          ],
                        ),
                        // Text(
                        //   timelist,
                        //   style: TextStyle(
                        //       fontSize: 28.0,
                        //       color: Colors.blueGrey,
                        //       fontWeight: FontWeight.w600),
                        //   textAlign: TextAlign.start,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
