import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';


// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

/*void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}*/

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CaLenDar(title: 'Table Calendar'),
    );
  }
}

class CaLenDar extends StatefulWidget {
  CaLenDar({Key key, @required this.title}) : super(key: key);

  final String title;

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

      _selectedDay.subtract(Duration(days: 30)): [],
      _selectedDay.subtract(Duration(days: 27)): [],
      _selectedDay.subtract(Duration(days: 20)): [],
      _selectedDay.subtract(Duration(days: 16)): [],
      _selectedDay.subtract(Duration(days: 10)): [],
      _selectedDay.subtract(Duration(days: 4)): [],
      _selectedDay.subtract(Duration(days: 2)): [],
      _selectedDay: ['ตรวจ 09:30 นาฬิกา'],
      _selectedDay.add(Duration(days: 1)): [],
      _selectedDay.add(Duration(days: 3)): Set.from([]).toList(),
      _selectedDay.add(Duration(days: 4)): ['ตรวจ 09:30 นาฬิกา'],
      _selectedDay.add(Duration(days: 7)): [],
      _selectedDay.add(Duration(days: 11)): [],
      _selectedDay.add(Duration(days: 15)): [],
      _selectedDay.add(Duration(days: 22)): [],
      _selectedDay.add(Duration(days: 26)): [],

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
        title: Text(widget.title ?? 'Calendar'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          /*const SizedBox(height: 8.0),
          _buildButtons(),*/
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'month',
        CalendarFormat.week: 'week',
      },
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)


  // Widget _buildButtons() {
  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           RaisedButton(
  //             child: Text('month'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController.setCalendarFormat(CalendarFormat.month);
  //               });
  //             },
  //           ),
  //           RaisedButton(
  //             child: Text('week'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController.setCalendarFormat(CalendarFormat.week);
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 8.0),
  //       RaisedButton(
  //         child: Text('setDay 10-07-2019'),
  //         onPressed: () {
  //           _calendarController.setSelectedDay(DateTime(2019, 7, 10),
  //               runCallback: true);
  //         },
  //       ),
  //     ],
  //   );
  // }


  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
