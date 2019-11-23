part of event;

class EventView extends StatelessWidget {
  final List events;
  final EventCallback onClick;

  EventView({
    Key key,
    this.events,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: events != null && events.isNotEmpty
          ? ListView(
              children: events
                  .map((event) => EventCard(
                        event: event,
                        onClick: onClick,
                      ))
                  .toList(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No Event',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: CupertinoColors.darkBackgroundGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'No event for this day.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: CupertinoColors.darkBackgroundGray,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
