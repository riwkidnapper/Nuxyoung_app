import 'package:flutter/material.dart';

TableRow buildTablehead(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.blueGrey[700],
        alignment: Alignment.center,
        child:
            Text(name, style: TextStyle(fontSize: 25.0, color: Colors.white)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableMon(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.amberAccent[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableTue(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.pink[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableWed(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.lightGreenAccent[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableThu(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.orangeAccent[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableFri(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.lightBlue[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableSat(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.deepPurpleAccent[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}

TableRow buildTableSun(String listOfNames) {
  return TableRow(
    children: listOfNames.split(':').map((name) {
      return Container(
        color: Colors.redAccent[100],
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 22.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}
