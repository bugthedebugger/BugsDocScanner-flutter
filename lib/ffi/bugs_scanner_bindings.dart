// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: camel_case_types, unused_element, unused_field, constant_identifier_names

import 'dart:ffi' as ffi;
import 'dart:io';

class BugsScannerBindings {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  BugsScannerBindings()
      : _lookup = Platform.isAndroid
            ? ffi.DynamicLibrary.open("libbugsscanner.so").lookup
            : ffi.DynamicLibrary.process().lookup;

  /// The symbols are looked up with [lookup].
  BugsScannerBindings.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  ImgBuffer createImgBuffer(
    ffi.Pointer<ffi.Uint8> buffer,
    int size,
  ) {
    return _createImgBuffer(
      buffer,
      size,
    );
  }

  late final _createImgBufferPtr = _lookup<
      ffi.NativeFunction<
          ImgBuffer Function(
              ffi.Pointer<ffi.Uint8>, ffi.Uint64)>>('createImgBuffer');
  late final _createImgBuffer = _createImgBufferPtr
      .asFunction<ImgBuffer Function(ffi.Pointer<ffi.Uint8>, int)>();

  Coordinates createCoordinates(
    double x,
    double y,
  ) {
    return _createCoordinates(
      x,
      y,
    );
  }

  late final _createCoordinatesPtr =
      _lookup<ffi.NativeFunction<Coordinates Function(ffi.Float, ffi.Float)>>(
          'createCoordinates');
  late final _createCoordinates =
      _createCoordinatesPtr.asFunction<Coordinates Function(double, double)>();

  Contour createContour(
    Coordinates topLeft,
    Coordinates bottomLeft,
    Coordinates bottomRight,
    Coordinates topRight,
  ) {
    return _createContour(
      topLeft,
      bottomLeft,
      bottomRight,
      topRight,
    );
  }

  late final _createContourPtr = _lookup<
      ffi.NativeFunction<
          Contour Function(Coordinates, Coordinates, Coordinates,
              Coordinates)>>('createContour');
  late final _createContour = _createContourPtr.asFunction<
      Contour Function(Coordinates, Coordinates, Coordinates, Coordinates)>();

  ffi.Pointer<ffi.Int8> getFileName(
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _getFileName(
      ext,
    );
  }

