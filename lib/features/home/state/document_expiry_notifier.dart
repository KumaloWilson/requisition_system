import 'package:req_sys_finale/core/utils/logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../documents/models/document.dart';
import '../../manage_profile/models/user_profile.dart';

class ExpiringDocumentsNotifier extends StateNotifier<List<Document>> {
  ExpiringDocumentsNotifier() : super([]);

  // void checkExpiringDocuments(UserProfile userProfile) {
  //   final List<Document> expiringDocs = [];
  //
  //   final now = DateTime.now();
  //   final twoWeeksLater = now.add(const Duration(days: 14));
  //
  //   final DateFormat dateFormat = DateFormat('yyyy/MM/dd');
  //
  //   for (var document in userProfile.documents) {
  //     if (document.expiryDate != null) {
  //       try {
  //         final expiryDate = dateFormat.parse(document.expiryDate!);
  //
  //         if (expiryDate.isBefore(twoWeeksLater)) {
  //           expiringDocs.add(document);
  //         }
  //       } catch (e) {
  //         DevLogs.logError(
  //             'Error parsing expiry date for ${document.documentName}: $e');
  //       }
  //     } else {
  //       DevLogs.logWarning(
  //           'Document ${document.documentName} has no expiry date');
  //     }
  //   }
  //
  //   if (expiringDocs.isNotEmpty) {
  //     state = expiringDocs; // Notify state of expiring documents
  //   } else {
  //     state = [];
  //   }
  // }
}
