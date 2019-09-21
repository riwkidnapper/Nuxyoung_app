//Chat with Realtime datadase
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:nuxyoung/Pages/chat/Tools/modal.dart';
import 'package:nuxyoung/Tebbar/Teb_iteam.dart';

import 'Tools/messageUI.dart';

// import 'package:firebase_core/firebase_core.dart'; not nessecary

class ChatReal extends StatefulWidget {
  final photoUser;
  final username;
  final uid;
  const ChatReal({Key key, this.photoUser, this.username, this.uid})
      : super(key: key);

  @override
  ChatRealState createState() =>
      ChatRealState(photoUser: photoUser, username: username, uid: uid);
}

class ChatRealState extends State<ChatReal> {
  ChatRealState({
    @required this.photoUser,
    @required this.username,
    @required this.uid,
  });
  final photoUser;
  final username;
  final uid;

  DatabaseReference itemRef;
  List<Items> items = List();
  Items message;
  // final FirebaseDatabase _database = FirebaseDatabase.instance;
  // var _firebaseRef =
  //     FirebaseDatabase().reference().child('messages').child('chat');

  TextEditingController _txtCtrl = TextEditingController();
  FirebaseUser currentUser;
  List<Choice> choices = const <Choice>[
    const Choice(title: 'ลบแชท', icon: Icons.delete_forever),
  ];

