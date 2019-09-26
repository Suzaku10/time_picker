import 'package:flutter/material.dart';

import 'constant.dart';

enum timeType { hour, minute, second }

class TimePicker extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final double fontSize;
  final bool hourOnly;
  final bool minuteOnly;
  final bool secondOnly;

  const TimePicker(
      {Key key, this.primaryColor, this.secondaryColor, this.fontSize, this.hourOnly, this.minuteOnly, this.secondOnly})
      : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();
  FixedExtentScrollController _secondController = FixedExtentScrollController();
  int _hour = 0;
  int _minute = 0;
  int _second = 0;
  double lerps = 0;
  double _itemExtent;

  @override
  void initState() {
    _itemExtent = widget.fontSize + 10;
    _hourController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    setState(() {
      lerps = (_hourController.offset.round() % _itemExtent) / (_itemExtent);
    });
  }
  @override
  Widget build(BuildContext context) {
    return _build();
  }

  Widget _build() {
    return Stack(
      children: <Widget>[
//        Center(child: Container(constraints: BoxConstraints.expand(height: widget.itemExtent), color: Colors.blue)),
        Positioned.fill(
            child: ListWheelScrollView.useDelegate(
                controller: _hourController,
                itemExtent: _itemExtent,
                diameterRatio: 1.2,
                clipToSize: false,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: ((selected) {
                  _hour = selected;
                }),
                childDelegate: ListWheelChildLoopingListDelegate(children: _children(Constant.twelveHourFormat))))
      ],
    );
  }

  List<Widget> _children(List<dynamic> list) {
    return List.generate(list.length, (index) {
      return Center(
          child: AnimatedDefaultTextStyle(
              child: Text(index.toString()),
              style: _hour == index
                  ? TextStyle(
                      color: Color.lerp(widget.secondaryColor, widget.primaryColor, lerps < 0.5 ? lerps : 1 - lerps),
                      fontWeight: FontWeight.w800,
                      fontSize: widget.fontSize)
                  : TextStyle(color: widget.primaryColor, fontSize: widget.fontSize * 0.80),
              duration: Duration(milliseconds: 100)));
    });
  }

/*  Widget _buildHour() {
    return Stack(
      children: <Widget>[
        Center(child: Container(constraints: BoxConstraints.expand(height: widget.itemExtent), color: Colors.blue)),
        Positioned.fill(
            child: ListWheelScrollView.useDelegate(
                controller: _controller,
                itemExtent: widget.itemExtent,
                diameterRatio: 1.2,
                clipToSize: false,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: ((tes) {
                  tesdong = tes;
                }),
                childDelegate: ListWheelChildLoopingListDelegate(children: _children(Constant.twelveHourFormat))))
      ],
    );
  }*/

//  Widget _buildMinute() {
//    return Stack(
//      children: <Widget>[
//        Center(child: Container(constraints: BoxConstraints.expand(height: widget.itemExtent), color: Colors.blue)),
//        Positioned.fill(
//            child: ListWheelScrollView.useDelegate(
//                controller: _controller,
//                itemExtent: widget.itemExtent,
//                diameterRatio: 1.2,
//                clipToSize: false,
//                physics: const FixedExtentScrollPhysics(),
//                onSelectedItemChanged: ((tes) {
//                  tesdong = tes;
//                }),
//                childDelegate: ListWheelChildLoopingListDelegate(children: _children(Constant.minuteAndSecondFormat))))
//      ],
//    );
//  }

//  List<Widget> _children(List<dynamic> list) {
//    return List.generate(list.length, (index) {
//      return Center(
//          child: AnimatedDefaultTextStyle(
//              child: Text(index.toString()),
//              style: tesdong == index
//                  ? TextStyle(
//                      color: Color.lerp(widget.secondaryColor, widget.primaryColor, lerps < 0.5 ? lerps : 1 - lerps),
//                      fontWeight: FontWeight.w800,
//                      fontSize: 24)
//                  : TextStyle(color: widget.primaryColor, fontSize: 15),
//              duration: Duration(milliseconds: 100)));
//    });
//  }
}
