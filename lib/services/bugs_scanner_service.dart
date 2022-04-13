import 'dart:typed_data';

import 'package:bugs_scanner/app/app.locator.dart';
import 'package:bugs_scanner/ui/cropper/cropper_view.dart';
import 'package:bugs_scanner/ui/scanner/scanner_view.dart';
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
  }) async {
    try {
      final NavigationService navigationService =
          bsLocator<NavigationService>();
      final originalImage = await navigationService
          .navigateToView<Uint8List?>(const ScannerView());
      if (originalImage != null) {
        final Uint8List buffer = await navigationService.navigateToView(
          CropperView(
            originalImage: originalImage,
            automaticBW: automaticBW,
          ),
        );

        return buffer;
      }
    } catch (e) {
      print('Exception: $e');
    }
    return null;
  }
}
