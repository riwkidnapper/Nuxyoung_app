part of item;

class ColorLoader extends StatefulWidget {
  final List<Color> colors;

  ColorLoader({
    @required this.colors,
  });

  @override
  _ColorLoaderState createState() => _ColorLoaderState(
        this.colors,
      );
}

class _ColorLoaderState extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  final List<Color> colors;

  Timer timer;

  _ColorLoaderState(
    this.colors,
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

    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
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
        SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor: colorAnimations[tweenIndex],
            // backgroundColor: Color(0xFFFFFFFF),
          ),
          height: 50.0,
          width: 50.0,
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
