import 'package:req_sys_finale/features/documents/models/document.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/cards/document_card.dart';

class DocumentsTab extends StatefulWidget {
  final List<Document> documents;
  const DocumentsTab({super.key, required this.documents});

  @override
  State<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<DocumentsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.documents.length,
        itemBuilder: (context, index) {
          final document = widget.documents[index];
          return DocumentCard(
            document: document,
          );
        },
      ),
    );
  }
}