  late final _getFileNamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Int8> Function(
              ffi.Pointer<ffi.Int8>)>>('getFileName');
  late final _getFileName = _getFileNamePtr
      .asFunction<ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>)>();

  ffi.Pointer<ffi.Int8> warpAndGetOriginalImageSaveFile(
    ffi.Pointer<ffi.Int8> filePath,
    ffi.Pointer<ffi.Int8> savePath,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetOriginalImageSaveFile(
      filePath,
      savePath,
      ext,
    );
  }

  late final _warpAndGetOriginalImageSaveFilePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Int8> Function(
              ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>)>>('warpAndGetOriginalImageSaveFile');
  late final _warpAndGetOriginalImageSaveFile =
      _warpAndGetOriginalImageSaveFilePtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetOriginalImageBuf(
    ffi.Pointer<ffi.Int8> filePath,
  ) {
    return _warpAndGetOriginalImageBuf(
      filePath,
    );
  }

  late final _warpAndGetOriginalImageBufPtr =
      _lookup<ffi.NativeFunction<ImgBuffer Function(ffi.Pointer<ffi.Int8>)>>(
          'warpAndGetOriginalImageBuf');
  late final _warpAndGetOriginalImageBuf = _warpAndGetOriginalImageBufPtr
      .asFunction<ImgBuffer Function(ffi.Pointer<ffi.Int8>)>();

  ffi.Pointer<ffi.Int8> warpAndGetBWImageSaveFile(
    ffi.Pointer<ffi.Int8> filePath,
    ffi.Pointer<ffi.Int8> savePath,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetBWImageSaveFile(
      filePath,
      savePath,
      ext,
    );
  }

  late final _warpAndGetBWImageSaveFilePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Int8> Function(
              ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>)>>('warpAndGetBWImageSaveFile');
  late final _warpAndGetBWImageSaveFile =
      _warpAndGetBWImageSaveFilePtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetBWImageBuf(
    ffi.Pointer<ffi.Int8> filePath,
  ) {
    return _warpAndGetBWImageBuf(
      filePath,
    );
  }

  late final _warpAndGetBWImageBufPtr =
      _lookup<ffi.NativeFunction<ImgBuffer Function(ffi.Pointer<ffi.Int8>)>>(
          'warpAndGetBWImageBuf');
  late final _warpAndGetBWImageBuf = _warpAndGetBWImageBufPtr
      .asFunction<ImgBuffer Function(ffi.Pointer<ffi.Int8>)>();

  ffi.Pointer<ffi.Int8> warpAndGetOriginalImageSaveFileInbuf(
    ImgBuffer buf,
    ffi.Pointer<ffi.Int8> savePath,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetOriginalImageSaveFileInbuf(
      buf,
      savePath,
      ext,
    );
  }

  late final _warpAndGetOriginalImageSaveFileInbufPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Int8> Function(ImgBuffer, ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>)>>('warpAndGetOriginalImageSaveFileInbuf');
  late final _warpAndGetOriginalImageSaveFileInbuf =
      _warpAndGetOriginalImageSaveFileInbufPtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(
              ImgBuffer, ffi.Pointer<ffi.Int8>, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetOriginalImageSaveBufInBuf(
    ImgBuffer buf,
  ) {
    return _warpAndGetOriginalImageSaveBufInBuf(
      buf,
    );
  }

  late final _warpAndGetOriginalImageSaveBufInBufPtr =
      _lookup<ffi.NativeFunction<ImgBuffer Function(ImgBuffer)>>(
          'warpAndGetOriginalImageSaveBufInBuf');
  late final _warpAndGetOriginalImageSaveBufInBuf =
      _warpAndGetOriginalImageSaveBufInBufPtr
          .asFunction<ImgBuffer Function(ImgBuffer)>();

  ffi.Pointer<ffi.Int8> warpAndGetBWImageSaveFileInBuf(
    ImgBuffer buf,
    ffi.Pointer<ffi.Int8> savePath,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetBWImageSaveFileInBuf(
      buf,
      savePath,
      ext,
    );
  }

  late final _warpAndGetBWImageSaveFileInBufPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Int8> Function(ImgBuffer, ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>)>>('warpAndGetBWImageSaveFileInBuf');
  late final _warpAndGetBWImageSaveFileInBuf =
      _warpAndGetBWImageSaveFileInBufPtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(
              ImgBuffer, ffi.Pointer<ffi.Int8>, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetBWImageSaveBufInBuf(
    ImgBuffer buf,
  ) {
    return _warpAndGetBWImageSaveBufInBuf(
      buf,
    );
  }

  late final _warpAndGetBWImageSaveBufInBufPtr =
      _lookup<ffi.NativeFunction<ImgBuffer Function(ImgBuffer)>>(
          'warpAndGetBWImageSaveBufInBuf');
  late final _warpAndGetBWImageSaveBufInBuf = _warpAndGetBWImageSaveBufInBufPtr
      .asFunction<ImgBuffer Function(ImgBuffer)>();

  ffi.Pointer<ffi.Int8> warpAndGetOriginalImageSaveFileCustomContour(
    ffi.Pointer<ffi.Int8> filePath,
    ffi.Pointer<ffi.Int8> savePath,
    Contour contour,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetOriginalImageSaveFileCustomContour(
      filePath,
      savePath,
      contour,
      ext,
    );
  }

  late final _warpAndGetOriginalImageSaveFileCustomContourPtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>,
                  ffi.Pointer<ffi.Int8>, Contour, ffi.Pointer<ffi.Int8>)>>(
      'warpAndGetOriginalImageSaveFileCustomContour');
  late final _warpAndGetOriginalImageSaveFileCustomContour =
      _warpAndGetOriginalImageSaveFileCustomContourPtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>, Contour, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetOriginalImageBufCustomContour(
    ffi.Pointer<ffi.Int8> filePath,
    Contour contour,
  ) {
    return _warpAndGetOriginalImageBufCustomContour(
      filePath,
      contour,
    );
  }

  late final _warpAndGetOriginalImageBufCustomContourPtr = _lookup<
      ffi.NativeFunction<
          ImgBuffer Function(ffi.Pointer<ffi.Int8>,
              Contour)>>('warpAndGetOriginalImageBufCustomContour');
  late final _warpAndGetOriginalImageBufCustomContour =
      _warpAndGetOriginalImageBufCustomContourPtr
          .asFunction<ImgBuffer Function(ffi.Pointer<ffi.Int8>, Contour)>();

  ffi.Pointer<ffi.Int8> warpAndGetBWImageSaveFileCustomContour(
    ffi.Pointer<ffi.Int8> filePath,
    ffi.Pointer<ffi.Int8> savePath,
    Contour contour,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetBWImageSaveFileCustomContour(
      filePath,
      savePath,
      contour,
      ext,
    );
  }

  late final _warpAndGetBWImageSaveFileCustomContourPtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>,
                  ffi.Pointer<ffi.Int8>, Contour, ffi.Pointer<ffi.Int8>)>>(
      'warpAndGetBWImageSaveFileCustomContour');
  late final _warpAndGetBWImageSaveFileCustomContour =
      _warpAndGetBWImageSaveFileCustomContourPtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(ffi.Pointer<ffi.Int8>,
              ffi.Pointer<ffi.Int8>, Contour, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetBWImageBufCustomContour(
    ffi.Pointer<ffi.Int8> filePath,
    Contour contour,
  ) {
    return _warpAndGetBWImageBufCustomContour(
      filePath,
      contour,
    );
  }

  late final _warpAndGetBWImageBufCustomContourPtr = _lookup<
      ffi.NativeFunction<
          ImgBuffer Function(ffi.Pointer<ffi.Int8>,
              Contour)>>('warpAndGetBWImageBufCustomContour');
  late final _warpAndGetBWImageBufCustomContour =
      _warpAndGetBWImageBufCustomContourPtr
          .asFunction<ImgBuffer Function(ffi.Pointer<ffi.Int8>, Contour)>();

  ffi.Pointer<ffi.Int8> warpAndGetOriginalImageSaveFileCustomContourInBuf(
    ImgBuffer buf,
    ffi.Pointer<ffi.Int8> savePath,
    Contour contour,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetOriginalImageSaveFileCustomContourInBuf(
      buf,
      savePath,
      contour,
      ext,
    );
  }

  late final _warpAndGetOriginalImageSaveFileCustomContourInBufPtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Int8> Function(ImgBuffer, ffi.Pointer<ffi.Int8>,
                  Contour, ffi.Pointer<ffi.Int8>)>>(
      'warpAndGetOriginalImageSaveFileCustomContourInBuf');
  late final _warpAndGetOriginalImageSaveFileCustomContourInBuf =
      _warpAndGetOriginalImageSaveFileCustomContourInBufPtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(ImgBuffer, ffi.Pointer<ffi.Int8>,
              Contour, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetOriginalImageBufCustonContourInBuf(
    ImgBuffer buf,
    Contour contour,
  ) {
    return _warpAndGetOriginalImageBufCustonContourInBuf(
      buf,
      contour,
    );
  }

  late final _warpAndGetOriginalImageBufCustonContourInBufPtr =
      _lookup<ffi.NativeFunction<ImgBuffer Function(ImgBuffer, Contour)>>(
          'warpAndGetOriginalImageBufCustonContourInBuf');
  late final _warpAndGetOriginalImageBufCustonContourInBuf =
      _warpAndGetOriginalImageBufCustonContourInBufPtr
          .asFunction<ImgBuffer Function(ImgBuffer, Contour)>();

  ffi.Pointer<ffi.Int8> warpAndGetBWImageSaveFileCustomContourInBuf(
    ImgBuffer buf,
    ffi.Pointer<ffi.Int8> savePath,
    Contour contour,
    ffi.Pointer<ffi.Int8> ext,
  ) {
    return _warpAndGetBWImageSaveFileCustomContourInBuf(
      buf,
      savePath,
      contour,
      ext,
    );
  }

  late final _warpAndGetBWImageSaveFileCustomContourInBufPtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Int8> Function(ImgBuffer, ffi.Pointer<ffi.Int8>,
                  Contour, ffi.Pointer<ffi.Int8>)>>(
      'warpAndGetBWImageSaveFileCustomContourInBuf');
  late final _warpAndGetBWImageSaveFileCustomContourInBuf =
      _warpAndGetBWImageSaveFileCustomContourInBufPtr.asFunction<
          ffi.Pointer<ffi.Int8> Function(ImgBuffer, ffi.Pointer<ffi.Int8>,
              Contour, ffi.Pointer<ffi.Int8>)>();

  ImgBuffer warpAndGetBWImageBufCustomContourInBuf(
    ImgBuffer buf,
    Contour contour,
  ) {
    return _warpAndGetBWImageBufCustomContourInBuf(
      buf,
      contour,
    );
  }

  late final _warpAndGetBWImageBufCustomContourInBufPtr =
      _lookup<ffi.NativeFunction<ImgBuffer Function(ImgBuffer, Contour)>>(
          'warpAndGetBWImageBufCustomContourInBuf');
  late final _warpAndGetBWImageBufCustomContourInBuf =
      _warpAndGetBWImageBufCustomContourInBufPtr
          .asFunction<ImgBuffer Function(ImgBuffer, Contour)>();

  Contour findContourFromImagePath(
    ffi.Pointer<ffi.Int8> src,
  ) {
    return _findContourFromImagePath(
      src,
    );
  }

  late final _findContourFromImagePathPtr =
      _lookup<ffi.NativeFunction<Contour Function(ffi.Pointer<ffi.Int8>)>>(
          'findContourFromImagePath');
  late final _findContourFromImagePath = _findContourFromImagePathPtr
      .asFunction<Contour Function(ffi.Pointer<ffi.Int8>)>();

  Contour findContourFromImageBuffer(
    ImgBuffer buf,
  ) {
    return _findContourFromImageBuffer(
      buf,
    );
  }

  late final _findContourFromImageBufferPtr =
      _lookup<ffi.NativeFunction<Contour Function(ImgBuffer)>>(
          'findContourFromImageBuffer');
  late final _findContourFromImageBuffer =
      _findContourFromImageBufferPtr.asFunction<Contour Function(ImgBuffer)>();
}

class __fsid_t extends ffi.Struct {
  @ffi.Array.multi([2])
  external ffi.Array<ffi.Int32> __val;
}

class ImgBuffer extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> buffer;

  @ffi.Uint64()
  external int size;
}

