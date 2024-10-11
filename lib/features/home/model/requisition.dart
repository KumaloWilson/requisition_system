import 'package:req_sys_finale/features/documents/models/document.dart';

class Requisition {
  String id;
  String createdBy;
  String payee;
  String reason;
  double amount;
  DateTime date;
  List<Document>? documents;
  List<String> approvals;
  bool isFullyApproved;
  String preparedBy;
  String checkedBy;
  bool authorisedFM;
  bool authorisedByGM;
  bool authorisedByMD;
  String receivedBy;

  Requisition({
    required this.id,
    required this.createdBy,
    required this.payee,
    required this.reason,
    required this.amount,
    required this.date,
    this.documents,
    required this.approvals,
    this.isFullyApproved = false,
    required this.preparedBy,
    required this.checkedBy,
    required this.authorisedFM,
    required this.authorisedByGM,
    required this.authorisedByMD,
    required this.receivedBy,
  });

  // Method to convert Requisition object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'payee': payee,
      'reason': reason,
      'amount': amount,
      'date': date.toIso8601String(),
      'documents': documents?.map((doc) => doc.toJson()).toList(),
      'approvals': approvals,
      'isFullyApproved': isFullyApproved,
      'preparedBy': preparedBy,
      'checkedBy': checkedBy,
      'authorisedFM': authorisedFM,
      'authorisedByGM': authorisedByGM,
      'authorisedByMD': authorisedByMD,
      'receivedBy': receivedBy,
    };
  }

  // Method to create a Requisition object from JSON
  factory Requisition.fromJson(Map<String, dynamic> json) {
    return Requisition(
      id: json['id'],
      createdBy: json['createdBy'],
      payee: json['payee'],
      reason: json['reason'],
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : json['amount'],
      date: DateTime.parse(json['date']),
      documents: (json['documents'] as List?)
          ?.map((doc) => Document.fromJson(doc))
          .toList(),
      approvals: List<String>.from(json['approvals']),
      isFullyApproved: json['isFullyApproved'],
      preparedBy: json['preparedBy'],
      checkedBy: json['checkedBy'],
      authorisedFM: json['authorisedFM'],
      authorisedByGM: json['authorisedByGM'],
      authorisedByMD: json['authorisedByMD'],
      receivedBy: json['receivedBy'],
    );
  }

  // CopyWith method to clone and update object properties
  Requisition copyWith({
    String? id,
    String? createdBy,
    String? payee,
    String? reason,
    double? amount,
    DateTime? date,
    List<Document>? documents,
    List<String>? approvals,
    bool? isFullyApproved,
    String? preparedBy,
    String? checkedBy,
    bool? authorisedFM,
    bool? authorisedByGM,
    bool? authorisedByMD,
    String? receivedBy,
  }) {
    return Requisition(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      payee: payee ?? this.payee,
      reason: reason ?? this.reason,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      documents: documents ?? this.documents,
      approvals: approvals ?? this.approvals,
      isFullyApproved: isFullyApproved ?? this.isFullyApproved,
      preparedBy: preparedBy ?? this.preparedBy,
      checkedBy: checkedBy ?? this.checkedBy,
      authorisedFM: authorisedFM ?? this.authorisedFM,
      authorisedByGM: authorisedByGM ?? this.authorisedByGM,
      authorisedByMD: authorisedByMD ?? this.authorisedByMD,
      receivedBy: receivedBy ?? this.receivedBy,
    );
  }
}
