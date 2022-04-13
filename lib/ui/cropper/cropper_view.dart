import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bugs_scanner/data/scanner_contour.dart';
import 'package:bugs_scanner/ui/cropper/cropper_handle.dart';
import 'package:bugs_scanner/ui/cropper/cropper_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CropperView extends StatelessWidget {
  final Uint8List originalImage;
  final bool automaticBW;

  const CropperView({
    Key? key,
    required this.originalImage,
    this.automaticBW = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CroppverViewModel>.reactive(
      viewModelBuilder: () => CroppverViewModel(),
      onModelReady: (model) => model.init(
        originalImage,
        automaticBW: automaticBW,
      ),
      builder: (context, model, chid) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                if (model.isBusy) const LinearProgressIndicator(),
                if (model.uiImage != null)
                  Expanded(
                    child: FittedBox(
                      alignment: FractionalOffset.center,
                      child: ClipRRect(
                        child: GestureDetector(
                          onPanUpdate: (detail) {
                            model.setCropHandlePosition(detail.localPosition);
                          },
                          onPanEnd: (_) {
                            model.clearActiveCrophandle();
                          },
                          child: Stack(
                            children: [
                              CustomPaint(
                                painter: CropEditorPainter(
                                  image: model.uiImage!,
                                  contour: model.contour,
                                ),
                                size: Size(
                                  model.imgWidth!.toDouble(),
                                  model.imgHeight!.toDouble(),
                                ),
                                // child: const SizedBox.expand(),
                              ),
                              Positioned(
                                top: model.contour!.topLeft.y -
                                    model.cropHandleOffset,
                                left: model.contour!.topLeft.x -
                                    model.cropHandleOffset,
                                child: CropperHandle(
                                  cropHandleSize: model.cropHandleSize,
                                  onTapDown: () => model.setActiveCropHandle(
                                    CropHandlePosition.topLeft,
                                  ),
                                  onTapUp: model.clearActiveCrophandle,
                                ),
                              ),
                              Positioned(
                                top: model.contour!.bottomLeft.y -
                                    model.cropHandleOffset,
                                left: model.contour!.bottomLeft.x -
                                    model.cropHandleOffset,
                                child: CropperHandle(
                                  cropHandleSize: model.cropHandleSize,
                                  onTapDown: () => model.setActiveCropHandle(
                                    CropHandlePosition.bottomLeft,
                                  ),
                                  onTapUp: model.clearActiveCrophandle,
                                ),
                              ),
                              Positioned(
                                top: model.contour!.bottomRight.y -
                                    model.cropHandleOffset,
                                left: model.contour!.bottomRight.x -
                                    model.cropHandleOffset,
                                child: CropperHandle(
                                  cropHandleSize: model.cropHandleSize,
                                  onTapDown: () => model.setActiveCropHandle(
                                    CropHandlePosition.bottomRight,
                                  ),
                                  onTapUp: model.clearActiveCrophandle,
                                ),
                              ),
                              Positioned(
                                top: model.contour!.topRight.y -
                                    model.cropHandleOffset,
                                left: model.contour!.topRight.x -
                                    model.cropHandleOffset,
                                child: CropperHandle(
                                  cropHandleSize: model.cropHandleSize,
                                  onTapDown: () => model.setActiveCropHandle(
                                    CropHandlePosition.topRight,
                                  ),
                                  onTapUp: model.clearActiveCrophandle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (model.uiImage != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: 'Cancel',
                        onPressed: () {
                          model.cancel();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Toggle B/W',
                        onPressed: () {
                          model.toggleBW();
                        },
                        icon: Icon(
                          model.automaticBW
                              ? Icons.invert_colors_on
                              : Icons.invert_colors_off,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Reset Cropper',
                        onPressed: () {
                          model.resetContourWithNotify();
                        },
                        icon: const Icon(
                          Icons.crop_free,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Crop',
                        onPressed: () {
                          model.cropImage();
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CropEditorPainter extends CustomPainter {
  final ScannerContour? contour;
  final ui.Image image;

  CropEditorPainter({
    required this.image,
    this.contour,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint cropperLine = Paint()
      ..color = Colors.white
      ..strokeWidth = 20;

    canvas.drawImage(image, Offset.zero, Paint());
    if (contour != null) {
      canvas.drawLine(
        Offset(contour!.topLeft.x, contour!.topLeft.y),
        Offset(contour!.bottomLeft.x, contour!.bottomLeft.y),
        cropperLine,
      );

      canvas.drawLine(
        Offset(contour!.bottomLeft.x, contour!.bottomLeft.y),
        Offset(contour!.bottomRight.x, contour!.bottomRight.y),
        cropperLine,
      );

      canvas.drawLine(
        Offset(contour!.bottomRight.x, contour!.bottomRight.y),
        Offset(contour!.topRight.x, contour!.topRight.y),
        cropperLine,
      );

      canvas.drawLine(
        Offset(contour!.topRight.x, contour!.topRight.y),
        Offset(contour!.topLeft.x, contour!.topLeft.y),
        cropperLine,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  //
}
