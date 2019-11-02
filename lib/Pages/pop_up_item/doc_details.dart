import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class FoodScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<FoodScreen> {
  String assetPDFPath = "";
  String urlPDFPath = "";
  String descriptionText =
      "The classic pile-up of toasted English muffins topped with seared Canadian bacon, "
      "poached eggs and creamy hollandaise sauce you usually reserve for weekend brunch plans.";
  @override
  void initState() {
    super.initState();

    getFileFromAsset("assets/mypdf.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });

    getFileFromUrl("http://www.pdf995.com/samples/pdf.pdf").then((f) {
      setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);
      });
    });
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  //************************************************************************************************************* */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text("Second Route"),
        ),*/
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                background: Image.asset(
                  'assets/images/a.jpg',
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
          SizedBox(height: 10.0),
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                ),
                child: new Text(
                  "บทความของ นพ.ธนาธรณ์ พุฒิกานนท์",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.blueGrey),
                )),
            Padding(
                padding: EdgeInsets.only(
                  right: 12.0,
                ),
                child: new Text("",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        color: Colors.grey)))
          ]),

          SizedBox(height: 5.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  "โรงพยาบาล พุทธชินราช",
                  style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.blueGrey[300],
                child: Text("เปิดบนอินเทอร์เน็ต"),
                onPressed: () {
                  if (urlPDFPath != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PdfViewPage(path: assetPDFPath)));
                  }
                },
              ),
              SizedBox(
                height: 60,
              ),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.cyan[300],
                child: Text("เปิดบนแอพพลิเคชั่น"),
                onPressed: () {
                  if (assetPDFPath != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PdfViewPage(path: assetPDFPath)));
                  }
                },
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
          //SizedBox(height: 10),
          // new Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       new Row(children: <Widget>[
          //         Padding(
          //             padding: EdgeInsets.only(
          //               left: 10.0,
          //             ),
          //            /* child: new StarRating(
          //               size: 15.0,
          //               rating: 3,
          //               color: Colors.orange,
          //               borderColor: Colors.grey,
          //               starCount: 5,
          //             )*/),
          //         // Padding(
          //         //     padding: EdgeInsets.only(
          //         //       left: 10.0,
          //         //       right: 10.0,
          //         //     ),
          //         //     child: new Text("(280 reviews)",
          //         //         style: TextStyle(
          //         //             fontWeight: FontWeight.w700,
          //         //             fontSize: 12.0,
          //         //             color: Colors.grey))),
          //       ]),
          //       Padding(
          //           padding: EdgeInsets.only(
          //             right: 10.0,
          //           ),
          //           child: InkWell(
          //               child: new Container(
          //             width: 100.0,
          //             height: 30.0,
          //             decoration: new BoxDecoration(
          //               color: Colors.grey[400],
          //               borderRadius: new BorderRadius.circular(25.0),
          //             ),
          //             child: new Center(
          //               child: new Text(
          //                 'Add to Fav',
          //                 style: new TextStyle(
          //                     fontSize: 15.0,
          //                     color: Colors.grey[555],
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           )))
          //     ]),
          // SizedBox(
          //   height: 20.0,
          // ),
          // SizedBox(height: 25.0),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Padding(
          //       padding: EdgeInsets.only(left: 12.0),
          //       child: Text(
          //         "บทความ สำหรับพ่อแม่ผู้ปกครอง เรื่อง ลูกติดมือถือ เกมส์ ทีวีโซเชียล",
          //         style: TextStyle(
          //             fontSize: 20.0,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.grey),
          //       )),
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 10.0),
          //   child: Text(
          //     descriptionText,
          //     style: TextStyle(
          //         wordSpacing: 2.0,
          //         textBaseline: TextBaseline.alphabetic),
          //   ),
          // )
        ],
      ),
    ));
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}
