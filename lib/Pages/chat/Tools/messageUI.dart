part of tool;

class Message extends StatelessWidget {
  final String text;
  final String from;
  final bool isMe;
  const Message({
    Key key,
    this.text,
    this.from,
    this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
      child: Container(
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              from,
            ),
            SizedBox(
              height: 5.0,
            ),
            Material(
              color: isMe ? Colors.blueGrey : Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(text,
                    style: isMe
                        ? TextStyle(color: Colors.white)
                        : TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
