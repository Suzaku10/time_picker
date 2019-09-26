import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:time_picker/time_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /* String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await TimePicker.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }*/

  FixedExtentScrollController _controller = FixedExtentScrollController();
  int tesdong = 0;
  double lerps = 0;

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    setState(() {
      lerps = (_controller.offset.round() % 35) / (35);
      print("ini adalah lerps :${1 - lerps}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')), body: Container(height: 200, child: _coba())),
    );
  }

  Widget _tst() {
    return NumberPickerDialog.decimal(
        minValue: 1, maxValue: 10, title: new Text("Pick a new price"), initialDoubleValue: 6);
  }

  List<Widget> _children() {
    return List.generate(24, (index) {
      return Center(
          child: AnimatedDefaultTextStyle(
              child: Text(index.toString()),
              style: tesdong == index
                  ? TextStyle(
                      color: Color.lerp(Colors.lightGreen, Colors.black, lerps < 0.5 ? lerps : 1-lerps ),
                      fontWeight: FontWeight.w800,
                      fontSize: 24)
                  : TextStyle(color: Colors.black, fontSize: 15),
              duration: Duration(milliseconds: 100)));
    });
  }

  Widget _coba() {
    return Stack(
      children: <Widget>[
        Center(child: Container(constraints: BoxConstraints.expand(height: 35.0), color: Colors.blue)),
        Positioned.fill(
            child: ListWheelScrollView.useDelegate(
                controller: _controller,
                itemExtent: 35.0,
                diameterRatio: 1.2,
                clipToSize: false,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: ((tes) {
                  tesdong = tes;
                }),
//          useMagnifier: true,
//          magnification: 2.0,
//            perspective: 0.0099,
                childDelegate: ListWheelChildLoopingListDelegate(children: _children())))
      ],
    );
  }

/*  Widget _coba() {
    return Stack(
      children: <Widget>[
        Center(child: Container(constraints: BoxConstraints.expand(height: 35.0), color: Colors.blue)),
        Positioned.fill(
            child: ListView(
              cacheExtent: 35.0,
          children: List.generate(24, (index) {
            return Center(
                child: AnimatedDefaultTextStyle(
                    child: Text(index.toString(),
                       */ /* style: tesdong == index
                            ? TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.w800, fontSize: 20)
                            : TextStyle(color: Colors.black)*/ /*),
                    style: tesdong == index
                        ? TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.w800, fontSize: 20)
                        : TextStyle(color: Colors.black),
                    duration: Duration(milliseconds: 200)));
          }),
        ))
      ],
    );
  }*/
}
