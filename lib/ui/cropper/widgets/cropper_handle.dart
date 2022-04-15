import 'package:flutter/material.dart';

class CropperHandle extends StatelessWidget {
  const CropperHandle({
    Key? key,
    this.cropHandleSize = 20,
    this.onTapDown,
    this.onTapUp,
    this.activeHandle = false,
  }) : super(key: key);

  final double cropHandleSize;
  final bool activeHandle;

  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) {
        onTapDown?.call();
      },
      onLongPress: () {
        onTapDown?.call();
      },
      onLongPressStart: (_) {
        onTapDown?.call();
      },
      child: Container(
        height: cropHandleSize,
        width: cropHandleSize,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cropHandleSize),
              ),
              color: activeHandle ? Colors.blue : Colors.white,
              child: SizedBox(
                height: cropHandleSize / 3.8,
                width: cropHandleSize / 3.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
