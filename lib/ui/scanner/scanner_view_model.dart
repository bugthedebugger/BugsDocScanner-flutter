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

  Future<void> init() async {
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
      print('Exception: $e');
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
      print(e);
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

  @override
  void dispose() {
    if (controller != null) {
      controller?.dispose();
    }
    super.dispose();
  }
}
