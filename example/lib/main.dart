import 'dart:async';
import 'dart:typed_data';

import 'package:bugs_scanner/bugs_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
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
      buffer = await BugsScannerAdapter.getCroppedBWImage(response.bodyBytes);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
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
