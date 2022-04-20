import 'package:bugs_scanner/ffi/bugs_scanner_bindings.dart';

class ScannerCoordinates {
  final int x;
  final int y;

  ScannerCoordinates.fromXY(this.x, this.y);

  factory ScannerCoordinates.fromCoordinates(Coordinates coordinates) {
    return ScannerCoordinates.fromXY(coordinates.x, coordinates.y);
  }
}
