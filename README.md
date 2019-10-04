# Simple TimePicker

*Note*: This plugin is still under development, and some Components might not be available yet or still has so many bugs.

## Installation

First, add `simpletime_picker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

```
simpletime_picker: ^0.1.0+1
```

## Example
```
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
             body: Container(child: Builder(builder: (context) {
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   FlatButton(
                       onPressed: () async {
                         var result = await TimePicker.pickTime(context,
                             selectedColor: Colors.amber,
                             nonSelectedColor: Colors.black,
                             displayType: DisplayType.bottomSheet,
                             timePickType: TimePickType.hourMinute,
                             buttonBackgroundColor: Colors.red,
                             title: "this is bottomsheet",
                             fontSize: 24.0,
                             isTwelveHourFormat: true);
                         print("ini apa ? $result");
                       },
                       child: Text("show bottomsheet")),
                   FlatButton(
                       onPressed: () async {
                         var result = await TimePicker.pickTime(context,
                             selectedColor: Colors.amber,
                             nonSelectedColor: Colors.black,
                             displayType: DisplayType.dialog,
                             timePickType: TimePickType.hourMinuteSecond,
                             fontSize: 30.0,
                             isTwelveHourFormat: true);
                         print("ini ? $result");
                       },
                       child: Text("show dialog"))
                 ],
               );
             }))));
   }
 }

```