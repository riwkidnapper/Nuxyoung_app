import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "อาการเบื้องต้น",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  EntryItem(data[index]),
              itemCount: data.length,
            )
          ],
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'เคสที่ 1',
    <Entry>[
      Entry(
        'ตัวอย่างที่ 1.1',
        <Entry>[
          Entry('รายละเอียด'),
          Entry('รายละเอียด'),
          Entry('รายละเอียด'),
        ],
      ),
      Entry('ตัวอย่างที่ 1.2'),
      Entry('ตัวอย่างที่ 1.3'),
    ],
  ),
  Entry(
    'เคสที่ 2',
    <Entry>[
      Entry('ตัวอย่างที่ 2.1'),
      Entry('ตัวอย่างที่ 2.2 '),
    ],
  ),
  Entry(
    'เคสที่ 3',
    <Entry>[
      Entry(
        'ตัวอย่างที่ 3.1',
        <Entry>[
          Entry('รายละเอียด'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      trailing: SizedBox(
        height: 0,
        width: 0,
      ),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

/*import 'package:flutter/material.dart';

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
}*/
