import 'package:flutter/material.dart';

class Constant {
  static List<int> twelveHourFormat = List.generate(12, (i) => i+1);

  static List<String> meridiemFormat = ["AM", "PM"];

  static List<int> minuteAndSecondFormat = List.generate(60, (i) => i);

  static List<int> twentyFourHourFormat = List.generate(24, (i) => i);

  static Widget buildGradientScreen() {
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
