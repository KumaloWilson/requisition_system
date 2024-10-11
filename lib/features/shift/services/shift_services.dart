import 'package:req_sys_finale/core/utils/api_response.dart';
import 'package:req_sys_finale/core/utils/logs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../home/model/requisition.dart';

class RequisitionServices {
  static Future<APIResponse<void>> submitRequisition(
      {required Requisition req}) async {
    final reqData = req.toJson();

    try {
      // Add the shift data to Firestore
      await FirebaseFirestore.instance.collection('requisitions').add(reqData);
      return APIResponse(success: true);
    } catch (e) {
      return APIResponse(
          success: false,
          message: 'Failed to submit requisition: ${e.toString()}');
    }
  }
  
  static Stream<List<Requisition>> streamRequisitionsByEmail(
      {required String email}) {
    final now = DateTime.now();
   
    return FirebaseFirestore.instance
        .collection('requisitions')
        .where('addedBy', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Requisition.fromJson(doc.data())).toList();
    });
  }

  static Future<APIResponse<void>> updateRequisition({
    required String requisitionID,
    required Requisition updatedRequisition,
  }) async {
    try {
      final requisitionData = updatedRequisition.toJson();

      // Update the shift in Firestore using the document ID
      await FirebaseFirestore.instance
          .collection('requisitions')
          .doc(requisitionID)
          .update(requisitionData);

      return APIResponse(success: true);
    } catch (e) {
      DevLogs.logError('Failed to update requisition: $e');
      return APIResponse(
          success: false, message: 'Failed to update requisition: ${e.toString()}');
    }
  }
}
