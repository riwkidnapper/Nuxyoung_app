import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 77.0;
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String image;

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
                    fontSize: 20.0,
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
                    color: Colors.blueGrey[100],
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
            width: 140.0,
            height: 140.0,
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey[400], width: 3.0),
              borderRadius: new BorderRadius.all(
                new Radius.circular(100.0),
              ),              
              image: new DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ), //...top circlular image part,
      ],
    );
  }
}
