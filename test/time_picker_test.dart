/*
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_picker/time_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('time_picker');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TimePicker.platformVersion, '42');
  });
}
*/
