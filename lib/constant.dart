import 'package:flutter/material.dart';

class Constant {
  static List<int> twelveHourFormat = List.generate(12, (i) => i + 1);

  static List<String> meridiemFormat = ["AM", "PM"];

  static List<int> minuteAndSecondFormat = List.generate(60, (i) => i);

  static List<int> twentyFourHourFormat = List.generate(24, (i) => i);
}
