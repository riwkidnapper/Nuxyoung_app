// //Chat with Cloud Firestore
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';

// class Chat extends StatefulWidget {
//   final FirebaseUser user;
//   final photoUser;
//   final username;
//   const Chat({Key key, this.user, this.photoUser, this.username})
//       : super(key: key);

//   @override
//   _ChatState createState() =>
//       _ChatState(photoUser: photoUser, username: username);
// }

// class _ChatState extends State<Chat> {
//   final Firestore _firestore = Firestore.instance;
//   TextEditingController messageController = TextEditingController();
//   ScrollController scrollController = ScrollController();

//   _ChatState({
//     @required this.photoUser,
//     @required this.username,
//   });
//   final photoUser;
//   final username;

//   Future<void> callback() async {
//     if (messageController.text.length > 0) {
//       await _firestore.collection('messages').add({
//         'text': messageController.text,
//         'from': widget.user.email,
//         'date': DateTime.now().toIso8601String().toString(),
//       });
//       messageController.clear();
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         curve: Curves.easeOut,
//         duration: const Duration(milliseconds: 300),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.4,
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Row(
//           children: <Widget>[
//             Container(
//               width: 40,
//               height: 40,
//               margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
//               child: (photoUser != "")
//                   ? CircleAvatar(
//                       backgroundImage: NetworkImage(photoUser),
//                       backgroundColor: Colors.grey[200],
//                       minRadius: 30,
//                     )
//                   : Icon(
//                       Icons.account_circle,
//                       size: 40.0,
//                       color: Colors.grey,
//                     ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   username,
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 // Text(
//                 //   'Online Now',
//                 //   style: TextStyle(
//                 //     color: Colors.grey[400],
//                 //     fontSize: 12,
//                 //   ),
//                 // )
//               ],
//             )
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('messages')
//                     .orderBy('date')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData)
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );

//                   List<DocumentSnapshot> docs = snapshot.data.documents;

//                   List<Widget> messages = docs
//                       .map((doc) => Message(
//                             from: doc.data['from'],
//                             text: doc.data['text'],
//                             me: widget.user.email == doc.data['from'],
//                           ))
//                       .toList();

//                   return ListView(
//                     controller: scrollController,
//                     children: <Widget>[
//                       ...messages,
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Container(
//               color: Colors.grey[200],
//               child: Row(
//                 children: <Widget>[
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.camera_alt,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.image,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onSubmitted: (value) => callback(),
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         hintText: 'Enter a Message...',
//                         border: InputBorder.none,
//                       ),
//                       controller: messageController,
//                     ),
//                   ),
//                   SendButton(
//                     callback: callback,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SendButton extends StatelessWidget {
//   final String text;
//   final VoidCallback callback;

//   const SendButton({Key key, this.text, this.callback}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: callback,
//       icon: Icon(
//         Icons.send,
//         color: Colors.blueGrey,
//       ),
//     );
//   }
// }

// class Message extends StatelessWidget {
//   final String from;
//   final String text;

//   final bool me;

//   const Message({Key key, this.from, this.text, this.me}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
//       child: Container(
//         child: Column(
//           crossAxisAlignment:
//               me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               from,
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Material(
//               color: me ? Colors.blueGrey : Colors.grey[300],
//               borderRadius: BorderRadius.circular(10.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                 child: Text(text,
//                     style: me
//                         ? TextStyle(color: Colors.white)
//                         : TextStyle(color: Colors.black)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
