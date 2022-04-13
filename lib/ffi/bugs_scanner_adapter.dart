import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:bugs_scanner/data/isolate_param.dart';
import 'package:bugs_scanner/data/scanner_contour.dart';
import 'package:bugs_scanner/ffi/bugs_scanner_bindings.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

class BugsScannerAdapter {
  /// get unique file name
  static Future<String> getFileName(String extension) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams params = IsolateParams(sendPort: receivePort.sendPort);

    await Isolate.spawn<IsolateParams>(
      (IsolateParams params) {
        BugsScannerBindings _bindings = BugsScannerBindings();
        Pointer<Int8> _fileNameBytes =
            _bindings.getFileName('.jpg'.toNativeUtf8().cast<Int8>());
        String fileName = _fileNameBytes.cast<Utf8>().toDartString();
        malloc.free(_fileNameBytes);
        params.sendPort.send(fileName);
      },
      params,
    );

    final String fileName = await receivePort.first;

    return fileName;
  }

  /// create save file path from path and extension
  static Future<String> buildSaveFilePath(String path, String ext) async {
    final String fileName = await getFileName(ext);
    final String fileSavepath = "${Uri.encodeFull(path)}/$fileName";

    return fileSavepath;
  }

  /// Crops the image using default contour
  /// returns a black and white image as Uint8List
  static Future<Uint8List> cropAndGetBWImageFromBufAsBuf(Uint8List buf) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams params = IsolateParams<Uint8List>(
      sendPort: receivePort.sendPort,
      data: buf,
    );

    await Isolate.spawn<IsolateParams>(
      (IsolateParams params) {
        BugsScannerBindings _bindings = BugsScannerBindings();
        final Pointer<Uint8> buffer =
            malloc.allocate<Uint8>(params.data.length);
        for (int i = 0; i < params.data.length; i++) {
          buffer[i] = params.data[i];
        }
        final ImgBuffer imgBuffer =
            _bindings.createImgBuffer(buffer, params.data.length);
        final _buf = _bindings.warpAndGetBWImageSaveBufInBuf(imgBuffer);
        final Uint8List finalBuffer = _buf.buffer.asTypedList(_buf.size);
        malloc.free(buffer);
        params.sendPort.send(finalBuffer);
      },
      params,
    );

    final Uint8List finalBuffer = await receivePort.first;
    return finalBuffer;
  }

  /// Crops the image using custom contour
  /// returns a black and white image as Uint8List
  static Future<Uint8List> cropAndGetBWImageFromBufAsBufWithCustomContour(
    Uint8List buf,
    ScannerContour contour,
  ) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams<Set> params = IsolateParams<Set>(
      sendPort: receivePort.sendPort,
      data: {buf, contour},
    );

    await Isolate.spawn<IsolateParams<Set>>(
      (IsolateParams<Set> params) {
        final BugsScannerBindings bindings = BugsScannerBindings();
        final Uint8List imbuffer = (params.data!.first as Uint8List);
        final Pointer<Uint8> buffer = malloc.allocate<Uint8>(
          imbuffer.length,
        );
        for (int i = 0; i < imbuffer.length; i++) {
          buffer[i] = imbuffer[i];
        }
        final ImgBuffer imgBuffer = bindings.createImgBuffer(
          buffer,
          imbuffer.length,
        );
        final Contour contour =
            (params.data!.elementAt(1) as ScannerContour).toContour();
        final _buf = bindings.warpAndGetBWImageBufCustomContourInBuf(
          imgBuffer,
          contour,
        );
        final Uint8List finalBuffer = _buf.buffer.asTypedList(_buf.size);
        params.sendPort.send(finalBuffer);
      },
      params,
    );

    final Uint8List buffer = await receivePort.first;
    return buffer;
  }

  /// Crops the image using custom contour
  /// returns a colored image as Uint8List
  static Future<Uint8List> cropAndGetColorImageFromBufAsBufWithCustomContour(
    Uint8List buf,
    ScannerContour contour,
  ) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams<Set> params = IsolateParams<Set>(
      sendPort: receivePort.sendPort,
      data: {buf, contour},
    );

    await Isolate.spawn<IsolateParams<Set>>(
      (IsolateParams<Set> params) {
        final BugsScannerBindings bindings = BugsScannerBindings();
        final Uint8List imbuffer = (params.data!.first as Uint8List);
        final Pointer<Uint8> buffer = malloc.allocate<Uint8>(
          imbuffer.length,
        );
        for (int i = 0; i < imbuffer.length; i++) {
          buffer[i] = imbuffer[i];
        }
        final ImgBuffer imgBuffer = bindings.createImgBuffer(
          buffer,
          imbuffer.length,
        );
        final Contour contour =
            (params.data!.elementAt(1) as ScannerContour).toContour();
        final _buf = bindings.warpAndGetOriginalImageBufCustonContourInBuf(
          imgBuffer,
          contour,
        );
        final Uint8List finalBuffer = _buf.buffer.asTypedList(_buf.size);
        params.sendPort.send(finalBuffer);
      },
      params,
    );

    final Uint8List buffer = await receivePort.first;
    return buffer;
  }

  /// Crops the image using default contour
  /// returns a colored image as Uint8List
  static Future<Uint8List> cropAndGetColorImageFromBufAsBuf(
      Uint8List buf) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams params = IsolateParams<Uint8List>(
      sendPort: receivePort.sendPort,
      data: buf,
    );

    await Isolate.spawn<IsolateParams>(
      (IsolateParams params) {
        BugsScannerBindings _bindings = BugsScannerBindings();
        final Pointer<Uint8> buffer =
            malloc.allocate<Uint8>(params.data.length);
        for (int i = 0; i < params.data.length; i++) {
          buffer[i] = params.data[i];
        }
        final ImgBuffer imgBuffer =
            _bindings.createImgBuffer(buffer, params.data.length);
        final _buf = _bindings.warpAndGetOriginalImageSaveBufInBuf(imgBuffer);
        final Uint8List finalBuffer = _buf.buffer.asTypedList(_buf.size);
        malloc.free(buffer);
        params.sendPort.send(finalBuffer);
      },
      params,
    );

    final Uint8List finalBuffer = await receivePort.first;
    return finalBuffer;
  }

  /// Crops the asset image using default contour
  /// returns file path of the saved colored image as savePath/filename.$fileExtension
  static Future<String> cropAndGetColorFromAssetAsFilePath({
    required String filePath,
    required String savePath,
    required String fileExtension,
  }) async {
    final ReceivePort receivePort = ReceivePort();
    final ByteData byteData = await rootBundle.load(filePath);

    final IsolateParams<Set> params = IsolateParams<Set>(
      sendPort: receivePort.sendPort,
      data: {byteData.buffer.asUint8List(), savePath, fileExtension},
    );

    await Isolate.spawn<IsolateParams<Set>>(
      (IsolateParams<Set> params) async {
        final Uint8List buffer =
            await BugsScannerAdapter.cropAndGetColorImageFromBufAsBuf(
          params.data!.elementAt(0),
        );
        final fileSavepath = await BugsScannerAdapter.buildSaveFilePath(
          params.data!.elementAt(1),
          params.data!.elementAt(2),
        );
        File file = File(fileSavepath);
        await file.writeAsBytes(buffer);
        params.sendPort.send(fileSavepath);
      },
      params,
    );

    final String fileName = await receivePort.first;
    return fileName;
  }

  /// Crops the asset image using default contour
  /// returns [Uint8List] of colored image
  static Future<Uint8List> cropAndGetColorFromAssetsAsBuffer({
    required String filePath,
  }) async {
    final ReceivePort receivePort = ReceivePort();
    final ByteData byteData = await rootBundle.load(filePath);
    final IsolateParams<Uint8List> params = IsolateParams<Uint8List>(
      sendPort: receivePort.sendPort,
      data: byteData.buffer.asUint8List(),
    );

    await Isolate.spawn<IsolateParams<Uint8List>>(
      (IsolateParams<Uint8List> params) async {
        Uint8List finalBuffer =
            await BugsScannerAdapter.cropAndGetColorImageFromBufAsBuf(
          params.data!,
        );
        params.sendPort.send(finalBuffer);
      },
      params,
    );

    final Uint8List imgBuffer = await receivePort.first;
    return imgBuffer;
  }

  /// Crops the asset image using default contour
  /// returns file path of the saved bw image as $savePath/filename.$fileExtension
  static Future<String> cropAndGetBWFromAssetAsFilePath({
    required String filePath,
    required String savePath,
    required String fileExtension,
  }) async {
    final ReceivePort receivePort = ReceivePort();
    final ByteData byteData = await rootBundle.load(filePath);

    final IsolateParams<Set> params = IsolateParams<Set>(
      sendPort: receivePort.sendPort,
      data: {
        byteData.buffer.asUint8List(),
        savePath,
        fileExtension,
      },
    );

    await Isolate.spawn<IsolateParams<Set>>(
      (IsolateParams<Set> params) async {
        final Uint8List imageBuffer =
            await BugsScannerAdapter.cropAndGetBWImageFromBufAsBuf(
          params.data!.first,
        );

        final String fileSavePath = await BugsScannerAdapter.buildSaveFilePath(
          params.data!.elementAt(1),
          params.data!.elementAt(2),
        );
        final File file = File(fileSavePath);
        await file.writeAsBytes(imageBuffer);
        params.sendPort.send(fileSavePath);
      },
      params,
    );

    final String savedFilePath = await receivePort.first;
    return savedFilePath;
  }

  /// Returns a default contour from the image buffer provided
  static Future<ScannerContour?> getContourFromImageBuffer(
    Uint8List buf,
  ) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams<Uint8List> params = IsolateParams(
      sendPort: receivePort.sendPort,
      data: buf,
    );

    await Isolate.spawn<IsolateParams<Uint8List>>(
      (IsolateParams<Uint8List> params) {
        final BugsScannerBindings bindings = BugsScannerBindings();
        final Pointer<Uint8> imgBuffer = malloc.allocate<Uint8>(
          params.data!.length,
        );

        for (int i = 0; i < params.data!.length; i++) {
          imgBuffer[i] = params.data![i];
        }

        final ImgBuffer buf = bindings.createImgBuffer(
          imgBuffer,
          params.data!.length,
        );

        final Contour c = bindings.findContourFromImageBuffer(buf);

        malloc.free(imgBuffer);

        params.sendPort.send(
          ScannerContour.fromContour(c),
        );
      },
      params,
    );

    final ScannerContour? scannerContour = await receivePort.first;

    return scannerContour;
  }

  /// Returns a default contour from the image filepath provided
  static Future<ScannerContour?> getContourFromFilePath(String filePath) async {
    final ReceivePort receivePort = ReceivePort();
    final File file = File.fromUri(Uri.parse(filePath));
    final Uint8List buf = await file.readAsBytes();
    final IsolateParams<Uint8List> params = IsolateParams<Uint8List>(
      sendPort: receivePort.sendPort,
      data: buf,
    );

    await Isolate.spawn(
      (IsolateParams<Uint8List> params) async {
        final ScannerContour? contour =
            await BugsScannerAdapter.getContourFromImageBuffer(
          params.data!,
        );

        params.sendPort.send(contour);
      },
      params,
    );

    final ScannerContour? c = await receivePort.first;
    return c;
  }

  /// returns buffer of bw image cropped using default contour
  static Future<Uint8List> cropAndGetBWImageFromImagePathAsBuf(
      String filePath) async {
    final File file = File.fromUri(Uri.parse(filePath));
    final Uint8List imageBuffer = await file.readAsBytes();

    final Uint8List buffer =
        await BugsScannerAdapter.cropAndGetBWImageFromBufAsBuf(
      imageBuffer,
    );

    return buffer;
  }

  /// returns buffer of colored image cropped using default contour
  static Future<Uint8List> cropAndGetColorImageFromImagePathAsBuf(
      String filePath) async {
    final File file = File.fromUri(Uri.parse(filePath));
    final Uint8List imageBuffer = await file.readAsBytes();

    final Uint8List buffer =
        await BugsScannerAdapter.cropAndGetColorImageFromBufAsBuf(
      imageBuffer,
    );

    return buffer;
  }

  /// returns buffer of colored image cropped using custom contour
  static Future<Uint8List>
      cropAndGetColorImageFromImagePathAsBufWithCustomContour(
    String filePath,
    ScannerContour contour,
  ) async {
    final File file = File.fromUri(Uri.parse(filePath));
    final Uint8List imageBuffer = await file.readAsBytes();

    final Uint8List buffer = await BugsScannerAdapter
        .cropAndGetColorImageFromBufAsBufWithCustomContour(
      imageBuffer,
      contour,
    );

    return buffer;
  }

  /// returns buffer of bw image cropped using custom contour
  static Future<Uint8List> cropAndGetBWImageFromImagePathAsBufWithCustomContour(
    String filePath,
    ScannerContour contour,
  ) async {
    final File file = File.fromUri(Uri.parse(filePath));
    final Uint8List imageBuffer = await file.readAsBytes();

    final Uint8List buffer =
        await BugsScannerAdapter.cropAndGetBWImageFromBufAsBufWithCustomContour(
      imageBuffer,
      contour,
    );

    return buffer;
  }
}