class Coordinates extends ffi.Struct {
  @ffi.Float()
  external double x;

  @ffi.Float()
  external double y;
}

class Contour extends ffi.Struct {
  external Coordinates topLeft;

  external Coordinates bottomLeft;

  external Coordinates bottomRight;

  external Coordinates topRight;
}

const int _STDINT_H = 1;

const int _FEATURES_H = 1;

const int _ISOC95_SOURCE = 1;

const int _ISOC99_SOURCE = 1;

const int _ISOC11_SOURCE = 1;

const int _ISOC2X_SOURCE = 1;

const int _POSIX_SOURCE = 1;

const int _POSIX_C_SOURCE = 200809;

const int _XOPEN_SOURCE = 700;

const int _XOPEN_SOURCE_EXTENDED = 1;

const int _LARGEFILE64_SOURCE = 1;

const int _DEFAULT_SOURCE = 1;

const int _ATFILE_SOURCE = 1;

const int __GLIBC_USE_ISOC2X = 1;

const int __USE_ISOC11 = 1;

const int __USE_ISOC99 = 1;

const int __USE_ISOC95 = 1;

const int __USE_ISOCXX11 = 1;

const int __USE_POSIX = 1;

const int __USE_POSIX2 = 1;

const int __USE_POSIX199309 = 1;

