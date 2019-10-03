import 'package:flutter/material.dart';

import 'constant.dart';
import 'scrollable_time_picker.dart';

enum TimePickType { hour, hourMinute, hourMinuteSecond }

enum DisplayType { dialog, bottomSheet }

class TimePicker {
  static Future<DateTime> pickTime(BuildContext context,
      {Color selectedColor = Colors.amber,
      Color nonSelectedColor = Colors.black,
      double fontSize = 24,
      TimePickType timePickType = TimePickType.hourMinuteSecond,
      bool isTwelveHourFormat = false,
      String buttonName = "Submit",
      String title,
      TextStyle buttonTextStyle,
      TextStyle titleTextStyle,
      Color buttonBackgroundColor,
      DisplayType displayType = DisplayType.bottomSheet}) async {
    assert(fontSize > 0 && fontSize <= 30);
    if (buttonTextStyle != null) assert(buttonTextStyle.fontSize > 0 && buttonTextStyle.fontSize <= 30);
    if (titleTextStyle != null) assert(titleTextStyle.fontSize > 0 && titleTextStyle.fontSize <= 30);
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
                buttonName: buttonName,
                title: title,
                titleTextStyle: titleTextStyle,
                buttonBackgroundColor: buttonBackgroundColor,
                buttonTextStyle: buttonTextStyle,
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
              title: title,
              titleTextStyle: titleTextStyle,
              buttonName: buttonName,
              buttonBackgroundColor: buttonBackgroundColor,
              buttonTextStyle: buttonTextStyle,
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
  final String buttonName;
  final String title;
  final TextStyle titleTextStyle;
  final TextStyle buttonTextStyle;
  final Color buttonBackgroundColor;

  const TimePickerPage(
      {Key key,
      this.selectedColor,
      this.nonSelectedColor,
      this.fontSize,
      this.timePickType,
      this.isTwelveHourFormat,
      this.buttonName,
      this.buttonTextStyle,
      this.buttonBackgroundColor,
      this.title,
      this.titleTextStyle})
      : super(key: key);

  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _secondController = FixedExtentScrollController();
  int _hour;
  int _minute = 0;
  int _second = 0;
  String ampm;
  DateTime _now = DateTime.now();
  DateTime _result;

  @override
  void initState() {
    if (widget.isTwelveHourFormat) ampm = "AM";
    _hour = widget.isTwelveHourFormat ? Constant.twelveHourFormat[0] : Constant.twentyFourHourFormat[0];
    _result = DateTime(_now.year, _now.month, _now.day, _hour, _minute, _second);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget timePickerWidget;
    if (widget.timePickType == TimePickType.hour) {
      timePickerWidget = _hourWidget();
    } else if (widget.timePickType == TimePickType.hourMinute) {
      timePickerWidget = _hourMinutesWidget();
    } else if (widget.timePickType == TimePickType.hourMinuteSecond) {
      timePickerWidget = _hourMinuteSecondWidget();
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(widget.title ?? "Title",
                      style: widget.titleTextStyle == null
                          ? TextStyle(fontSize: 24, fontWeight: FontWeight.w400)
                          : widget.titleTextStyle)),
              InkWell(
                child: Icon(Icons.close,
                    size: widget.titleTextStyle?.fontSize ?? 30, color: widget.titleTextStyle?.color ?? Colors.black),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          timePickerWidget,
          FlatButton(
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                _setResult();
                Navigator.pop(context, _result);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Container(
                  child: Text(widget.buttonName,
                      style: widget.buttonTextStyle ?? TextStyle(color: widget.nonSelectedColor)),
                  alignment: Alignment.center,
                  width: double.infinity),
              color: widget.buttonBackgroundColor ?? widget.selectedColor)
        ],
      ),
    );
    ;
  }

  Widget _hourWidget() {
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
            },
            dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat),
        widget.isTwelveHourFormat ? _twelveHourFormatButton() : Container()
      ],
    );
  }

  Widget _hourMinutesWidget() {
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
            },
            dataList: Constant.minuteAndSecondFormat),
        widget.isTwelveHourFormat ? _twelveHourFormatButton() : Container()
      ],
    );
  }

  Widget _hourMinuteSecondWidget() {
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
            },
            dataList: Constant.minuteAndSecondFormat),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize), textAlign: TextAlign.center),
        ),
        ScrollableTimePicker(
            controller: _secondController,
            selectedColor: widget.selectedColor,
            nonSelectedColor: widget.nonSelectedColor,
            fontSize: widget.fontSize,
            callback: (result) {
              _second = result;
            },
            dataList: Constant.minuteAndSecondFormat),
        widget.isTwelveHourFormat ? _twelveHourFormatButton() : Container()
      ],
    );
  }

  void _setResult() {
    int day = _now.day;
    if (widget.isTwelveHourFormat) {
      _hour = _hour == 12 ? 0 : _hour;
      if (ampm == "PM") {
        if (_hour != 0) _hour = _hour + 12;
        if (_hour == 0) day = _now.day + 1;
      }
    }
    _result = DateTime(_now.year, _now.month, day, _hour, _minute, _second);
  }

  Widget _twelveHourFormatButton() {
    return Container(
        child: Column(
          children: <Widget>[
            RawMaterialButton(
                constraints: BoxConstraints(),
                onPressed: () {
                  setState(() {
                    ampm = "AM";
                  });
                },
                fillColor: ampm == "AM" ? widget.selectedColor : null,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('AM', style: TextStyle(fontSize: widget.fontSize))),
            RawMaterialButton(
                constraints: BoxConstraints(),
                onPressed: () {
                  setState(() {
                    ampm = "PM";
                  });
                },
                fillColor: ampm == "PM" ? widget.selectedColor : null,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('PM', style: TextStyle(fontSize: widget.fontSize))),
            /*   FlatButton(
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
                color: ampm == "PM" ? widget.selectedColor : null),*/
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.0));
  }
}
