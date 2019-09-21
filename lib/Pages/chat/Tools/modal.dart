import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Items {
  String key;
  String message;
  String form;
  String isTo;
  String isFrom;

  Items(this.message, this.form, this.isTo, this.isFrom);

  Items.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        message = snapshot.value["message"],
        form = snapshot.value["form"],
        isTo = snapshot.value["isTo"],
        isFrom = snapshot.value["isFrom"];

  toJson() {
    return {
      "message": message,
      "form": form,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "isTo": isTo,
      "isFrom": isFrom,
    };
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
