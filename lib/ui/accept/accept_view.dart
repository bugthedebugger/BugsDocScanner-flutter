import 'dart:typed_data';

import 'package:bugs_scanner/ui/accept/accept_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AcceptView extends StatelessWidget {
  const AcceptView({
    Key? key,
    required this.croppedImage,
  }) : super(key: key);

  final Uint8List croppedImage;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AcceptViewModel>.reactive(
      viewModelBuilder: () => AcceptViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                Expanded(
                  child: InteractiveViewer(
                    child: Image.memory(croppedImage),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        model.cancel();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        model.accept();
                      },
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
