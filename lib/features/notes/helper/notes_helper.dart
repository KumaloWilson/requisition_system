import 'package:get/get.dart';

import '../../../custom_widgets/circular_loader/circular_loader.dart';
import '../../../custom_widgets/snackbar/custom_snackbar.dart';
import '../models/note.dart';
import '../services/notes_services.dart';

class NotesHelper{
  static Future<void> validateAndSubmitNotes({
    required Note note
  }) async {
    // Validate Email
    if (!GetUtils.isEmail(note.email)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid email.');
      return;
    }

    // Validate Name
    if (note.title.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Title is required.');
      return;
    }

    if (note.description.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Description is required.');
      return;
    }

    if (note.content.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Note content is required');
      return;
    }

    Get.dialog(
      const CustomLoader(
        message: 'Adding Note',
      ),
      barrierDismissible: false,
    );

    await NotesServices.addNotesToFirebase(note: note)
        .then((response) {
      if (!response.success) {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Something went wrong');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(
            message: 'Note added successfully');

        Get.back();
      }
    });
  }
}