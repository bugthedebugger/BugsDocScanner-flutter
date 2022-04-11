import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:bugs_scanner/ffi/bugs_scanner_bindings.dart';
import 'package:ffi/ffi.dart';

class BugsScanner$Impl {
  final BugsScannerBindings _bindings;
  BugsScanner$Impl()
      : _bindings = BugsScannerBindings(
          Platform.isAndroid
              ? DynamicLibrary.open("libbugsscanner.so")
              : DynamicLibrary.process(),
        );

  String getFileName(String extension) {
    final Pointer<Int8> _fileName =
        _bindings.getFileName('.jpg'.toNativeUtf8().cast<Int8>());
    String fileName = _fileName.cast<Utf8>().toDartString();
    malloc.free(_fileName);
    return fileName;
  }

  Uint8List getCroppedBWImage(Uint8List buf) {
    final Pointer<Uint8> buffer = malloc.allocate<Uint8>(buf.length);
    for (int i = 0; i < buf.length; i++) {
      buffer[i] = buf[i];
    }
    final ImgBuffer imgBuffer = _bindings.createImgBuffer(buffer, buf.length);
    final _buf = _bindings.warpAndGetBWImageSaveBufInBuf(imgBuffer);
    final Uint8List finalBuffer = _buf.buffer.asTypedList(_buf.size);
    print("Buffer size: ${_buf.size} ${buf.length}");
    malloc.free(buffer);

    return finalBuffer;
  }
}
