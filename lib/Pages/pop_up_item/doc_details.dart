part of item;

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
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/doc.pdf");

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
            body: Column(children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),
              SizedBox(height: 10.0),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: new Text(
                          "บทความของ พญ.นพวรรณ ศรีวงค์พานิช ",
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
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "พัฒนาการ หมายถึง การเปลี่ยนแปลงในด้านการ\nทำหน้าที่และวุฒิภาวะของอวัยวะต่างๆรวมทั้งตัวบุคคล \n"
                      "ทำให้สามารถทำหน้าที่ได้อย่างมีประสิทธิภาพ\n ทำสิ่งที่ยากสลับซับซ้อนมากขึ้น "
                      "\nโดยทั่วไป ได้แก่"
                      " \n1.พัฒนาการด้านร่างกาย (physical development) เป็นความสามารถของร่างกายในการทรงตัวและการเคลื่อนไหว โดยการใช้กล้ามเนื้อมัดใหญ่(gross motor) การใช้มือและตาประสานกันในการทำกิจกรรมต่างๆ (fine motor-adaptive)",
                      style: TextStyle(fontSize: 16),
                    )
                    // RaisedButton(
                    //   shape: StadiumBorder(),
                    //   color: Colors.blueGrey[300],
                    //   child: Text("เปิดอ่าน"),
                    //   onPressed: () {},
                    // ),
                    // SizedBox(height: 10.0),
                    // new Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Padding(
                    //           padding: EdgeInsets.only(
                    //             left: 10.0,
                    //           ),
                    //           child: new Text(
                    //             "บทความของ นพ.ธนาธรณ์ พุฒิกานนท์",
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w700,
                    //                 fontSize: 20.0,
                    //                 color: Colors.blueGrey),
                    //           )),
                    //       Padding(
                    //           padding: EdgeInsets.only(
                    //             right: 12.0,
                    //           ),
                    //           child: new Text("",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.w700,
                    //                   fontSize: 12.0,
                    //                   color: Colors.grey)))
                    //     ]),

                    //SizedBox(height: 5.0),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Padding(
                    //       padding: EdgeInsets.only(left: 12.0),
                    //       child: Text(
                    //         "โรงพยาบาล พุทธชินราช",
                    //         style: TextStyle(
                    //             color: Colors.grey[600], fontSize: 18.0),
                    //       )),
                    // ),

                    // Column(
                    //   children: <Widget>[
                    //     Text(
                    //         'ชื่อเจ้าของบทความ',
                    //         style: TextStyle(
                    //         fontSize: 16,
                    //         color: Colors.blueGrey[700],
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //     TextFormField(
                    //        maxLines: 4,
                    //        style: TextStyle(fontSize: 18),
                    //     ),
                    //   ],
                    // ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     RaisedButton(
                    //       shape: StadiumBorder(),
                    //       color: Colors.blueGrey[300],
                    //       child: Text("เปิดบนอินเทอร์เน็ต"),
                    //       onPressed: () {
                    //         if (urlPDFPath != null) {
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       PdfViewPage(path: assetPDFPath)));
                    //         }
                    //       },
                    //     ),
                    //     SizedBox(
                    //       height: 60,
                    //     ),
                    // RaisedButton(
                    //   shape: StadiumBorder(),
                    //   color: Colors.cyan[300],
                    //   child: Text("เปิดบนแอพพลิเคชั่น"),
                    //   onPressed: () {
                    //     if (assetPDFPath != null) {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   PdfViewPage(path: assetPDFPath)));
                    //     }
                    //   },
                    // ),
                    //     SizedBox(
                    //       height: 60,
                    //     ),
                    //   ],
                    // ),
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
              ),
            ]),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      background: Image.network(
                        'http://www.phyathai-sriracha.com/pytsweb/images/children/baby_talk.jpg',
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            }));
  }
}
