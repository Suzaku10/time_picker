import 'package:flutter/material.dart';

import 'constant.dart';
import 'scrollable_time_picker.dart';

enum timePickType { hourOnly, hourAndMinute, completed }

class TimePicker extends StatefulWidget {
  final Color selectedColor;
  final Color nonSelectedColor;
  final double fontSize;
  final timePickType timetype;
  final bool isTwelveHourFormat;

  const TimePicker(
      {Key key, this.selectedColor, this.nonSelectedColor, this.fontSize, this.timetype, this.isTwelveHourFormat})
      : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _secondController = FixedExtentScrollController();
  timePickType timeType;

  @override
  void initState() {
    timeType = widget.timetype ?? timePickType.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (timeType == timePickType.hourOnly) {
      return _hourOnlyWidget();
    } else if (timeType == timePickType.hourAndMinute) {
      return _hourAndMinutesWidget();
    } else if (timeType == timePickType.completed) {
      return _hourMinuteSecondWidget();
    }
  }

  Widget _hourOnlyWidget() {
    return ScrollableTimePicker(
        controller: _hourController,
        selectedColor: widget.selectedColor,
        nonSelectedColor: widget.nonSelectedColor,
        fontSize: widget.fontSize,
        dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat);
  }

  Widget _hourAndMinutesWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child: ScrollableTimePicker(
                controller: _hourController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat)),
        Expanded(
            child: ScrollableTimePicker(
                controller: _minuteController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                dataList: Constant.minuteAndSecondFormat))
      ],
    );
  }

  Widget _hourMinuteSecondWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child: ScrollableTimePicker(
                controller: _hourController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                dataList: widget.isTwelveHourFormat ? Constant.twelveHourFormat : Constant.twentyFourHourFormat)),
        Expanded(
            child: ScrollableTimePicker(
                controller: _minuteController,
                selectedColor: widget.selectedColor,
                nonSelectedColor: widget.nonSelectedColor,
                fontSize: widget.fontSize,
                dataList: Constant.minuteAndSecondFormat)),
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
