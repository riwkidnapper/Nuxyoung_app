//part of item;

// class AboutPopup extends StatefulWidget {
//   @override
//   _AboutDialogState createState() => _AboutDialogState();
// }

// class _AboutDialogState extends State<AboutPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return new AlertDialog(
//       title: const Text('About Pop up'),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           _buildAboutText(),
//           _buildLogoAttribution(),
//         ],
//       ),
//       actions: <Widget>[
//         new FlatButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           textColor: Theme.of(context).primaryColor,
//           child: const Text('Okay, got it!'),
//         ),
//       ],
//     );
//   }

//   Widget _buildAboutText() {
//     return new RichText(
//       text: new TextSpan(
//         text:
//             'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n',
//         style: const TextStyle(color: Colors.black87),
//         children: <TextSpan>[
//           const TextSpan(text: 'The app was developed with '),
//           new TextSpan(
//             text: 'Flutter',
// /*recognizer: _flutterTapRecognizer,
//           style: linkStyle,*/
//           ),
//           const TextSpan(
//             text: ' and it\'s open source; check out the source '
//                 'code yourself from ',
//           ),
//           new TextSpan(
//             text: 'www.codesnippettalk.com',
// /*recognizer: _githubTapRecognizer,
//           style: linkStyle,*/
//           ),
//           const TextSpan(text: '.'),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogoAttribution() {
//     return new Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: new Row(
//         children: <Widget>[
//           new Padding(
//             padding: const EdgeInsets.only(top: 0.0),
// //            child: new Image.asset(
// //              //"assets/flutter.png",
// //              width: 32.0,
// //            ),
//           ),
//           const Expanded(
//             child: const Padding(
//               padding: const EdgeInsets.only(left: 12.0),
//               child: const Text(
//                 'Popup window is like a dialog box that gains complete focus when it appears on screen.',
//                 style: const TextStyle(fontSize: 12.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
