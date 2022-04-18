// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:bugs_scanner/app/app.locator.dart';
import 'package:bugs_scanner/services/bugs_pdf_service.dart';
import 'package:bugs_scanner/ui/cropper/cropper_view.dart';
import 'package:bugs_scanner/ui/scanner/scanner_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';

class BugsScannerService {
  static void initScanner() {
    if (!bsLocator.isRegistered<NavigationService>()) {
      bsLocator.registerLazySingleton<NavigationService>(
        () => NavigationService(),
      );
    }

    if (!bsLocator.isRegistered<BugsPDFService>()) {
      bsLocator.registerLazySingleton<BugsPDFService>(
        () => BugsPDFService(),
      );
    }
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
        final Uint8List? buffer = await navigationService.navigateToView(
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

  static Future<Uint8List?> scanAsPDF({
    bool automaticBW = true,
    bool throwExceptions = false,
    bool logExceptions = kReleaseMode,
  }) async {
    try {
      final Uint8List? buffer = await BugsScannerService.scan(
        automaticBW: automaticBW,
        logExceptions: logExceptions,
        throwExceptions: throwExceptions,
      );

      if (buffer != null) {
        final BugsPDFService pdfService = bsLocator<BugsPDFService>();
        final Uint8List pdfBuffer = await pdfService.convertImageToPdf(buffer);
        return pdfBuffer;
      }
      return null;
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

  static Future<File?> scanAndGetFile({
    bool automaticBW = true,
    bool throwExceptions = false,
    bool logExceptions = kReleaseMode,
  }) async {
    try {
      final Uint8List? buffer = await BugsScannerService.scan(
        automaticBW: automaticBW,
        logExceptions: logExceptions,
        throwExceptions: throwExceptions,
      );

      if (buffer == null) {
        return null;
      }

      File imgFile = File(
        '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      imgFile = await imgFile.writeAsBytes(buffer);
      return imgFile;
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

  static Future<File?> scanAsPDFAndGetFile({
    bool automaticBW = true,
    bool throwExceptions = false,
    bool logExceptions = kReleaseMode,
  }) async {
    try {
      final Uint8List? buffer = await BugsScannerService.scanAsPDF(
        automaticBW: automaticBW,
      );

      if (buffer == null) {
        return null;
      }

      File imgFile = File(
        '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      imgFile = await imgFile.writeAsBytes(buffer);
      return imgFile;
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
