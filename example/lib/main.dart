import 'dart:io';
import 'dart:typed_data';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:bugs_scanner/bugs_scanner.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  PDFDocument? _doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_buffer != null || _doc != null)
          ? AppBar(
              title: Text(_doc != null ? 'PDF' : 'Image'),
            )
          : null,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_buffer != null)
            Expanded(
              child: _doc == null
                  ? InteractiveViewer(
                      child: Image.memory(_buffer!),
                    )
                  : PDFViewer(
                      document: _doc!,
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
                  _doc = null;
                  setState(() {});
                },
                child: const Text('Scan as Image'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  _buffer = await BugsScannerService.scanAsPDF(
                    automaticBW: true,
                    logExceptions: true,
                  );

                  File f = File(
                    '${(await getTemporaryDirectory()).path}${DateTime.now().millisecondsSinceEpoch}.pdf',
                  );
                  f = await f.writeAsBytes(_buffer!);

                  _doc = await PDFDocument.fromFile(f);

                  setState(() {});
                },
                child: const Text('Scan as PDF'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
