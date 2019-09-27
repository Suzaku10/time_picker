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
                height: 100,
                child: Builder(builder: (context){
                  return FlatButton(
                      onPressed: () async {
                        var result = await TimePicker.pickTime(context,
                            selectedColor: Colors.lightGreen,
                            nonSelectedColor: Colors.black,
                            fontSize: 24.0,
                            timePickType: TimePickType.hourAndMinute,
                            isTwelveHourFormat: true);
                      },
                      child: Text("Klick"));
                }))));
    /* return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')), body: Container(height: 200, child: _coba())),
    );*/
  }
}
