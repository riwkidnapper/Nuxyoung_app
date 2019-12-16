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
          : Container(),
    );
  }
}
