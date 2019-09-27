import 'package:flutter/material.dart';
import 'constant.dart';

class ScrollableTimePicker extends StatefulWidget {
  final FixedExtentScrollController controller;
  final double fontSize;
  final Color selectedColor;
  final Color nonSelectedColor;
  final List<String> dataList;

  const ScrollableTimePicker(
      {Key key, this.controller, this.fontSize, this.selectedColor, this.nonSelectedColor, this.dataList})
      : super(key: key);

  @override
  _ScrollableTimePickerState createState() => _ScrollableTimePickerState();
}

class _ScrollableTimePickerState extends State<ScrollableTimePicker> {
  int _result = 0;
  double _itemExtent;
  double lerps = 0;

  @override
  void initState() {
    _itemExtent = widget.fontSize + 10;
    widget.controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScrollable();
  }

  Widget _buildScrollable() {
    return Stack(
      children: <Widget>[
          Center(child: Container(constraints: BoxConstraints.expand(height: _itemExtent + 100, width: _itemExtent))),
        Positioned.fill(
            child: Container(
              height: 200,
              child: ListWheelScrollView.useDelegate(
                  controller: widget.controller,
                  itemExtent: _itemExtent,
                  diameterRatio: 1.2,
                  clipToSize: true,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: ((selected) {
                    _result = selected;
                  }),
                  childDelegate: ListWheelChildLoopingListDelegate(children: _children(widget.dataList))),
            )),
        Constant.buildGradientScreen()
      ],
    );
  }

  List<Widget> _children(List<String> list) {
    return List.generate(list.length, (index) {
      return Center(
          child: AnimatedDefaultTextStyle(
              child: Text(list[index]),
              style: _result == index
                  ? TextStyle(
                      color: Color.lerp(widget.selectedColor, widget.nonSelectedColor, lerps < 0.5 ? lerps : 1 - lerps),
                      fontWeight: FontWeight.w800,
                      fontSize: widget.fontSize)
                  : TextStyle(color: widget.nonSelectedColor, fontSize: widget.fontSize * 0.80),
              duration: Duration(milliseconds: 100)));
    });
  }

  void _scrollListener() {
    setState(() {
      lerps = (widget.controller.offset.round() % _itemExtent) / (_itemExtent);
    });
  }
}
