import 'dart:isolate';
import 'dart:typed_data';

import 'package:bugs_scanner/data/isolate_param.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BugsPDFService {
  Future<Uint8List> convertImageToPdf(Uint8List imgBuf) async {
    final ReceivePort receivePort = ReceivePort();
    final IsolateParams<Uint8List> params = IsolateParams<Uint8List>(
      sendPort: receivePort.sendPort,
      data: imgBuf,
    );

    await Isolate.spawn<IsolateParams<Uint8List>>(
      (IsolateParams<Uint8List> params) async {
        final pw.Document pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.undefined,
            build: (pw.Context ctx) {
              return pw.Image(
                pw.MemoryImage(params.data!),
              );
            },
          ),
        );

        Uint8List pdfBuf = await pdf.save();
        params.sendPort.send(pdfBuf);
      },
      params,
    );

    return await receivePort.first;
  }
}
