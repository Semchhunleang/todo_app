import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Future<void> setupMockPathProvider() async {
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getApplicationDocumentsDirectory':
        final directory = Directory.systemTemp.createTempSync();
        return directory.path;
      default:
        return null;
    }
  });
}
