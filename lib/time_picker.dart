import 'package:flutter/material.dart';

import 'constant.dart';
import 'scrollable_time_picker.dart';

enum TimePickType { hourOnly, hourAndMinute, completed }

enum DisplayType { dialog, bottomSheet }

class TimePicker {
  static Future<DateTime> pickTime(BuildContext context,
      {Color selectedColor,
        Color nonSelectedColor,
        double fontSize,
        TimePickType timePickType,
        bool isTwelveHourFormat,
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
                      isTwelveHourFormat: isTwelveHourFormat,
                    ),)
            );
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

  const TimePickerPage({Key key,
    this.selectedColor,
    this.nonSelectedColor,
    this.fontSize,
    this.timePickType,
    this.isTwelveHourFormat})
      : super(key: key);

  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _secondController = FixedExtentScrollController();
  TimePickType timeType;

  @override
  void initState() {
    timeType = widget.timePickType ?? TimePickType.completed;

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
              Navigator.pop(context, DateTime.now());
            },
            child: Text("Submit"),
            textColor: Colors.white,
            color: Colors.black,
          )
        ],
      ),
    );;
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
            dataList:
            widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat)
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
            dataList: widget.isTwelveHourFormat
                ? Constant.twelveHourFormat
                : Constant.twentyFourHourFormat),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize),
              textAlign: TextAlign.center),
        ),
        ScrollableTimePicker(
            controller: _minuteController,
            selectedColor: widget.selectedColor,
            nonSelectedColor: widget.nonSelectedColor,
            fontSize: widget.fontSize,
            dataList: Constant.minuteAndSecondFormat)
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
                dataList: widget.isTwelveHourFormat
                    ? Constant.twelveHourFormat
                    : Constant.twentyFourHourFormat)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize),
              textAlign: TextAlign.center),
        ),
        Expanded(
            child: ScrollableTimePicker(
                controller: _minuteController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                dataList: Constant.minuteAndSecondFormat)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(":",
              style: TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize),
              textAlign: TextAlign.center),
        ),
        Expanded(
            child: ScrollableTimePicker(
                controller: _secondController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                dataList: Constant.minuteAndSecondFormat)),
      ],
    );
  }
}
