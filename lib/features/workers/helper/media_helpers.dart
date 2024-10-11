import 'package:req_sys_finale/core/utils/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:req_sys_finale/features/workers/services/storage_services.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../core/constants/color_constants.dart';
import '../../../custom_widgets/circular_loader/circular_loader.dart';
import '../../../custom_widgets/snackbar/custom_snackbar.dart';
import '../../auth/state/authentication_provider.dart';

class MediaHelpers {
  // static Future<void> onUploadDpClip({required List<File> files, required String documentName, required bool isStaffProfile, required WidgetRef ref}) async {
  //   if (files.isNotEmpty) {
  //     Get.dialog(
  //       const CustomLoader(
  //         message: 'Updating Display Picture',
  //       ),
  //       barrierDismissible: false,
  //     );

  //     if (documentName == 'Display Picture') {
  //       final currentUser = FirebaseAuth.instance.currentUser;
  //       // Use the new function to upload staff profile picture
  //       final response = await StorageServices.uploadDp(
  //         file: files[0],
  //       );

  //       if (response.success  && isStaffProfile) {
  //         ref.read(ProviderUtils.staffProfilePicProvider.notifier).state = response.data;

  //         if (Get.isDialogOpen!) Get.back();

  //         CustomSnackBar.showSuccessSnackbar(message: 'Display Image updated Successfully');

  //       }
  //       else if (response.success && !isStaffProfile) {

  //         await currentUser!.updatePhotoURL(response.data).then((value){
  //           Get.back();
  //         });

  //         final updatedUser = FirebaseAuth.instance.currentUser;

  //         ref.read(ProviderUtils.userProvider.notifier).updateUser(updatedUser);

  //         if (Get.isDialogOpen!) Get.back();

  //         CustomSnackBar.showSuccessSnackbar(message: 'Display Image updated Successfully');
  //       }
  //       else {
  //         CustomSnackBar.showErrorSnackbar(message: 'Failed to upload image');
  //       }

  //       Get.back();
  //     } else {
  //       // Handle other document types if necessary
  //     }
  //   } else {
  //     CustomSnackBar.showErrorSnackbar(message: 'Please select your $documentName Image');
  //     return;
  //   }
  // }
}
