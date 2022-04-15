import 'dart:typed_data';

import 'package:bugs_scanner/bugs_scanner.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BugsScannerService.initScanner();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bugs Scanner Example',
      home: const ScannerExample(),
      navigatorKey: BugsScannerService.navigatorKey,
    );
  }
}

class ScannerExample extends StatefulWidget {
  const ScannerExample({Key? key}) : super(key: key);

  @override
  State<ScannerExample> createState() => _ScannerExampleState();
}

class _ScannerExampleState extends State<ScannerExample> {
  Uint8List? _buffer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_buffer != null)
            Expanded(
              child: InteractiveViewer(
                child: Image.memory(_buffer!),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  _buffer = await BugsScannerService.scan(
                    automaticBW: true,
                    logExceptions: true,
                  );
                  setState(() {});
                },
                child: const Text('Scan document'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
