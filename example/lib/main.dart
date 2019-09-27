import 'package:flutter/material.dart';
import 'package:time_picker/time_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Container(
              height: 200,
              child: TimePicker(
                  selectedColor: Colors.lightGreen,
                  nonSelectedColor: Colors.black,
                  fontSize: 24.0,
                  timetype: timePickType.hourAndMinute,
                  isTwelveHourFormat: true))),
    );
    /* return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')), body: Container(height: 200, child: _coba())),
    );*/
  }
}
