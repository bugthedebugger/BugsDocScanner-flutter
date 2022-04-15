// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:bugs_scanner/app/app.locator.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScannerViewModel extends BaseViewModel {
  final NavigationService _navigationService = bsLocator<NavigationService>();

  bool _cameraPermissionGranted = false;
  bool get camerPermission => _cameraPermissionGranted;

  final List<CameraDescription> _cameras = [];
  List<CameraDescription> get cameras => _cameras;

  CameraController? _controller;
  CameraController? get controller => _controller;

  FlashMode _flashMode = FlashMode.auto;
  FlashMode get flashMode => _flashMode;

  bool _throwException = false;
  bool _logExceptions = false;

  Future<void> init({
    bool throwException = false,
    bool logException = false,
  }) async {
    _throwException = throwException;
    _logExceptions = logException;
    setBusy(true);
    try {
      _cameraPermissionGranted = await Permission.camera.isGranted;
      if (!_cameraPermissionGranted) {
        final permission = await Permission.camera.request();
        if (permission.isRestricted) {
          openAppSettings();
        } else if (permission.isGranted) {
          _cameraPermissionGranted = true;
        } else if (permission.isPermanentlyDenied) {
          openAppSettings();
        }
      }

      if (_cameraPermissionGranted) {
        final cameraList = await availableCameras();
        _cameras.clear();
        _cameras.addAll(cameraList);
        await selectCamera(0);
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

  Future<void> snap() async {
    setBusy(true);
    try {
      if (_controller != null) {
        final XFile file = await _controller!.takePicture();
        final imageBytes = await file.readAsBytes();
        _navigationService.back<Uint8List>(
          result: imageBytes,
        );
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

  Future<void> selectCamera(int cameraIndex) async {
    if (controller != null) {
      await controller?.dispose();
      _controller = CameraController(
        cameras[cameraIndex],
        ResolutionPreset.max,
      );
      await _controller?.initialize();
    } else {
      _controller = CameraController(
        cameras[cameraIndex],
        ResolutionPreset.max,
        enableAudio: false,
      );
      await _controller?.initialize();
    }
  }

  void flashModeAuto() {
    _flashMode = FlashMode.auto;
    controller?.setFlashMode(flashMode);
    notifyListeners();
  }

  void flashModeAlways() {
    _flashMode = FlashMode.always;
    controller?.setFlashMode(flashMode);
    notifyListeners();
  }

  void flashModeOff() {
    _flashMode = FlashMode.off;
    controller?.setFlashMode(flashMode);
    notifyListeners();
  }

  int _flashCounter = 0;
  void toggleFlashModes() {
    _flashCounter++;
    _flashCounter = _flashCounter % 3;
    switch (_flashCounter) {
      case 0:
        flashModeAuto();
        break;
      case 1:
        flashModeAlways();
        break;
      case 2:
        flashModeOff();
        break;
      default:
        flashModeAuto();
    }
  }

  void back() {
    _navigationService.back();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller?.dispose();
    }
    super.dispose();
  }
}
