import 'dart:async';
import 'dart:typed_data';

import 'package:bugs_scanner/bugs_scanner.dart';
import 'package:bugs_scanner/data/scanner_contour.dart';
import 'package:bugs_scanner/data/scanner_coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Uint8List? buffer;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await BugsScannerAdapter.getFileName('');
      // const imageUrl = "https://avatars.githubusercontent.com/u/9513691?v=4";
      // http.Response response = await http.get(
      //   Uri.parse(imageUrl),
      // );
      // buffer = await BugsScannerAdapter.cropAndGetColorImageFromBufAsBuf(
      //   response.bodyBytes,
      // );
      buffer = await BugsScannerAdapter
          .cropAndGetBWImageFromImagePathAsBufWithCustomContour(
        '/data/user/0/com.bugthedebugger.bugs_scanner_example/app_flutter/1649819250294.jpg',
        ScannerContour.fromEdges(
          ScannerCoordinates.fromXY(0, 0),
          ScannerCoordinates.fromXY(0, 150),
          ScannerCoordinates.fromXY(300, 250),
          ScannerCoordinates.fromXY(300, 0),
        ),
      );

      // buffer = await BugsScannerAdapter.cropAndGetColorImageFromImagePathAsBuf(
      //   '/data/user/0/com.bugthedebugger.bugs_scanner_example/app_flutter/1649819250294.jpg',
      // );

      // final c = await BugsScannerAdapter.getContourFromImageBuffer(
      //   response.bodyBytes,
      // );

      // final dir = await getApplicationDocumentsDirectory();

      // final saveddir =
      //     await BugsScannerAdapter.cropAndGetColorFromAssetAsFilePath(
      //   filePath: 'assets/images/1.jpg',
      //   fileExtension: '.jpg',
      //   savePath: dir.path,
      // );
      // print('filepath: $saveddir');
    } on PlatformException {
      platformVersion = 'Platform Exception';
    } catch (e) {
      platformVersion = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            if (buffer != null) Image.memory(buffer!),
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
          ],
        ),
      ),
    );
  }
}
