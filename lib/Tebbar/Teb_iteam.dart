import 'package:flutter/material.dart';

import 'bomtombar.dart';

class TabItem extends StatefulWidget {
  TabItem({
    @required this.selected,
    @required this.iconData,
    @required this.title,
    @required this.callbackFunction,
  });
  final String title;
  final IconData iconData;
  final bool selected;
  final Function callbackFunction;
  @override
  _TabItemState createState() => _TabItemState();
}

const double TEXT_OFF = 1;
const double TEXT_ON = 1;
const double ALPHA_OFF = 1;
const double ALPHA_ON = 1; //แสดง
const int ANIM_DURATION = 300;
const Color THEME = Color(0xFF607D8B);
const Color BLACK12 = Color(0xFFE0E0E0);

class _TabItemState extends State<TabItem> {
  double textYAlign = TEXT_OFF;
  double iconAlpha = ALPHA_ON;
  Color textColor;

  @override
  void initState() {
    super.initState();
    _setIconTextAlpha();
  }

  @override
  void didUpdateWidget(TabItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setIconTextAlpha();
  }

  _setIconTextAlpha() {
    setState(() {
      textYAlign = (widget.selected) ? TEXT_OFF : TEXT_ON;
      iconAlpha = (widget.selected) ? ALPHA_OFF : ALPHA_ON;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
                duration: Duration(milliseconds: ANIM_DURATION),
                alignment: Alignment(0, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (widget.selected)
                      ? DefaultTextStyle(
                          style: TextStyle(
                            color: THEME,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Text(widget.title))
                      : DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          child: Text(widget.title)),
                )),
          ),
          Container(
            child: AnimatedAlign(
                duration: Duration(milliseconds: ANIM_DURATION),
                curve: Curves.easeIn,
                alignment: Alignment(0.0, 0.0), //ความสูงicon
                child: (widget.selected)
                    ? AnimatedOpacity(
                        duration: Duration(milliseconds: ANIM_DURATION),
                        opacity: iconAlpha,
                        child: (currentSelected == 2)
                            ? IconButton(
                                color: THEME,
                                padding: EdgeInsets.all(0),
                                alignment: Alignment(0, -3.5),
                                icon: Icon(
                                  widget.iconData,
                                ),
                                onPressed: () {
                                  widget.callbackFunction();
                                },
                              )
                            : IconButton(
                                color: THEME,
                                padding: EdgeInsets.all(0),
                                alignment: Alignment(0, 0.2),
                                icon: Icon(
                                  widget.iconData,
                                ),
                                onPressed: () {
                                  widget.callbackFunction();
                                },
                              ),
                      )
                    : AnimatedOpacity(
                        duration: Duration(milliseconds: ANIM_DURATION),
                        opacity: iconAlpha,
                        child: (currentSelected == 2)
                            ? IconButton(
                                padding: EdgeInsets.all(0),
                                alignment: Alignment(0, 0.2),
                                icon: Icon(
                                  widget.iconData,
                                ),
                                onPressed: () {
                                  widget.callbackFunction();
                                },
                              )
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                alignment: Alignment(0, 0.2),
                                icon: Icon(
                                  widget.iconData,
                                ),
                                onPressed: () {
                                  widget.callbackFunction();
                                },
                              ),
                      )),
          ),
        ],
      ),
    );
  }
}
