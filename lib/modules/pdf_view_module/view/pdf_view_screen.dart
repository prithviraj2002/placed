import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatelessWidget {
  String pdfPath;
  PdfViewScreen({required this.pdfPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PDFView(
          filePath: pdfPath,
        ));
  }
}
