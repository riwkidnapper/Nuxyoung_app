part of tool;

class Items {
  String key;
  String message;
  String form;
  String isTo;
  String isFrom;
  var time = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());

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
      "timestamp": time,
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
