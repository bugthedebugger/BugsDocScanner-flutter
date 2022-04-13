import 'package:bugs_scanner/data/scanner_coordinates.dart';
import 'package:bugs_scanner/ffi/bugs_scanner_bindings.dart';

class ScannerContour {
  final ScannerCoordinates topLeft;
  final ScannerCoordinates bottomLeft;
  final ScannerCoordinates bottomRight;
  final ScannerCoordinates topRight;

  ScannerContour.fromEdges(
    this.topLeft,
    this.bottomLeft,
    this.bottomRight,
    this.topRight,
  );

  factory ScannerContour.fromContour(Contour contour) {
    final topLeft = ScannerCoordinates.fromCoordinates(contour.topLeft);
    final bottomLeft = ScannerCoordinates.fromCoordinates(contour.bottomLeft);
    final bottomRight = ScannerCoordinates.fromCoordinates(contour.bottomRight);
    final topRight = ScannerCoordinates.fromCoordinates(contour.topRight);

    return ScannerContour.fromEdges(
      topLeft,
      bottomLeft,
      bottomRight,
      topRight,
    );
  }

  Contour toContour() {
    final BugsScannerBindings bindings = BugsScannerBindings();
    final Coordinates topLeft = bindings.createCoordinates(
      this.topLeft.x,
      this.topLeft.y,
    );
    final Coordinates bottomLeft = bindings.createCoordinates(
      this.bottomLeft.x,
      this.bottomLeft.y,
    );
    final Coordinates bottomRight = bindings.createCoordinates(
      this.bottomRight.x,
      this.bottomRight.y,
    );
    final Coordinates topRight = bindings.createCoordinates(
      this.topRight.x,
      this.topRight.y,
    );
    final Contour contour = bindings.createContour(
      topLeft,
      bottomLeft,
      bottomRight,
      topRight,
    );

    return contour;
  }

  @override
  String toString() {
    return "TopLeft: (${topLeft.x}, ${topLeft.y}) BottomLeft: (${bottomLeft.x}, ${bottomLeft.y}) BottomRight: (${bottomRight.x}, ${bottomRight.y}) TopRight: (${topRight.x}, ${topRight.y})";
  }

  bool get isValid {
    return !((topLeft.x < 1 && topLeft.x > 0) ||
        (bottomLeft.x < 1 && bottomLeft.x > 0) ||
        (bottomRight.x < 1 && bottomRight.x > 0) ||
        (topRight.x < 1 && topRight.x > 0) ||
        (topLeft.y < 1 && topLeft.y > 0) ||
        (bottomLeft.y < 1 && bottomLeft.y > 0) ||
        (bottomRight.y < 1 && bottomRight.y > 0) ||
        (topRight.y < 1 && topRight.y > 0));
  }
}