const int __USE_POSIX199506 = 1;

const int __USE_XOPEN2K = 1;

const int __USE_XOPEN2K8 = 1;

const int __USE_XOPEN = 1;

const int __USE_XOPEN_EXTENDED = 1;

const int __USE_UNIX98 = 1;

const int _LARGEFILE_SOURCE = 1;

const int __USE_XOPEN2K8XSI = 1;

const int __USE_XOPEN2KXSI = 1;

const int __USE_LARGEFILE = 1;

const int __USE_LARGEFILE64 = 1;

const int __USE_MISC = 1;

const int __USE_ATFILE = 1;

const int __USE_GNU = 1;

const int __USE_FORTIFY_LEVEL = 0;

const int __GLIBC_USE_DEPRECATED_GETS = 0;

const int __GLIBC_USE_DEPRECATED_SCANF = 0;

const int _STDC_PREDEF_H = 1;

const int __STDC_IEC_559__ = 1;

const int __STDC_IEC_559_COMPLEX__ = 1;

const int __STDC_ISO_10646__ = 201706;

const int __GNU_LIBRARY__ = 6;

const int __GLIBC__ = 2;

const int __GLIBC_MINOR__ = 31;

const int _SYS_CDEFS_H = 1;

const int __glibc_c99_flexarr_available = 1;

const int __WORDSIZE = 64;

const int __WORDSIZE_TIME64_COMPAT32 = 1;

const int __SYSCALL_WORDSIZE = 64;

const int __LONG_DOUBLE_USES_FLOAT128 = 0;

const int __HAVE_GENERIC_SELECTION = 0;

const int __GLIBC_USE_LIB_EXT2 = 1;

const int __GLIBC_USE_IEC_60559_BFP_EXT = 1;

const int __GLIBC_USE_IEC_60559_BFP_EXT_C2X = 1;

const int __GLIBC_USE_IEC_60559_FUNCS_EXT = 1;

const int __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = 1;

const int __GLIBC_USE_IEC_60559_TYPES_EXT = 1;

const int _BITS_TYPES_H = 1;

const int __TIMESIZE = 64;

const int _BITS_TYPESIZES_H = 1;

const int __OFF_T_MATCHES_OFF64_T = 1;

const int __INO_T_MATCHES_INO64_T = 1;

