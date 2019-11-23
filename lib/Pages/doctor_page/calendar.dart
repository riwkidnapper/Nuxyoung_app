import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuxyoung/Pages/doctor_page/toolCalen.dart/event.dart';
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

class _CaLenDarState extends State<CaLenDar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List _onDayEvents;
  DateTime _selectedDay;
  DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _calendarController = CalendarController();
    _selectedDay = DateTime(_now?.year, _now?.month, _now?.day);
    _events = <DateTime, List>{};
    _onDayEvents = [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    // _calendarController.setSelectedDay(_selectedDay, runCallback: true);
  }

  void _onDaySelected(DateTime date, List event) {
    _selectedDay = date;
    _calendarController?.setCalendarFormat(CalendarFormat.month);
    setState(() {});
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
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("appointment").snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return _buildTableCalendar(context);
            }
            _buildData(data: snapshot.data);
            return _buildTableCalendar(context);
          }),
    );
  }

  void _buildData({
    QuerySnapshot data,
  }) async {
    _events?.clear();
    _onDayEvents?.clear();
    _events = <DateTime, List>{};
    if (data?.documents?.isNotEmpty ?? false) {
      data?.documents?.forEach((doc) {
        if (doc?.exists ?? false) {
          var dataTemp = doc.data;
          dataTemp["id"] = doc.documentID;
          final Event e = Event.fromMap(dataTemp);
          final DateTime _date =
              DateTime(e.date.year, e.date.month, e.date.day);
          if (_events[_date] == null) _events[_date] = [];
          _events[_date].add(e);
        }
      });
    }
    _onDayEvents = _events[_selectedDay] ?? [];
  }

  Widget _buildTableCalendar(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(bottom: 8.0),
          child: TableCalendar(
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
          )),
      EventView(events: _onDayEvents ?? [], onClick: (Event data) {}),
    ]);
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
}
