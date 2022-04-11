import 'dart:ffi';
import 'dart:io';

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
}
