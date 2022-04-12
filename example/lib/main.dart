import 'dart:async';
import 'dart:typed_data';

import 'package:bugs_scanner/bugs_scanner.dart';
import 'package:bugs_scanner/data/scanner_contour.dart';
import 'package:bugs_scanner/data/scanner_coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
      const imageUrl = "https://avatars.githubusercontent.com/u/9513691?v=4";
      http.Response response = await http.get(
        Uri.parse(imageUrl),
      );
      // buffer = await BugsScannerAdapter.cropAndGetColorImageFromBufAsBuf(
      //   response.bodyBytes,
      // );
      buffer = await BugsScannerAdapter
          .cropAndGetColorImageFromBufAsBufWithCustomContour(
        buf: response.bodyBytes,
        contour: ScannerContour.fromEdges(
          ScannerCoordinates.fromXY(0, 0),
          ScannerCoordinates.fromXY(0, 150),
          ScannerCoordinates.fromXY(150, 150),
          ScannerCoordinates.fromXY(150, 0),
        ),
      );

      final c = await BugsScannerAdapter.getContourFromImageBuffer(
        response.bodyBytes,
      );
      print('Contour: ${c.toString()}');
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
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
