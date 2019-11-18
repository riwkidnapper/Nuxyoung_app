import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/pop_up_item/adddoc.dart';
import 'package:nuxyoung/Pages/pop_up_item/color_loader.dart';
import 'package:nuxyoung/Pages/pop_up_item/customdialog.dart';

List<Color> colors = [
  Colors.blueGrey,
  Colors.blueGrey[400],
];

class Doctorproflie extends StatefulWidget {
  @override
  _DoctorproflieState createState() => _DoctorproflieState();
}

class _DoctorproflieState extends State<Doctorproflie> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        constraints: new BoxConstraints(
          maxHeight: double.infinity,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: new DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xF1FFFFFF),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 1), blurRadius: 1)
            ],
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 230,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Dialoglogdoc(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, top: 8.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AddproflieDoc(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dialoglogdoc extends StatefulWidget {
  @override
  _DialoglogdocState createState() => _DialoglogdocState();
}

class _DialoglogdocState extends State<Dialoglogdoc> {
  String title = '', description = '', proflieimg = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 35.0, bottom: 0.0, right: 35.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
              child: avatar(proflieimg = 'assets/images/doc_231.jpg',
                  'นพ.ธนาธรณ์ พุฒิกานนท์'),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: ColorLoader(
                          colors: colors,
                        ),
                      );
                    });
                await loginAction(
                  title = 'นพ.ธนาธรณ์ พุฒิกานนท์',
                  description =
                      "Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n"
                          "Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.'",
                  proflieimg = "assets/images/doc_231.jpg",
                );
                Navigator.pop(context);
              }),
          SizedBox(
            width: 30.0,
          ),
          InkWell(
              child: avatar(proflieimg = "assets/images/555.jpg",
                  'นพ.นิธิพัฒน์ บุษบารติ'),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: ColorLoader(
                          colors: colors,
                        ),
                      );
                    });
                await loginAction(
                  title = "นพ.นิธิพัฒน์ บุษบารติ",
                  description = "test",
                  proflieimg = "assets/images/555.jpg",
                );
                Navigator.pop(context);
              }),
          SizedBox(
            width: 30.0,
          ),
        ],
      ),
    );
  }

  Future<bool> loginAction(
      String savetitle, String savedescription, String saveimage) async {
    await new Future.delayed(const Duration(milliseconds: 1500));
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomDialog(
        title: savetitle,
        description: savedescription,
        buttonText: 'OKAY',
        image: saveimage,
      ),
    );
  }
}

avatar(imagename, String name) {
  return InkWell(
    child: Column(
      children: <Widget>[
        Container(
          width: 140.0,
          height: 140.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage(imagename),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: new BorderRadius.all(
              new Radius.circular(100.0),
            ),
            border: new Border.all(
              color: Colors.grey[350],
              width: 3.0,
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 2)
            ],
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
