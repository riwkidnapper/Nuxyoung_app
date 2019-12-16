library event;

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'eventview.dart';
part 'eventcard.dart';

typedef void EventCallback(Event event);

class Event {
  final String id;
  final String name;
  final DateTime date;

  Event({
    this.id,
    this.name,
    this.date,
  });

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        id: map["id"],
        name: map["ชื่อคนไข้"],
        date: DateTime.parse(
            "${map["วันเดือนปีที่นัดหมาย"]} ${map["เวลาที่นัดหมาย"].split(":")[0]}:${map["เวลาที่นัดหมาย"].split(":")[1]}:00"),
      );

  factory Event.fromJson(String s) => Event.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": this.id,
        "name": this.name,
        "date": this.date,
      };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          date == other.date;

  @override
  int get hashCode => (id.hashCode ^ name.hashCode ^ date.hashCode);

  @override
  String toString() {
    return '$runtimeType{id: $id, name: $name, date: $date}';
  }
}
