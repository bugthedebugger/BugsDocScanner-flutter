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

  double _cropHandleSize = 400;
  double get cropHandleSize => _cropHandleSize;

  double get cropHandleOffset => _cropHandleSize / 2;

  CropHandlePosition _cropHandlePosition = CropHandlePosition.none;
  CropHandlePosition get cropHandlePosition => _cropHandlePosition;

  bool _automaticBW = false;
  bool get automaticBW => _automaticBW;

  Future<void> init(
    Uint8List img, {
    bool automaticBW = false,
  }) async {
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
      _cropHandleSize = 400;
      setBusy(false);
    });
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
      print(e);
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
      print(e);
    } finally {
      setBusy(false);
    }
  }

  void resetContour() {
    _contour = ScannerContour.fromEdges(
      ScannerCoordinates.fromXY(0, 0),
      ScannerCoordinates.fromXY(0, imgHeight!.toDouble()),
      ScannerCoordinates.fromXY(imgWidth!.toDouble(), imgHeight!.toDouble()),
      ScannerCoordinates.fromXY(imgWidth!.toDouble(), 0),
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