  void initState() {
    super.initState();
    _loadCurrentUser();
    message = Items("", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('messages').child('chat' + uid);

    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Items.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Items.fromSnapshot(event.snapshot);
    });
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
  }

  void onItemMenuPress(Choice choice) {
    if (choice.title == 'ลบแชท') {
      onBackPress();
    } else {
      return null;
    }
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<Null> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.delete_forever,
                        size: 30.0,
                        color: THEME,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'ลบแชท',
                      style: TextStyle(
                          color: THEME,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: THEME,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style:
                          TextStyle(color: THEME, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: THEME,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style:
                          TextStyle(color: THEME, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        itemRef.remove();
        break;
    }
  }

  sendMessage(String messageItem) {
    if (_txtCtrl.text != '' && _txtCtrl.text.length > 0) {
      Items message = new Items(
          messageItem.toString(), currentUser.email, uid, currentUser.uid);
      print(currentUser.uid);
      itemRef.push().set(message.toJson()
          //   {
          //   "message": _txtCtrl.text,
          //   "timestamp": DateTime.now().millisecondsSinceEpoch,
          //   "form": currentUser.email
          // }
          );
      _txtCtrl.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0.4,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[100],
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: (photoUser != "")
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(photoUser),
                      backgroundColor: Colors.grey[200],
                      minRadius: 30,
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 40.0,
                      color: Colors.grey,
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(color: Colors.black),
                ),
                // Text(
                //   'Online Now',
                //   style: TextStyle(
                //     color: Colors.grey[400],
                //     fontSize: 12,
                //   ),
                // )
              ],
            )
          ],
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: onItemMenuPress,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          choice.icon,
                          color: THEME,
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Text(
                          choice.title,
                          style: TextStyle(color: THEME),
                        ),
                      ],
                    ));
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: itemRef.onValue,
              builder: (context, snap) {
                if (snap.hasData &&
                    !snap.hasError &&
                    snap.data.snapshot.value != null) {
                  return FirebaseAnimatedList(
                    query: itemRef,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      return Message(
                        text: items[index].message,
                        from: items[index].form,
                        isMe: currentUser.email == items[index].form,
                      );
                    },
                  );
                } else
                  return Center(child: Text("No data"));
              },
            ),
          ),
          Container(
            color: Colors.grey[100],
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.blueGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.image,
                    color: Colors.blueGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter a Message...',
                      border: InputBorder.none,
                    ),
                    controller: _txtCtrl,
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: IconButton(
                    onPressed: () => sendMessage(_txtCtrl.text.toString()),
                    icon: Icon(
                      Icons.send,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Chat extends StatelessWidget {
//   final String peerId;
//   final String peerAvatar;

//   Chat({Key key, @required this.peerId, @required this.peerAvatar})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(
//           'CHAT',
//           style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: new ChatScreen(
//         peerId: peerId,
//         peerAvatar: peerAvatar,
//       ),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   final String peerId;
//   final String peerAvatar;

//   ChatScreen({Key key, @required this.peerId, @required this.peerAvatar})
//       : super(key: key);

//   @override
//   State createState() =>
//       new ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
// }

// class ChatScreenState extends State<ChatScreen> {
//   ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});

//   String peerId;
//   String peerAvatar;
//   String id;

//   var listMessage;
//   String groupChatId;
//   SharedPreferences prefs;

//   File imageFile;
//   bool isLoading;
//   bool isShowSticker;
//   String imageUrl;

//   final TextEditingController textEditingController =
//       new TextEditingController();
//   final ScrollController listScrollController = new ScrollController();
//   final FocusNode focusNode = new FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(onFocusChange);

//     groupChatId = '';

//     isLoading = false;
//     isShowSticker = false;
//     imageUrl = '';

//     readLocal();
//   }

//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }

//   readLocal() async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getString('id') ?? '';
//     if (id.hashCode <= peerId.hashCode) {
//       groupChatId = '$id-$peerId';
//     } else {
//       groupChatId = '$peerId-$id';
//     }

//     Firestore.instance
//         .collection('users')
//         .document(id)
//         .updateData({'chattingWith': peerId});

//     setState(() {});
//   }

//   void getSticker() {
//     // Hide keyboard when sticker appear
//     focusNode.unfocus();
//     setState(() {
//       isShowSticker = !isShowSticker;
//     });
//   }

//   void onSendMessage(String content, int type) {
//     // type: 0 = text, 1 = image, 2 = sticker
//     if (content.trim() != '') {
//       textEditingController.clear();

//       var documentReference = Firestore.instance
//           .collection('messages')
//           .document(groupChatId)
//           .collection(groupChatId)
//           .document(DateTime.now().millisecondsSinceEpoch.toString());

//       Firestore.instance.runTransaction((transaction) async {
//         await transaction.set(
//           documentReference,
//           {
//             'idFrom': id,
//             'idTo': peerId,
//             'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//             'content': content,
//             'type': type
//           },
//         );
//       });
//       listScrollController.animateTo(0.0,
//           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     } else {}
//   }

//   Widget buildItem(int index, DocumentSnapshot document) {
//     if (document['idFrom'] == id) {
//       // Right (my message)
//       return Row(
//         children: <Widget>[
//           document['type'] == 0
//               // Text
//               ? Container(
//                   child: Text(
//                     document['content'],
//                     style: TextStyle(color: Colors.blueGrey),
//                   ),
//                   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                   width: 200.0,
//                   decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(8.0)),
//                   margin: EdgeInsets.only(
//                       bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                       right: 10.0),
//                 )
//               : document['type'] == 1
//                   // Image
//                   ? Container(
//                       child: FlatButton(
//                         child: Material(
//                           child: CachedNetworkImage(
//                             placeholder: (context, url) => Container(
//                               child: CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.blueGrey),
//                               ),
//                               width: 200.0,
//                               height: 200.0,
//                               padding: EdgeInsets.all(70.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(8.0),
//                                 ),
//                               ),
//                             ),
//                             errorWidget: (context, url, error) => Material(
//                               child: Image.asset(
//                                 'images/img_not_available.jpeg',
//                                 width: 200.0,
//                                 height: 200.0,
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(8.0),
//                               ),
//                               clipBehavior: Clip.hardEdge,
//                             ),
//                             imageUrl: document['content'],
//                             width: 200.0,
//                             height: 200.0,
//                             fit: BoxFit.cover,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                           clipBehavior: Clip.hardEdge,
//                         ),
//                         onPressed: () {},
//                         padding: EdgeInsets.all(0),
//                       ),
//                       margin: EdgeInsets.only(
//                           bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                           right: 10.0),
//                     )
//                   // Sticker
//                   : Container(
//                       child: new Image.asset(
//                         'images/${document['content']}.gif',
//                         width: 100.0,
//                         height: 100.0,
//                         fit: BoxFit.cover,
//                       ),
//                       margin: EdgeInsets.only(
//                           bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                           right: 10.0),
//                     ),
//         ],
//         mainAxisAlignment: MainAxisAlignment.end,
//       );
//     } else {
//       // Left (peer message)
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 isLastMessageLeft(index)
//                     ? Material(
//                         child: CachedNetworkImage(
//                           placeholder: (context, url) => Container(
//                             child: CircularProgressIndicator(
//                               strokeWidth: 1.0,
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.blueGrey),
//                             ),
//                             width: 35.0,
//                             height: 35.0,
//                             padding: EdgeInsets.all(10.0),
//                           ),
//                           imageUrl: peerAvatar,
//                           width: 35.0,
//                           height: 35.0,
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(18.0),
//                         ),
//                         clipBehavior: Clip.hardEdge,
//                       )
//                     : Container(width: 35.0),
//                 document['type'] == 0
//                     ? Container(
//                         child: Text(
//                           document['content'],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                         width: 200.0,
//                         decoration: BoxDecoration(
//                             color: Colors.blueGrey,
//                             borderRadius: BorderRadius.circular(8.0)),
//                         margin: EdgeInsets.only(left: 10.0),
//                       )
//                     : document['type'] == 1
//                         ? Container(
//                             child: FlatButton(
//                               child: Material(
//                                 child: CachedNetworkImage(
//                                   placeholder: (context, url) => Container(
//                                     child: CircularProgressIndicator(
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                           Colors.blueGrey),
//                                     ),
//                                     width: 200.0,
//                                     height: 200.0,
//                                     padding: EdgeInsets.all(70.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(8.0),
//                                       ),
//                                     ),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Material(
//                                     child: Image.asset(
//                                       'images/img_not_available.jpeg',
//                                       width: 200.0,
//                                       height: 200.0,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(8.0),
//                                     ),
//                                     clipBehavior: Clip.hardEdge,
//                                   ),
//                                   imageUrl: document['content'],
//                                   width: 200.0,
//                                   height: 200.0,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8.0)),
//                                 clipBehavior: Clip.hardEdge,
//                               ),
//                               onPressed: () {},
//                               padding: EdgeInsets.all(0),
//                             ),
//                             margin: EdgeInsets.only(left: 10.0),
//                           )
//                         : Container(
//                             child: new Image.asset(
//                               'images/${document['content']}.gif',
//                               width: 100.0,
//                               height: 100.0,
//                               fit: BoxFit.cover,
//                             ),
//                             margin: EdgeInsets.only(
//                                 bottom: isLastMessageRight(index) ? 20.0 : 10.0,
//                                 right: 10.0),
//                           ),
//               ],
//             ),

//             // Time
//             isLastMessageLeft(index)
//                 ? Container(
//                     child: Text(
//                       DateFormat('dd MMM kk:mm').format(
//                           DateTime.fromMillisecondsSinceEpoch(
//                               int.parse(document['timestamp']))),
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12.0,
//                           fontStyle: FontStyle.italic),
//                     ),
//                     margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
//                   )
//                 : Container()
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//         margin: EdgeInsets.only(bottom: 10.0),
//       );
//     }
//   }

//   bool isLastMessageLeft(int index) {
//     if ((index > 0 &&
//             listMessage != null &&
//             listMessage[index - 1]['idFrom'] == id) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool isLastMessageRight(int index) {
//     if ((index > 0 &&
//             listMessage != null &&
//             listMessage[index - 1]['idFrom'] != id) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> onBackPress() {
//     if (isShowSticker) {
//       setState(() {
//         isShowSticker = false;
//       });
//     } else {
//       Firestore.instance
//           .collection('users')
//           .document(id)
//           .updateData({'chattingWith': null});
//       Navigator.pop(context);
//     }

//     return Future.value(false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       child: Stack(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               // List of messages
//               buildListMessage(),

//               // Sticker
//               (isShowSticker ? buildSticker() : Container()),

//               // Input content
//               buildInput(),
//             ],
//           ),

//           // Loading
//           buildLoading()
//         ],
//       ),
//       onWillPop: onBackPress,
//     );
//   }

//   Widget buildSticker() {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi1', 2),
//                 child: new Image.asset(
//                   'images/mimi1.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi2', 2),
//                 child: new Image.asset(
//                   'images/mimi2.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi3', 2),
//                 child: new Image.asset(
//                   'images/mimi3.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           ),
//           Row(
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi4', 2),
//                 child: new Image.asset(
//                   'images/mimi4.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi5', 2),
//                 child: new Image.asset(
//                   'images/mimi5.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi6', 2),
//                 child: new Image.asset(
//                   'images/mimi6.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           ),
//           Row(
//             children: <Widget>[
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi7', 2),
//                 child: new Image.asset(
//                   'images/mimi7.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi8', 2),
//                 child: new Image.asset(
//                   'images/mimi8.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               FlatButton(
//                 onPressed: () => onSendMessage('mimi9', 2),
//                 child: new Image.asset(
//                   'images/mimi9.gif',
//                   width: 50.0,
//                   height: 50.0,
//                   fit: BoxFit.cover,
//                 ),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           )
//         ],
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       ),
//       decoration: new BoxDecoration(
//           border:
//               new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
//           color: Colors.white),
//       padding: EdgeInsets.all(5.0),
//       height: 180.0,
//     );
//   }

