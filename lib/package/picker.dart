import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:nuxyoung/Auth/login_page.dart';

class DatePicker extends StatelessWidget {

  final String title;
  final DateTime currentDate;
  final void Function(DateTime) onSelect;

  DatePicker({
    Key key,
    this.title,
    this.currentDate,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: currentDate ?? DateTime.now(),
                    onDateTimeChanged: onSelect,
                    use24hFormat: true,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    DateFormat.yMMMMd().format(currentDate),
                    style: const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatelessWidget {
  final String title;
  final DateTime currentTime;
  final void Function(DateTime) onSelect;

  TimePicker({
    Key key,
    this.title,
    this.currentTime,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  50.0,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: currentTime ?? DateTime.now(),
                    onDateTimeChanged: onSelect,
                    use24hFormat: true,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat.Hm().format(currentTime ?? DateTime.now()),
                    style: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateAndTimePicker extends StatelessWidget {

  final String title;
  final DateTime currentDateAndTime;
  final void Function(DateTime) onSelect;

  DateAndTimePicker({
    Key key,
    this.title,
    this.currentDateAndTime,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.white, 
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: currentDateAndTime ?? DateTime.now(),
                    onDateTimeChanged: onSelect,
                    use24hFormat: true,
                  ),
                  title: title ?? ' ',
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    title ?? ' ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().add_Hm().format(currentDateAndTime),
                    style: const TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

Widget _buildMenu(List<Widget> children) {
  return Container(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    ),
  );
}

Widget _buildBottomPicker(Widget picker, {String title, BuildContext context}) {
  return Container(
    height: 268.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18.0),
        topRight: Radius.circular(18.0),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: DefaultTextStyle(
            style: TextStyle(
              color: CupertinoColors.inactiveGray,
              fontSize: 18.0,
            ),
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 18.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
            child: GestureDetector(
              onTap: () { },
              child: SafeArea(
                child: picker,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
