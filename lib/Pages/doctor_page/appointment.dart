import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/doctor_page/Page/Addappoint.dart';
import 'extension/selectdoc.dart';
import 'extension/table.dart';

int _state = 0;

class Appointment extends StatefulWidget {
  Appointment({Key key}) : super(key: key);

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with TickerProviderStateMixin {
  bool click = false;
  void _click() {
    setState(() {
      click = true;
    });
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                  child: Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 220.0, 2.0),
                      child: FittedBox(
                        child: Text(
                          'พบแพทย์จำนวน 1 ราย',
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
                GestureDetector(
                  onTap: () => _click(),
                  child: (!click)
                      ? Selectdoc()
                      : Container(
                          margin: EdgeInsets.all(11.0),
                          padding: EdgeInsets.all(15.0),
                          height: 250,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0, 1),
                                  blurRadius: 1)
                            ],
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
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
                                              "http://www.pitsanuvej.com/image/doctor/doc_231.jpg",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "นพ.ธนาธรณ์ พุฒิกานนท์",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.blueGrey),
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
                                          defaultColumnWidth:
                                              FixedColumnWidth(200.0),
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
                                            buildTablehead("วันที่, เวลา"),
                                            buildTableWed(
                                                "วันพุธ, 9.00 น. - 12.00 น."),
                                            buildTableFri(
                                                "วันศุกร์, 9.00 น. - 12.00 น."),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                child: setUpButtonChild(),
                                onPressed: () {
                                  setState(() {
                                    if (_state == 0) {
                                      animateButton();
                                    }
                                  });
                                },
                                elevation: 4.0,
                                minWidth: double.infinity,
                                height: 35.0,
                                color: Colors.blueGrey[300],
                              ),
                            ],
                          ),
                        ),
                )
              ]),
        ));
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "เลือกแพทย์ท่านนี้",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      setState(() {
        _state = 0;
        click = false;
      });
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Future.delayed(new Duration(milliseconds: 1500), () {
      setState(() {
        _state = 2;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Addappoint()),
      );
    });
  }
}