//   Widget buildLoading() {
//     return Positioned(
//       child: isLoading
//           ? Container(
//               child: Center(
//                 child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
//               ),
//               color: Colors.white.withOpacity(0.8),
//             )
//           : Container(),
//     );
//   }

//   Widget buildInput() {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           // Button send image
//           Material(
//             child: new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 1.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.image),
//                 onPressed: () {},
//                 color: Colors.blueGrey,
//               ),
//             ),
//             color: Colors.white,
//           ),
//           Material(
//             child: new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 1.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.face),
//                 onPressed: getSticker,
//                 color: Colors.blueGrey,
//               ),
//             ),
//             color: Colors.white,
//           ),

//           // Edit text
//           Flexible(
//             child: Container(
//               child: TextField(
//                 style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
//                 controller: textEditingController,
//                 decoration: InputDecoration.collapsed(
//                   hintText: 'Type your message...',
//                   hintStyle: TextStyle(color: Colors.grey),
//                 ),
//                 focusNode: focusNode,
//               ),
//             ),
//           ),

//           // Button send message
//           Material(
//             child: new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 8.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.send),
//                 onPressed: () => onSendMessage(textEditingController.text, 0),
//                 color: Colors.blueGrey,
//               ),
//             ),
//             color: Colors.white,
//           ),
//         ],
//       ),
//       width: double.infinity,
//       height: 50.0,
//       decoration: new BoxDecoration(
//           border:
//               new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
//           color: Colors.white),
//     );
//   }

//   Widget buildListMessage() {
//     return Flexible(
//       child: StreamBuilder(
//         stream: Firestore.instance
//             .collection('messages')
//             .document(groupChatId)
//             .collection(groupChatId)
//             .orderBy('timestamp', descending: true)
//             .limit(20)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Center(
//                 child: CircularProgressIndicator(
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(Colors.blueGrey)));
//           } else {
//             listMessage = snapshot.data.documents;
//             return ListView.builder(
//               padding: EdgeInsets.all(10.0),
//               itemBuilder: (context, index) =>
//                   buildItem(index, snapshot.data.documents[index]),
//               itemCount: snapshot.data.documents.length,
//               reverse: true,
//               controller: listScrollController,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
