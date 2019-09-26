import 'package:flutter/material.dart';
import 'package:time_picker/time_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Container(
              height: 200,
              child: TimePicker(primaryColor: Colors.lightGreen, secondaryColor: Colors.black, fontSize: 24.0))),
    );
    /* return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')), body: Container(height: 200, child: _coba())),
    );*/
  }

  List<Widget> _children() {
    return List.generate(24, (index) {
      return Center(
          child: AnimatedDefaultTextStyle(
              child: Text(index.toString()),
              style: tesdong == index
                  ? TextStyle(
                      color: Color.lerp(Colors.lightGreen, Colors.black, lerps < 0.5 ? lerps : 1 - lerps),
                      fontWeight: FontWeight.w800,
                      fontSize: 24)
                  : TextStyle(color: Colors.black, fontSize: 15),
              duration: Duration(milliseconds: 100)));
    });
  }

  Widget _coba() {
    return Stack(
      children: <Widget>[
//        Center(child: Container(constraints: BoxConstraints.expand(height: 35.0), color: Colors.blue)),
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
                childDelegate: ListWheelChildLoopingListDelegate(children: _children()))),
        _buildGradientScreen()
      ],
    );
  }

  Widget _buildGradientScreen() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
              colors: const <Color>[
                const Color(0xFFFFFFFF),
                const Color(0xF2FFFFFF),
                const Color(0xDDFFFFFF),
                const Color(0x00FFFFFF),
                const Color(0x00FFFFFF),
                const Color(0xDDFFFFFF),
                const Color(0xF2FFFFFF),
                const Color(0xFFFFFFFF),
              ],
              stops: const <double>[
                0.0,
                0.05,
                0.09,
                0.22,
                0.78,
                0.91,
                0.95,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
