import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/doctor_page/toolCalen.dart/table_calendar.dart';

// Example holidays
// final Map<DateTime, List> _holidays = {
//   DateTime(2020, 1, 1): ['New Year\'s Day'],
//   DateTime(2019, 1, 6): ['Epiphany'],
//   DateTime(2019, 2, 14): ['Valentine\'s Day'],
//   DateTime(2019, 4, 21): ['Easter Sunday'],
//   DateTime(2019, 4, 22): ['Easter Monday'],
// };

/*void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}*/

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CaLenDar(),
    );
  }
}

class CaLenDar extends StatefulWidget {
  CaLenDar({
    Key key,
  }) : super(key: key);

  @override
  _CaLenDarState createState() => _CaLenDarState();
}

class _CaLenDarState extends State<CaLenDar> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 1)): ['Event A3', 'Event B3'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 3)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ตารางเวรแพทย์",
          style: TextStyle(color: Colors.blueGrey[800]),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'th_TH',
      calendarController: _calendarController,
      events: _events,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'month',
        CalendarFormat.week: 'week',
      },
      calendarStyle: CalendarStyle(
          selectedColor: Colors.redAccent[100],
          todayColor: Colors.blueGrey[400],
          markersColor: Colors.blueGrey[900],
          outsideDaysVisible: true),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 18.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Container(
                height: 30.0,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.white
            : _calendarController.isToday(date) ? Colors.white : Colors.grey,
      ),
      width: 8.0,
      height: 8.0,
      child: Center(
        child: Text(
          '',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Column(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      title: Text(event.toString()),
                      onTap: () => print('$event tapped!'),
                    ),
                  )
                ],
              ))
          .toList(),
    );
  }
}
