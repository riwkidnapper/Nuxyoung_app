part of layout;
// import 'package:nuxyoung/Pages/pop_up_item/editll.dart';

class Article extends StatefulWidget {
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, bottom: 10.0, right: 10.0, top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'บทความน่าสนใจที่เกี่ยวข้อง',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 3.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: const FractionalOffset(1.0, 2.0),
                end: const FractionalOffset(-0.2, 0.2),
                colors: [
                  Colors.blueGrey[300],
                  Colors.blue[200],
                ],
              ),
            ),
            width: 250.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 7.0, 50.0),
            child: Container(
              constraints: new BoxConstraints(
                maxHeight: double.infinity,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: new DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xF1FFFFFF),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 1),
                        blurRadius: 1)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 15, right: 15, bottom: 30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 380,
                        width: 350,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _disabilityCard(
                                context,
                                "https://www.honestdocs.co/system/blog_articles/main_hero_images/000/006/943/large/Slide15.JPG",
                                "บทความ เรื่อง",
                                "ภาวะพัฒนาการช้าในเด็ก \n(Developmental Delay)"),
                            SizedBox(width: 15.0),
                            _disabilityCard(
                                context,
                                "https://www.phyathai.com/photo/article_7087280672.jpg",
                                "บทความ เรื่อง",
                                "ลูกมีพัฒนาการช้าหรือไม่? \nพ่อแม่สังเกตได้จากสัญญาณเหล่านี้"),
                            SizedBox(width: 15.0),
                            _disabilityCard(
                                context,
                                "http://www.phyathai-sriracha.com/pytsweb/images/children/baby_talk.jpg",
                                "บทความ เรื่อง",
                                "เด็กที่มีความบกพร่องทางพัฒนาการ"),
                            SizedBox(width: 15.0),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       bottom: 15.0, top: 8.0, right: 20.0),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: <Widget>[
                      //       Editll(),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
                        image: NetworkImage(imageName), fit: BoxFit.cover)),
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
                            backgroundColor: Colors.blueGrey[200],
                            //fontFamily: 'Timesroman',
                            fontSize: 25.0,
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              backgroundColor: Colors.black38,
                              //fontFamily: 'Timesroman',
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ))
          ],
        ),
      ));
}
