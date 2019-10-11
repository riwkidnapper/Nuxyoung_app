import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/welcome_page.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[900],
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => Loginpage()
      },
      title: 'Nux Young',
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// import 'package:flutter/material.dart';

// void main() => runApp(new MaterialApp(
//       home: new HomePage(),
//       debugShowCheckedModeBanner: false,
//     ));

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => new _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Offset> _points = <Offset>[];

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new Container(
//         child: new GestureDetector(
//           onPanUpdate: (DragUpdateDetails details) {
//             setState(() {
//               RenderBox object = context.findRenderObject();
//               Offset _localPosition =
//                   object.globalToLocal(details.globalPosition);
//               _points = new List.from(_points)..add(_localPosition);
//             });
//           },
//           onPanEnd: (DragEndDetails details) => _points.add(null),
//           child: new CustomPaint(
//             painter: new Signature(points: _points),
//             size: Size.infinite,
//           ),
//         ),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         child: new Icon(Icons.clear),
//         onPressed: () => _points.clear(),
//       ),
//     );
//   }
// }

// class Signature extends CustomPainter {
//   List<Offset> points;

//   Signature({this.points});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = Colors.blue
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 10.0;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
// }
