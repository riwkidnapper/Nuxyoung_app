import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:nutsyong_app/Pages/pop_up_item/Profliedoctorl.dart';
import 'package:nutsyong_app/Pages/pop_up_item/food_details.dart';
import 'package:nutsyong_app/pull_to_refresh.dart';
// import 'dart:math';
// import 'pop_up_item/color_loader.dart';

List<Color> colors = [
  Colors.blueGrey,
  Colors.cyan[900],
  Colors.lightBlue[900],
  Colors.blueAccent,
  Colors.blue[900]
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool selected = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

//  Stack(
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFEEEEEE),
//                     image: DecorationImage(
//                       alignment: Alignment.topCenter,
//                       fit: BoxFit.cover,
//                       image: AssetImage('assets/images/homewall.png'),
//                       colorFilter: new ColorFilter.mode(
//                           Colors.grey[50].withOpacity(0.3), BlendMode.dstATop),
//                     ),
//                   ),
//                 ),
//                 ListView(
//                   physics: const BouncingScrollPhysics(),
//                   children: <Widget>[
//                     _header,
//                     _doctor(context),
//                     _article,
//                     _aboutarticle(context),
//                   ],
//                 ),
//               ],
//             ),
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/homewall.png'),
              colorFilter: new ColorFilter.mode(
                  Colors.grey[50].withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
        ),
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            backgroundColor: (Colors.blueGrey),
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.failed) {
                body = Text("");
              } else {
                body = Text("");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              _header,
              _doctor(context),
              _article,
              _aboutarticle(context),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _header = Padding(
  padding:
      const EdgeInsets.only(left: 30.0, bottom: 10.0, right: 10.0, top: 10.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'ประวัติแพทย์ผู้รักษา',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      Container(
        height: 3.0,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: const FractionalOffset(0.3, 2.0),
            end: const FractionalOffset(-0.2, 0.2),
            colors: [
              Colors.blueGrey,
              Colors.lightBlueAccent[700],
            ],
          ),
        ),
        width: 100.0,
      ),
    ],
  ),
);

Widget _doctor(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
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
                  _ProflieDoctor(context),
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

Widget _ProflieDoctor(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 20.0, top: 35.0, bottom: 0.0, right: 35.0),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          child: avatar("assets/images/dvm.jpg", 'Profile DocTor l'),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                    title: "Success",
                    description:
                        "',Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n"
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
        InkWell(
          child: avatar(
            "assets/images/dvm.jpg",
            'Profile DocTor ll',
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AboutPopup(),
            );
          },
        ),
        SizedBox(
          width: 15.0,
        ),
        InkWell(
          child: avatar(
            "assets/images/dvm.jpg",
            'Test',
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AboutPopup(),
            );
          },
        ),
        SizedBox(
          width: 15.0,
        ),
        //avatar(Icons.book, 'Editorials')
      ],
    ),
  );
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: ListView(children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ]),
        ),
        //...bottom card part,
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
          child: Container(
            child: CircleAvatar(
              child: ClipOval(
                child: image,
              ),
              //backgroundColor: Colors.blueAccent,
              radius: Consts.avatarRadius,
            ),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(color: Colors.lime[700], width: 3.0)),
          ),
        ), //...top circlular image part,
      ],
    );
  }
}

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 77.0;
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

Widget _article = Padding(
  padding:
      const EdgeInsets.only(left: 30.0, bottom: 10.0, right: 10.0, top: 10.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'บทความน่าสนใจที่เกี่ยวข้อง',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      Container(
        height: 3.0,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: const FractionalOffset(0.3, 2.0),
            end: const FractionalOffset(-0.2, 0.2),
            colors: [
              Colors.blueGrey,
              Colors.lightBlueAccent[700],
            ],
          ),
        ),
        width: 100.0,
      ),
    ],
  ),
);

Widget _aboutarticle(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 120.0),
    child: Container(
      constraints: new BoxConstraints(
        maxHeight: 480,
        minWidth: double.maxFinite,
      ),
      child: new DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xF1FFFFFF),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 1), blurRadius: 2)
          ],
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Container(
                height: 380,
                width: 350,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _disabilityCard(context, "dvm.jpg",
                        "Family Vegan\nSalad tips", "5 family salad recipes"),
                    SizedBox(width: 15.0),
                    _disabilityCard(context, "dvm.jpg",
                        "Weekend Night\nDinner tips", "4 family lunch recipes"),
                    SizedBox(width: 15.0),
                    _disabilityCard(context, "dvm.jpg", "Night\nDessert",
                        "4 family dessert recipes"),
                    SizedBox(width: 15.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 270, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _editll,
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

Widget _disabilityCard(
    BuildContext context, String imageName, String title, String subTitle) {
  void moveTodisabilityDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodScreen()),
    );
  }

  return new GestureDetector(
      onTap: () => moveTodisabilityDetailsScreen(),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                width: 250.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: AssetImage('assets/images/' + imageName),
                        fit: BoxFit.cover)),
                /*child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),*/
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
                /* ),*/
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            //fontFamily: 'Timesroman',
                            fontSize: 25.0,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              //fontFamily: 'Timesroman',
                              fontSize: 15.0,
                              color: Colors.blueGrey[400],
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ))
          ],
        ),
      ));
}

Widget _editll = new FloatingActionButton(
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
