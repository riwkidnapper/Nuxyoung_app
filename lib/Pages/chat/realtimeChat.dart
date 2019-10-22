//Chat with Realtime datadase
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nuxyoung/Pages/chat/Tools/modal.dart';
import 'package:nuxyoung/Tebbar/Teb_iteam.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'Tools/messageUI.dart';
const String kTypeImage = 'image';
const String kTypeVideo = 'video';
// import 'package:firebase_core/firebase_core.dart'; not nessecary

class ChatReal extends StatefulWidget {
  
  final photoUser;
  final username;
  final uid;
  final fromUid;
  const ChatReal(
      {Key key, this.photoUser, this.username, this.uid, this.fromUid})
      : super(key: key);

  @override
  ChatRealState createState() => ChatRealState(
      photoUser: photoUser, username: username, uid: uid, fromUid: fromUid);
}

class ChatRealState extends State<ChatReal> {
  ChatRealState({
    @required this.photoUser,
    @required this.username,
    @required this.uid,
    @required this.fromUid,
  });
  final photoUser;
  final username;
  final uid;
  final fromUid;
  String chatUID;
  DatabaseReference itemRef;
  List<Items> items = List();
  Items message;
  File imageFile;
  bool isLoading;
  String imageUrl;
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
    chatUID = '';
    isLoading = false;
    imageUrl = '';
    if (uid.hashCode <= fromUid.hashCode) {
      chatUID = '$uid-$fromUid';
    } else {
      chatUID = '$fromUid-$uid';
    }

    message = Items("", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef =
        database.reference().child('messages').child('chat').child(chatUID);

    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  void _loadCurrentUser() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.currentUser = user;
      });
    });
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
      Items message =
          new Items(messageItem.toString(), currentUser.email, uid, fromUid);
      //print("จาก:" + fromUid + "chatID : " + chatUID);
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
////image
  // Future getImage() async {
  //   imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   if (imageFile != null) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     uploadFile();
  //   }
  // }

  // Future uploadFile() async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   StorageReference reference =
  //       FirebaseStorage.instance.ref().child("img").child(fileName);
  //   StorageUploadTask uploadTask = reference.putFile(imageFile);
  //   StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  //   storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
  //     imageUrl = downloadUrl;
  //     setState(() {
  //       isLoading = false;
  //       sendMessage(imageUrl);
  //     });
  //   }, onError: (err) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('This file is not an image');
  //   });
  // }

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
                  onPressed: () {} /*getImage*/,
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
