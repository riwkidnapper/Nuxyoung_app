import 'package:flutter/material.dart';
import 'dart:async';

class ColorLoader extends StatefulWidget {
  final List<Color> colors;
  final imagename;
  ColorLoader({
    @required this.colors,
    @required this.imagename,
  });

  @override
  _ColorLoaderState createState() => _ColorLoaderState(
        this.colors,
        this.imagename,
      );
}

class _ColorLoaderState extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  final List<Color> colors;
  final imagename;
  Timer timer;

  _ColorLoaderState(
    this.colors,
    this.imagename,
  );

  List<ColorTween> tweenAnimations = [];
  int tweenIndex = 0;

  AnimationController controller;
  List<Animation<Color>> colorAnimations = [];

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    for (int i = 0; i < colors.length - 1; i++) {
      tweenAnimations.add(ColorTween(begin: colors[i], end: colors[i + 1]));
    }

    tweenAnimations
        .add(ColorTween(begin: colors[colors.length - 1], end: colors[0]));

    for (int i = 0; i < colors.length; i++) {
      Animation<Color> animation = tweenAnimations[i].animate(CurvedAnimation(
          parent: controller,
          curve: Interval((1 / colors.length) * (i + 1) - 0.10,
              (1 / colors.length) * (i + 1),
              curve: Curves.linear)));

      colorAnimations.add(animation);
    }

    //print ( colorAnimations.length );

    tweenIndex = 0;

    timer = Timer.periodic(Duration(milliseconds: 1200), (Timer t) {
      setState(() {
        tweenIndex = (tweenIndex + 1) % colors.length;
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 140.0,
            height: 140.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage(imagename),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(
                new Radius.circular(100.0),
              ),
            ),
          ),
        ),
        SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 8.0,
            valueColor: colorAnimations[tweenIndex],
            // backgroundColor: Color(0xFFFFFFFF),
          ),
          height: 150.0,
          width: 150.0,
        )
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }
}
