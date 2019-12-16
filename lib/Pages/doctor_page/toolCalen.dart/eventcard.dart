part of event;

class EventCard extends StatelessWidget {
  final Event event;
  final EventCallback onClick;

  EventCard({
    Key key,
    this.event,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String time = DateFormat('kk:mm').format(event.date);
    return GestureDetector(
      onTap: this.onClick != null ? () => this.onClick(event) : () {},
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Divider(
              color: Colors.black26,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  event?.name?.toString() ?? "",
                ),
                Text(
                  "เวลา :: " + time +" น. "?? "",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
