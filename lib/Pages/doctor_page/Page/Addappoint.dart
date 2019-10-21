import 'package:flutter/material.dart';

bool clear = false;

class Addappoint extends StatefulWidget {
  Addappoint({Key key}) : super(key: key);

  @override
  _AddappointState createState() => _AddappointState();
}

class _AddappointState extends State<Addappoint> {
  final TextEditingController _controller = new TextEditingController();
  var items = [
    'วันพุธ, 9.00 น. - 12.00 น.',
    'วันศุกร์, 9.00 น. - 12.00 น.',
  ];

  void changState() {
    setState(() {
      clear = true;
    });
  }

  void setstate() {
    setState(() {
      clear = false;
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'เลือกแพทย์',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // (!clear)
              //     ?
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => changState(),
                    icon: Icon(Icons.clear),
                  ),
                  fillColor: Colors.blueGrey[50],
                  filled: true,
                  hintText: "นพ.ธนาธรณ์ พุฒิกานนท์",
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'เลือกช่วงเวลา',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.w700,
                ),
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      controller: _controller,
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      _controller.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return items.map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem(child: Text(value), value: value);
                      }).toList();
                    },
                  ),
                ],
              ),

              SizedBox(
                height: 30,
              ),
              Text(
                'ชื่อ - นามสกุลคนไข้',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.w700,
                ),
              ),

              TextFormField(
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'ประวัติการรักษา',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.w700,
                ),
              ),

              TextFormField(
                maxLines: 4,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'อาการเบื้องต้น',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.w700,
                ),
              ),

              TextFormField(
                maxLines: 4,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: RaisedButton.icon(
                    icon: Icon(
                      Icons.assignment_turned_in,
                      color: Colors.blueGrey[700],
                    ),
                    color: Colors.blueGrey[300],
                    label: Text(
                      "ยืนยัน",
                      style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {}
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Register(),
                    //   ),
                    // );
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
