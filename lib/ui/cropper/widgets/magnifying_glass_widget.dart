import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MagnifyingGlassWidget extends StatelessWidget {
  final Size size;
  final ui.Image image;
  final Offset magnifierOffset;
  final double width;
  final double height;

  const MagnifyingGlassWidget({
    Key? key,
    required this.size,
    required this.image,
    required this.magnifierOffset,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 5,
          )
        ],
        borderRadius: BorderRadius.circular(
          width,
        ),
        border: Border.all(
          color: Colors.white,
          width: width * 0.05,
        ),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(
          width,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: size,
              painter: MagnifyingPainter(
                image: image,
                offset: magnifierOffset,
                containerSize: Size(
                  width,
                  width,
                ),
              ),
            ),
            Icon(
              Icons.add,
              color: Colors.black,
              size: width * 0.4,
            ),
          ],
        ),
      ),
    );
  }
}

class MagnifyingPainter extends CustomPainter {
  final ui.Image image;
  final Offset offset;
  final Size containerSize;

  static const double magnifyingScale = 5;

  MagnifyingPainter({
    required this.image,
    required this.offset,
    required this.containerSize,
  });

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.scale(magnifyingScale);
    canvas.drawImage(
      image,
      Offset(
        -(offset.dx - ((containerSize.width / magnifyingScale) / 2)),
        -(offset.dy - ((containerSize.height / magnifyingScale) / 2)),
      ),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  //
}
