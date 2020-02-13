part of home;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FirebaseUser currentUser;

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();

    firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      await Firestore?.instance
          ?.collection("users")
          ?.where('uid', isEqualTo: currentUser.uid)
          ?.getDocuments()
          ?.then((docs) {
        Firestore?.instance
            ?.document('/users/${docs.documents[0].documentID}')
            ?.updateData({
          'devtoken': token,
        })?.then((onValue) {
          print("Token : $token");
        })?.catchError((e) {
          print(e);
        });
      })?.catchError((e) {
        print(e);
      });
    });
  }

  void _loadCurrentUser() {
    FirebaseAuth?.instance?.currentUser()?.then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
          ),
        ),
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            backgroundColor: (Colors.blueGrey),
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.failed) {
                body = Text("");
              } else {
                body = Text("");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Header(),
              Doctorproflie(),
              Article(),
            ],
          ),
        ),
      ],
    );
  }
}
