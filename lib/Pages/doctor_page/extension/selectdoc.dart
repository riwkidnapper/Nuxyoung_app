import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/doctor_page/extension/table.dart';

class Selectdoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.all(15.0),
      height: 210,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "นพ.ธนาธรณ์ พุฒิกานนท์",
                      style: TextStyle(fontSize: 40, color: Colors.blueGrey),
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
                      defaultColumnWidth: FixedColumnWidth(200.0),
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
                        buildTableWed("วันพุธ, 9.00 น. - 12.00 น."),
                        buildTableFri("วันศุกร์, 9.00 น. - 12.00 น."),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
