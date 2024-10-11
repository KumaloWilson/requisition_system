import 'dart:math';

import 'package:get/get.dart';

import '../../../custom_widgets/circular_loader/circular_loader.dart';
import '../../../custom_widgets/snackbar/custom_snackbar.dart';
import '../../home/model/requisition.dart';
import '../services/shift_services.dart';

class RequisitionHelpers {
  static void addRequisition({required Requisition requisition}) async {
    // Validate Payee
    if (requisition.payee.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Payee is required.');
      return;
    }

    // Validate Reason
    if (requisition.reason.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Reason is required.');
      return;
    }

    // Validate Amount
    if (requisition.amount <= 0) {
      CustomSnackBar.showErrorSnackbar(message: 'Valid amount is required.');
      return;
    }

    // Show loader while submitting requisition
    Get.dialog(
      const CustomLoader(
        message: 'Submitting requisition',
      ),
      barrierDismissible: false,
    );

    // Submit the requisition
    await RequisitionServices.submitRequisition(req: requisition).then((response) {
      if (!response.success) {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Failed to submit requisition');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(message: 'Requisition added successfully');
      }
    });
  }

  static String generateRandomId(String email) {
    final now = DateTime.now();
    final emailLetters = email.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    final random = Random(now.millisecondsSinceEpoch);
    final pool =
        '${emailLetters.isEmpty ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : emailLetters}abcdefghijklmnopqrstuvwxyz';
    String generateId() {
      return List.generate(15, (index) => pool[random.nextInt(pool.length)])
          .join();
    }
    return generateId();
  }

  static void updateRequisition({required Requisition requisition}) async {
    // Validate the necessary fields.
    if (requisition.payee.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Payee is required.');
      return;
    }

    if (requisition.amount <= 0) {
      CustomSnackBar.showErrorSnackbar(message: 'Valid amount is required.');
      return;
    }

    // Show loader while updating requisition.
    Get.dialog(
      const CustomLoader(
        message: 'Updating requisition',
      ),
      barrierDismissible: false,
    );

    // Update the requisition in the database.
    await RequisitionServices.updateRequisition(requisitionID: requisition.id ,updatedRequisition: requisition).then((response) {
      if (!response.success) {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Failed to update requisition');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(message: 'Requisition updated successfully');
      }
    });
  }
}
