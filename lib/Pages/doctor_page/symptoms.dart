import 'package:flutter/material.dart';

class SymTom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("อาการเบื้องต้น")), 
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Card(
              child: 
                new Column(
                  children: <Widget>[
                    new Icon(Icons.accessibility, size: 50.0,color: Colors.brown,),
                  new Text("Home", style: new TextStyle(fontSize: 20.0)),
                  ],
                )
            ),
            new Card(
              child: 
                new Column(
                  children: <Widget>[
                    new Icon(Icons.accessibility_new, size: 50.0,color: Colors.brown,),
                  new Text("Home", style: new TextStyle(fontSize: 20.0)),
                  ],
                )
            ),
            new Card(
              child: 
                new Column(
                  children: <Widget>[
                    new Icon(Icons.accessible, size: 50.0,color: Colors.brown,),
                  new Text("Home", style: new TextStyle(fontSize: 20.0)),
                  ],
                )
            ),
            new Card(
              child: 
                new Column(
                  children: <Widget>[
                    new Icon(Icons.accessible_forward, size: 50.0,color: Colors.brown,),
                  new Text("Home", style: new TextStyle(fontSize: 20.0)),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
