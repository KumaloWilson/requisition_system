class Document {
  String docID;
  String documentName;
  String? documentDescription;
  String documentUrl;
  String? expiryDate;

  Document({
    required this.docID,
    required this.documentName,
    required this.documentUrl,
    this.documentDescription,
    this.expiryDate,
  });

  // Convert a Document instance to JSON format
  Map<String, dynamic> toJson() => {
    'docID': docID,
    'documentName': documentName,
    'documentUrl': documentUrl,
    'documentDescription': documentDescription,
    'expiryDate': expiryDate,
  };

  // Create a Document instance from a JSON object
  factory Document.fromJson(Map<String, dynamic> json) => Document(
    docID: json['docID'] ?? '',
    documentName: json['documentName'] ?? '',
    documentUrl: json['documentUrl'] ?? '',
    documentDescription: json['documentDescription'] ?? '',
    expiryDate: json['expiryDate'],
  );

  // Create a copy of the Document instance with modified fields
  Document copyWith({
    String? docID,
    String? documentName,
    String? documentDescription,
    String? documentUrl,
    String? expiryDate,
  }) {
    return Document(
      docID: docID ?? this.docID,
      documentName: documentName ?? this.documentName,
      documentDescription: documentDescription ?? this.documentDescription,
      documentUrl: documentUrl ?? this.documentUrl,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
