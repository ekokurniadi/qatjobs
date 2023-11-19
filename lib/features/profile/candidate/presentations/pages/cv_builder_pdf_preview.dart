import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';

class CVBuilderPdfPreview extends StatelessWidget {
  const CVBuilderPdfPreview({
    super.key,
    required this.document,
  });
  final Uint8List document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'CV Builder Preview',
        showLeading: true,
      ),
      body: PdfPreview(
        allowPrinting: false,
        pdfFileName: '${DateTime.now().millisecondsSinceEpoch}.pdf',
        dynamicLayout: false,
        build: (format) {
          return document;
        },
      ),
    );
  }
}
