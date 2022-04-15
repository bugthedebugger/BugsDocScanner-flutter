// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:bugs_scanner/app/app.locator.dart';
import 'package:bugs_scanner/ui/cropper/cropper_view.dart';
import 'package:bugs_scanner/ui/scanner/scanner_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class BugsScannerService {
  static void initScanner() {
    bugsscannerDependencyInit();
  }

  static GlobalKey<NavigatorState>? get navigatorKey =>
      StackedService.navigatorKey;

  static Future<Uint8List?> scan({
    bool automaticBW = true,
    bool throwExceptions = false,
    bool logExceptions = kReleaseMode,
  }) async {
    try {
      final NavigationService navigationService =
          bsLocator<NavigationService>();
      final originalImage = await navigationService.navigateToView<Uint8List?>(
        ScannerView(
          logExceptions: logExceptions,
          throwExceptions: throwExceptions,
        ),
      );
      if (originalImage != null) {
        final Uint8List buffer = await navigationService.navigateToView(
          CropperView(
            originalImage: originalImage,
            automaticBW: automaticBW,
            logExceptions: logExceptions,
            throwExceptions: throwExceptions,
          ),
        );

        return buffer;
      }
    } catch (e) {
      if (logExceptions) {
        print('Bugs Scanner Exception: $e');
        print(e);
      }
      if (throwExceptions) {
        rethrow;
      }
    }
    return null;
  }
}
