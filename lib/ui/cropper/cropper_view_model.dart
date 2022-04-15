// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bugs_scanner/app/app.locator.dart';
import 'package:bugs_scanner/data/scanner_contour.dart';
import 'package:bugs_scanner/data/scanner_coordinates.dart';
import 'package:bugs_scanner/ffi/bugs_scanner_adapter.dart';
import 'package:bugs_scanner/ui/accept/accept_view.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum CropHandlePosition { topLeft, bottomLeft, bottomRight, topRight, none }

class CroppverViewModel extends BaseViewModel {
  final NavigationService _navigationService = bsLocator<NavigationService>();

  Uint8List? _originalImage;
  Uint8List? get originalImage => _originalImage;

  Uint8List? _croppedImage;
  Uint8List? get croppedImage => _croppedImage;

  Uint8List? _processedImage;
  Uint8List? get processedImage => _processedImage;

  ScannerContour? _contour;
  ScannerContour? get contour => _contour;

  int? _imgHeight;
  int? get imgHeight => _imgHeight;
  int? _imgWidth;
  int? get imgWidth => _imgWidth;

  ui.Image? _uiImage;
  ui.Image? get uiImage => _uiImage;

  final double _cropHandleSize = 500;
  double get cropHandleSize => _cropHandleSize;
  double get cropHandleOffset => _cropHandleSize / 2;

  static const double _cropperOffset = 50;
  double get cropperOffset => _cropperOffset;

  CropHandlePosition _cropHandlePosition = CropHandlePosition.none;
  CropHandlePosition get cropHandlePosition => _cropHandlePosition;

  bool _automaticBW = false;
  bool get automaticBW => _automaticBW;

  bool _throwException = false;
  bool _logExceptions = false;

  Offset? _magnifierOffset;
  Offset? get magnifierOffset => _magnifierOffset;

  Future<void> init(
    Uint8List img, {
    bool automaticBW = false,
    bool throwExceptions = false,
    bool logExceptions = false,
  }) async {
    _throwException = throwExceptions;
    _logExceptions = logExceptions;

    setBusy(true);
    _originalImage = img;
    _automaticBW = automaticBW;

    final decodedImg = await decodeImageFromList(_originalImage!);
    _imgHeight = decodedImg.height;
    _imgWidth = decodedImg.width;
    ui.decodeImageFromList(_originalImage!, (result) async {
      _contour = await BugsScannerAdapter.getContourFromImageBuffer(
        _originalImage!,
      );
      if (!_contour!.isValid) {
        resetContour();
      }
      _uiImage = result;
      setBusy(false);
    });
  }

  void setMagnifierOffset(Offset? offset) {
    _magnifierOffset = offset;
    notifyListeners();
  }

  void setCropHandlePosition(ui.Offset offset) {
    switch (cropHandlePosition) {
      case CropHandlePosition.topLeft:
        _contour = ScannerContour.fromEdges(
          ScannerCoordinates.fromXY(offset.dx, offset.dy),
          contour!.bottomLeft,
          contour!.bottomRight,
          contour!.topRight,
        );
        notifyListeners();
        break;
      case CropHandlePosition.bottomLeft:
        _contour = ScannerContour.fromEdges(
          contour!.topLeft,
          ScannerCoordinates.fromXY(offset.dx, offset.dy),
          contour!.bottomRight,
          contour!.topRight,
        );
        notifyListeners();
        break;
      case CropHandlePosition.bottomRight:
        _contour = ScannerContour.fromEdges(
          contour!.topLeft,
          contour!.bottomLeft,
          ScannerCoordinates.fromXY(offset.dx, offset.dy),
          contour!.topRight,
        );
        notifyListeners();
        break;
      case CropHandlePosition.topRight:
        _contour = ScannerContour.fromEdges(
          contour!.topLeft,
          contour!.bottomLeft,
          contour!.bottomRight,
          ScannerCoordinates.fromXY(offset.dx, offset.dy),
        );
        notifyListeners();
        break;
      default:
        break;
    }
  }

  void setActiveCropHandle(CropHandlePosition pos) {
    _cropHandlePosition = pos;
    notifyListeners();
  }

  void clearActiveCrophandle() {
    _cropHandlePosition = CropHandlePosition.none;
    notifyListeners();
  }

  Future<void> cropImage() async {
    if (_automaticBW) {
      await processBWImage();
    } else {
      await processImage();
    }
  }

  Future<void> processImage() async {
    setBusy(true);
    try {
      _processedImage = await BugsScannerAdapter
          .cropAndGetColorImageFromBufAsBufWithCustomContour(
        _originalImage!,
        _contour!,
      );

      final bool? cropAccept = await _navigationService.navigateToView(
        AcceptView(
          croppedImage: _processedImage!,
        ),
      );

      if (cropAccept != null) {
        if (cropAccept) {
          _navigationService.back(result: _processedImage);
        }
      }
    } catch (e) {
      if (_logExceptions) {
        if (_logExceptions) {
          print('Bugs Scanner Exception: $e');
          print(e);
        }
      }
      if (_throwException) {
        rethrow;
      }
    } finally {
      setBusy(false);
    }
  }

  Future<void> processBWImage() async {
    setBusy(true);
    try {
      _processedImage = await BugsScannerAdapter
          .cropAndGetBWImageFromBufAsBufWithCustomContour(
        _originalImage!,
        _contour!,
      );
      final bool? cropAccept = await _navigationService.navigateToView(
        AcceptView(
          croppedImage: _processedImage!,
        ),
      );

      if (cropAccept != null) {
        if (cropAccept) {
          _navigationService.back(result: _processedImage);
        }
      }
    } catch (e) {
      if (_logExceptions) {
        if (_logExceptions) {
          print('Bugs Scanner Exception: $e');
          print(e);
        }
      }
      if (_throwException) {
        rethrow;
      }
    } finally {
      setBusy(false);
    }
  }

  void resetContour() {
    _contour = ScannerContour.fromEdges(
      ScannerCoordinates.fromXY(
        _cropperOffset,
        _cropperOffset,
      ),
      ScannerCoordinates.fromXY(
        _cropperOffset,
        imgHeight!.toDouble() - _cropperOffset,
      ),
      ScannerCoordinates.fromXY(
        imgWidth!.toDouble() - _cropperOffset,
        imgHeight!.toDouble() - _cropperOffset,
      ),
      ScannerCoordinates.fromXY(
        imgWidth!.toDouble() - _cropperOffset,
        _cropperOffset,
      ),
    );
  }

  void resetContourWithNotify() {
    resetContour();
    notifyListeners();
  }

  void cancel() {
    _navigationService.back();
  }

  void toggleBW() {
    _automaticBW = !_automaticBW;
    notifyListeners();
  }
}
