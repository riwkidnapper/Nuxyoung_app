part of tool;

class Customcard extends StatefulWidget {
  Customcard({
    @required this.photoUser,
    @required this.username,
    @required this.email,
    @required this.uid,
    @required this.fromUid,
  });

  final photoUser;
  final username;
  final email;
  final uid;
  final fromUid;

  @override
  _CustomcardState createState() => _CustomcardState(
        email: email,
        photoUser: photoUser,
        username: username,
        uid: uid,
        fromUid: fromUid,
      );
}

class _CustomcardState extends State<Customcard> {
  FirebaseUser currentUser;
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  _CustomcardState({
    @required this.photoUser,
    @required this.username,
    @required this.email,
    @required this.uid,
    @required this.fromUid,
  });

  final photoUser;
  final username;
  final email;
  final uid;
  final fromUid;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              offset: Offset(0, 0),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        //

        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      // Chat(
                      //       peerAvatar: photoUser,
                      //       peerId: uid,
                      //     )
                      ChatReal(
                        photoUser: photoUser,
                        username: username,
                        uid: uid,
                        fromUid: fromUid,
                      )
                  // // Chat(
                  //   photoUser: photoUser,
                  //   username: username,
                  //   user: currentUser,
                  // ),
                  ),
            );
          },
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Material(
                    child: (photoUser != "")
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(photoUser),
                            backgroundColor: Colors.grey[200],
                            minRadius: 30,
                          )
                        // ? CachedNetworkImage(
                        //
                        //     imageUrl: (photoUser),
                        //     width: 50.0,
                        //     height: 50.0,
                        //     fit: BoxFit.cover,
                        //   )
                        : Icon(
                            Icons.account_circle,
                            size: 58.0,
                            color: Colors.grey,
                          ),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      username,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
