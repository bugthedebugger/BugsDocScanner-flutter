import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BugsPDFService {
  Future<Uint8List> convertImageToPdf(Uint8List imgBuf) async {
    final pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context ctx) {
          return pw.Image(
            pw.MemoryImage(imgBuf),
          );
        },
      ),
    );
    return await pdf.save();
  }
}
