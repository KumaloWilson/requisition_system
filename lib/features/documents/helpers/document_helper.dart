import 'package:req_sys_finale/features/documents/models/document.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:req_sys_finale/features/workers/services/add_user_services.dart';
import 'package:get/get.dart';
import '../../../core/utils/string_methods.dart';
import '../../../custom_widgets/circular_loader/circular_loader.dart';
import '../../../custom_widgets/snackbar/custom_snackbar.dart';

class DocumentHelper {
  static void validateAndSubmitDocument({
    required UserProfile profile,
    required String docName,
    required String docDescription,
    required String expiryDate,
    required String docLink,
  }) async {
    // Validation checks
    if (docName.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a document name');
      return;
    }

    if (docDescription.isEmpty) {
      CustomSnackBar.showErrorSnackbar(
          message: 'Please input a document description');
      return;
    }

    if (expiryDate.isEmpty) {
      CustomSnackBar.showErrorSnackbar(
          message: 'Please input a document expiry date');
      return;
    }

    if (docLink.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Document not uploaded');
      return;
    }

    Get.dialog(
      const CustomLoader(message: 'Submitting Document'),
      barrierDismissible: false,
    );

    final updatedProfile = profile.copyWith(

    );

    await StaffServices.updateUserProfile(
      email: profile.email!,
      updatedProfile: updatedProfile,
    ).then((response) {
      if (!response.success) {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Failed to submit document');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(
            message: 'Document added successfully');
        if (Get.isDialogOpen!) Get.back();
      }
    });
  }
}
