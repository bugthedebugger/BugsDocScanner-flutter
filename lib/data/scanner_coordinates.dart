import 'package:bugs_scanner/ffi/bugs_scanner_bindings.dart';

class ScannerCoordinates {
  final double x;
  final double y;

  ScannerCoordinates.fromXY(this.x, this.y);

  factory ScannerCoordinates.fromCoordinates(Coordinates coordinates) {
    return ScannerCoordinates.fromXY(coordinates.x, coordinates.y);
  }
}
