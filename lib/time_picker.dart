import 'package:flutter/material.dart';

import 'constant.dart';
import 'scrollable_time_picker.dart';
import 'package:intl/intl.dart';

enum TimePickType { hourOnly, hourAndMinute, completed }

enum DisplayType { dialog, bottomSheet }

class TimePicker {
  static Future<DateTime> pickTime(BuildContext context,
      {Color selectedColor,
      Color nonSelectedColor,
      double fontSize,
      TimePickType timePickType,
      bool isTwelveHourFormat,
      Function(DateTime time) callback,
      DisplayType displayType}) async {
    var result;

    DisplayType displays = displayType ?? DisplayType.bottomSheet;
    if (displays == DisplayType.dialog) {
      result = await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                child: Container(
              child: TimePickerPage(
                selectedColor: selectedColor,
                nonSelectedColor: nonSelectedColor,
                fontSize: fontSize,
                timePickType: timePickType,
                callback: callback,
                isTwelveHourFormat: isTwelveHourFormat,
              ),
            ));
          });
    } else if (displays == DisplayType.bottomSheet) {
      result = await showModalBottomSheet(
          context: context,
          builder: (context) {
            return TimePickerPage(
              selectedColor: selectedColor,
              nonSelectedColor: nonSelectedColor,
              fontSize: fontSize,
              timePickType: timePickType,
              callback: callback,
              isTwelveHourFormat: isTwelveHourFormat,
            );
          });
    }

    return result;
  }
}

class TimePickerPage extends StatefulWidget {
  final Color selectedColor;
  final Color nonSelectedColor;
  final double fontSize;
  final TimePickType timePickType;
  final bool isTwelveHourFormat;
  final Function(DateTime time) callback;

  const TimePickerPage(
      {Key key,
      this.selectedColor,
      this.nonSelectedColor,
      this.fontSize,
      this.timePickType,
      this.isTwelveHourFormat,
      this.callback})
      : super(key: key);

  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _secondController = FixedExtentScrollController();
  TimePickType timeType;
  int _hour;

