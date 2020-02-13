part of item;

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'การแจ้งเตือน',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            ?.collection('notifications')
            ?.where('uid', isEqualTo: "3jHS0wUYXzgWBVSmnRel1R5MGzi2")
            ?.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 250.0, 0.0, 8.0),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                ),
              ),
            );
          } else {
            if (snapshot.data.documents.length == 0) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 200.0, top: 10.0, left: 0.0, bottom: 10.0),
                    child: Text(
                      "การแจ้งเตือน",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'assets/images/bell.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 110,
                            height: 110,
                          ),
                          Text(
                            'ยังไม่มีการแจ้งเตือน',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'การแจ้งเตือนจะปรากฏที่นี่เมื่อคุณได้รับ',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 200.0, top: 10.0, left: 0.0, bottom: 10.0),
                    child: Text(
                      "การแจ้งเตือน",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      final documents = snapshot.data.documents[index];
                      return NotifyCard(
                        title: documents['title'] ?? "",
                        body: documents['body'] ?? "",
                      );
                    },
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
