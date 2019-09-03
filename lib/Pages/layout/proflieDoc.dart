import 'package:flutter/material.dart';
// import 'package:nuxyong_app/Pages/pop_up_item/color_loader.dart';
import 'package:nuxyong_app/Pages/pop_up_item/customdialog.dart';

enum DialogState {
  LOADING,
  COMPLETED,
  DISMISSED,
}

List<Color> colors = [
  Colors.blueGrey,
  Colors.cyan[900],
  Colors.lightBlue[900],
  Colors.indigoAccent,
  Colors.indigo
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
          maxHeight: 300,
          minWidth: double.maxFinite,
        ),
        child: new DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xF1FFFFFF),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 1), blurRadius: 3)
            ],
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
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
                  left: 280,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _edit,
                  ],
                ),
              ),
            ],
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
  @override
  DialogState _dialogState = DialogState.DISMISSED;
  void _exportData() {
    setState(() => _dialogState = DialogState.LOADING);
    Future.delayed(Duration(seconds: 3)).then((_) {
      setState(() => _dialogState = DialogState.COMPLETED);
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 35.0, bottom: 0.0, right: 35.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: avatar("assets/images/dvm.jpg", 'Profile DocTor l'),
            // onTap: () {
            //   ColorLoader(
            //     colors: colors,
            //     ImageName: 'assets/images/dvm.jpg',
            //   );

            onTap: () {
              // (_dialogState == DialogState.DISMISSED)
              //     ? _exportData()
              //     : (_dialogState == DialogState.LOADING)
              //         ? ColorLoader(
              //             colors: colors,
              //             ImageName: 'assets/images/dvm.jpg',
              //           )
              //         :
              showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  title: "Success",
                  description:
                      "Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n"
                      "Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.'",
                  buttonText: "Okay",
                  image: Image.asset('assets/images/dvm.jpg'),
                ),
              );
            },
          ),
          SizedBox(
            width: 15.0,
          ),
          // InkWell(
          //   child: avatar(
          //     "assets/images/dvm.jpg",
          //     'Profile DocTor ll',
          //   ),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) => AboutPopup(),
          //     );
          //   },
          // ),
          // SizedBox(
          //   width: 15.0,
          // ),
          // InkWell(
          //   child: avatar(
          //     "assets/images/dvm.jpg",
          //     'Test',
          //   ),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) => AboutPopup(),
          //     );
          //   },
          // ),
          SizedBox(
            width: 15.0,
          ),
          //avatar(Icons.book, 'Editorials')
        ],
      ),
    );
  }
}

avatar(ImageName, String name) {
  return InkWell(
    child: Column(
      children: <Widget>[
        Container(
          width: 140.0,
          height: 140.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage(ImageName),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(
              new Radius.circular(100.0),
            ),
            border: new Border.all(
              color: Colors.grey,
              width: 5.0,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 1), blurRadius: 1)
            ],
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            height: 2,
          ),
        ),
      ],
    ),
  );
}

Widget _edit = new FloatingActionButton(
  onPressed: () {},
  child: Icon(
    Icons.add,
    size: 30,
  ),
  heroTag: null,
  mini: true,
  foregroundColor: Colors.blueGrey[900],
  backgroundColor: Colors.blueGrey[200],
);