  int _minute = 0;
  int _second = 0;
  String ampm;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    timeType = widget.timePickType ?? TimePickType.completed;
    ampm = "AM";
    _hour = widget.isTwelveHourFormat ? Constant.twelveHourFormat[0] : Constant.twentyFourHourFormat[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget timePickerWidget;
    if (timeType == TimePickType.hourOnly) {
      timePickerWidget = _hourOnlyWidget();
    } else if (timeType == TimePickType.hourAndMinute) {
      timePickerWidget = _hourAndMinutesWidget();
    } else if (timeType == TimePickType.completed) {
      timePickerWidget = _hourMinuteSecondWidget();
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          timePickerWidget,
          RaisedButton(
            onPressed: () {
              print("gua disini");
              print("${widget.callback}");
              Navigator.pop(context, DateTime.now());
            },
            child: Text("Submit"),
            textColor: Colors.white,
            color: Colors.black,
          )
        ],
      ),
    );
    ;
  }

  Widget _hourOnlyWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ScrollableTimePicker(
            controller: _hourController,
            selectedColor: widget.selectedColor,
            nonSelectedColor: widget.nonSelectedColor,
            fontSize: widget.fontSize,
            callback: (result) {
              _hour = result;
              int day = _now.day;
              if (widget.isTwelveHourFormat) {
                _hour = _hour == 12 ? 0 : _hour;
                if (ampm == "PM") {
                  if (_hour != 0) _hour = _hour + 12;
                  if (_hour == 0) day = _now.day + 1;
                }
              }
              widget.callback(DateTime(_now.year, _now.month, day, _hour, _minute, _second));
            },
            dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat),
        widget.isTwelveHourFormat
            ? Column(
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          ampm = "AM";
                        });
                      },
                      child: Text("AM"),
                      color: ampm == "AM" ? widget.selectedColor : null),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          ampm = "PM";
                        });
                      },
                      child: Text("PM"),
                      color: ampm == "PM" ? widget.selectedColor : null),
                ],
              )
            : Container()
      ],
    );
  }

  Widget _hourAndMinutesWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ScrollableTimePicker(
            controller: _hourController,
            selectedColor: widget.selectedColor,
            nonSelectedColor: widget.nonSelectedColor,
            fontSize: widget.fontSize,
            callback: (result) {
              _hour = result;
              int day = _now.day;
              if (widget.isTwelveHourFormat) {
                _hour = _hour == 12 ? 0 : _hour;
                if (ampm == "PM") {
                  if (_hour != 0) _hour = _hour + 12;
                  if (_hour == 0) day = _now.day + 1;
                }
              }
              widget.callback(DateTime(_now.year, _now.month, day, _hour, _minute, _second));
            },
            dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize), textAlign: TextAlign.center),
        ),
        ScrollableTimePicker(
            controller: _minuteController,
            selectedColor: widget.selectedColor,
            nonSelectedColor: widget.nonSelectedColor,
            fontSize: widget.fontSize,
            callback: (result) {
              _minute = result;
              int day = _now.day;
              if (widget.isTwelveHourFormat) {
                _hour = _hour == 12 ? 0 : _hour;
                if (ampm == "PM") {
                  if (_hour != 0) _hour = _hour + 12;
                  if (_hour == 0) day = _now.day + 1;
                }
              }
              widget.callback(DateTime(_now.year, _now.month, day, _hour, _minute, _second));
            },
            dataList: Constant.minuteAndSecondFormat),
        widget.isTwelveHourFormat
            ? Column(
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          ampm = "AM";
                        });
                      },
                      child: Text("AM"),
                      color: ampm == "AM" ? widget.selectedColor : null),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          ampm = "PM";
                        });
                      },
                      child: Text("PM"),
                      color: ampm == "PM" ? widget.selectedColor : null),
                ],
              )
            : Container()
      ],
    );
  }

  Widget _hourMinuteSecondWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: ScrollableTimePicker(
                controller: _hourController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                callback: (result) {
                  _hour = result;
                  int day = _now.day;
                  if (widget.isTwelveHourFormat) {
                    _hour = _hour == 12 ? 0 : _hour;
                    if (ampm == "PM") {
                      if (_hour != 0) _hour = _hour + 12;
                      if (_hour == 0) day = _now.day + 1;
                    }
                  }
                  widget.callback(DateTime(_now.year, _now.month, day, _hour, _minute, _second));
                },
                dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize), textAlign: TextAlign.center),
        ),
        Expanded(
            child: ScrollableTimePicker(
                controller: _minuteController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                callback: (result) {
                  _minute = result;
                  int day = _now.day;
                  if (widget.isTwelveHourFormat) {
                    _hour = _hour == 12 ? 0 : _hour;
                    if (ampm == "PM") {
                      if (_hour != 0) _hour = _hour + 12;
                      if (_hour == 0) day = _now.day + 1;
                    }
                  }
                  widget.callback(DateTime(_now.year, _now.month, day, _hour, _minute, _second));
                },
                dataList: Constant.minuteAndSecondFormat)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize), textAlign: TextAlign.center),
        ),
        Expanded(
            child: ScrollableTimePicker(
                controller: _secondController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                callback: (result) {
                  _second = result;
                  int day = _now.day;
                  if (widget.isTwelveHourFormat) {
                    _hour = _hour == 12 ? 0 : _hour;
                    if (ampm == "PM") {
                      if (_hour != 0) _hour = _hour + 12;
                      if (_hour == 0) day = _now.day + 1;
                    }
                  }
                  widget.callback(DateTime(_now.year, _now.month, day, _hour, _minute, _second));
                },
                dataList: Constant.minuteAndSecondFormat)),
        widget.isTwelveHourFormat
            ? Column(
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          ampm = "AM";
                        });
                      },
                      child: Text("AM"),
                      color: ampm == "AM" ? widget.selectedColor : null),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          ampm = "PM";
                        });
                      },
                      child: Text("PM"),
                      color: ampm == "PM" ? widget.selectedColor : null),
                ],
              )
            : Container()
      ],
    );
  }
}
