import 'package:flutter/material.dart';
// import 'package:nuxyoung/Pages/pop_up_item/adddoc.dart';
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
                // Padding(
                //   padding: const EdgeInsets.only(
                //       bottom: 15.0, top: 8.0, right: 20.0),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: <Widget>[
                //       AddproflieDoc(),
                //     ],
                //   ),
                // ),
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
              child: avatar(
                  proflieimg =
                      'https://i2-prod.mirror.co.uk/interactives/article12645227.ece/ALTERNATES/s615/doctor.jpg',
                  'นพ.สุขวุฒิ ยุทธศาสตร์'),
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
                  title = 'นพ.สุขวุฒิ ยุทธศาสตร์',
                  description = "วันเวลาออกตรวจ\n\n"
                      "วันพุธ: 9.00 น. - 12.00 น.\nวันศุกร์: 9.00 น. - 12.00 น.'",
                  proflieimg =
                      "https://i2-prod.mirror.co.uk/interactives/article12645227.ece/ALTERNATES/s615/doctor.jpg",
                );
                Navigator.pop(context);
              }),
          SizedBox(
            width: 30.0,
          ),
          InkWell(
              child: avatar(
                  proflieimg =
                      "https://firebasestorage.googleapis.com/v0/b/nuxyoungapp.appspot.com/o/Userimage%2Fnull?alt=media&token=30fb05b1-780d-4c9f-b667-4e6165ec4a44",
                  'นพ.ตนุพล วิรุฬหการุญ'),
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
                  title = "นพ.ตนุพล วิรุฬหการุญ",
                  description = "วันเวลาออกตรวจ\n\n"
                      "วันจันทร์: 9.00 น. - 12.00 น.\nวันอังคาร: 9.00 น. - 12.00 น.\nวันพุธ: 9.00 น. - 12.00 น.\nวันพฤหัสบดี: 9.00 น. - 12.00 น.\nวันศุกร์: 9.00 น. - 12.00 น.\nวันเสาร์: 9.00 น. - 12.00 น.\nวันอาทิตย์: 9.00 น. - 12.00 น.",
                  proflieimg =
                      "https://firebasestorage.googleapis.com/v0/b/nuxyoungapp.appspot.com/o/Userimage%2Fnull?alt=media&token=30fb05b1-780d-4c9f-b667-4e6165ec4a44",
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
              image: NetworkImage(imagename),
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
