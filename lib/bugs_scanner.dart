
import 'dart:async';

import 'package:flutter/services.dart';

class BugsScanner {
  static const MethodChannel _channel = MethodChannel('bugs_scanner');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
