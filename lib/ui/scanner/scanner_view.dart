import 'package:bugs_scanner/ui/scanner/scanner_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ScannerView extends StatefulWidget {
  final bool throwExceptions;
  final bool logExceptions;

  const ScannerView({
    Key? key,
    this.throwExceptions = false,
    this.logExceptions = false,
  }) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: ViewModelBuilder<ScannerViewModel>.reactive(
          viewModelBuilder: () => ScannerViewModel(),
          onModelReady: (model) => model.init(
            logException: widget.logExceptions,
            throwException: widget.throwExceptions,
          ),
          builder: (ctx, model, child) {
            if (model.camerPermission) {
              return Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: model.controller != null
                        ? Stack(
                            children: [
                              CameraPreview(
                                model.controller!,
                              ),
                              if (model.isBusy)
                                const Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.blue,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          )
                        : const Center(
                            child: Text(
                              'Unable to initialize camera',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            model.back();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            model.snap();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            model.toggleFlashModes();
                          },
                          icon: Icon(
                            model.flashMode == FlashMode.auto
                                ? Icons.flash_auto
                                : model.flashMode == FlashMode.always
                                    ? Icons.flash_on
                                    : Icons.flash_off,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