const int __RLIM_T_MATCHES_RLIM64_T = 1;

const int __STATFS_MATCHES_STATFS64 = 1;

const int __FD_SETSIZE = 1024;

const int _BITS_TIME64_H = 1;

const int _BITS_WCHAR_H = 1;

const int __WCHAR_MAX = 2147483647;

const int __WCHAR_MIN = -2147483648;

const int _BITS_STDINT_INTN_H = 1;

const int _BITS_STDINT_UINTN_H = 1;

const int INT8_MIN = -128;

const int INT16_MIN = -32768;

const int INT32_MIN = -2147483648;

const int INT64_MIN = -9223372036854775808;

const int INT8_MAX = 127;

const int INT16_MAX = 32767;

const int INT32_MAX = 2147483647;

const int INT64_MAX = 9223372036854775807;

const int UINT8_MAX = 255;

const int UINT16_MAX = 65535;

const int UINT32_MAX = 4294967295;

const int UINT64_MAX = -1;

const int INT_LEAST8_MIN = -128;

const int INT_LEAST16_MIN = -32768;

const int INT_LEAST32_MIN = -2147483648;

const int INT_LEAST64_MIN = -9223372036854775808;

const int INT_LEAST8_MAX = 127;

const int INT_LEAST16_MAX = 32767;

const int INT_LEAST32_MAX = 2147483647;

const int INT_LEAST64_MAX = 9223372036854775807;

const int UINT_LEAST8_MAX = 255;

const int UINT_LEAST16_MAX = 65535;

const int UINT_LEAST32_MAX = 4294967295;

const int UINT_LEAST64_MAX = -1;

const int INT_FAST8_MIN = -128;

const int INT_FAST16_MIN = -9223372036854775808;

const int INT_FAST32_MIN = -9223372036854775808;

const int INT_FAST64_MIN = -9223372036854775808;

const int INT_FAST8_MAX = 127;

const int INT_FAST16_MAX = 9223372036854775807;

const int INT_FAST32_MAX = 9223372036854775807;

const int INT_FAST64_MAX = 9223372036854775807;

const int UINT_FAST8_MAX = 255;

const int UINT_FAST16_MAX = -1;

const int UINT_FAST32_MAX = -1;

const int UINT_FAST64_MAX = -1;

const int INTPTR_MIN = -9223372036854775808;

const int INTPTR_MAX = 9223372036854775807;

const int UINTPTR_MAX = -1;

const int INTMAX_MIN = -9223372036854775808;

const int INTMAX_MAX = 9223372036854775807;

const int UINTMAX_MAX = -1;

const int PTRDIFF_MIN = -9223372036854775808;

const int PTRDIFF_MAX = 9223372036854775807;

const int SIG_ATOMIC_MIN = -2147483648;

const int SIG_ATOMIC_MAX = 2147483647;

const int SIZE_MAX = -1;

const int WCHAR_MIN = -2147483648;

const int WCHAR_MAX = 2147483647;

const int WINT_MIN = 0;

const int WINT_MAX = 4294967295;

const int INT8_WIDTH = 8;

const int UINT8_WIDTH = 8;

const int INT16_WIDTH = 16;

const int UINT16_WIDTH = 16;

const int INT32_WIDTH = 32;

const int UINT32_WIDTH = 32;

const int INT64_WIDTH = 64;

const int UINT64_WIDTH = 64;

const int INT_LEAST8_WIDTH = 8;

const int UINT_LEAST8_WIDTH = 8;

const int INT_LEAST16_WIDTH = 16;

const int UINT_LEAST16_WIDTH = 16;

const int INT_LEAST32_WIDTH = 32;

const int UINT_LEAST32_WIDTH = 32;

const int INT_LEAST64_WIDTH = 64;

const int UINT_LEAST64_WIDTH = 64;

const int INT_FAST8_WIDTH = 8;

const int UINT_FAST8_WIDTH = 8;

const int INT_FAST16_WIDTH = 64;

const int UINT_FAST16_WIDTH = 64;

const int INT_FAST32_WIDTH = 64;

const int UINT_FAST32_WIDTH = 64;

const int INT_FAST64_WIDTH = 64;

const int UINT_FAST64_WIDTH = 64;

const int INTPTR_WIDTH = 64;

const int UINTPTR_WIDTH = 64;

const int INTMAX_WIDTH = 64;

const int UINTMAX_WIDTH = 64;

const int PTRDIFF_WIDTH = 64;

const int SIG_ATOMIC_WIDTH = 32;

const int SIZE_WIDTH = 64;

const int WCHAR_WIDTH = 32;

const int WINT_WIDTH = 32;
