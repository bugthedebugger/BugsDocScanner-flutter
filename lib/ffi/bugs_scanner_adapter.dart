import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:bugs_scanner/data/isolate_param.dart';
import 'package:bugs_scanner/ffi/bugs_scanner_bindings.dart';
import 'package:ffi/ffi.dart';

class BugsScannerAdapter {
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

  static Future<Uint8List> getCroppedBWImage(Uint8List buf) async {
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
}
