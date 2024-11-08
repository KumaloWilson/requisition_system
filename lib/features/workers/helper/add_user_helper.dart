import 'package:req_sys_finale/custom_widgets/snackbar/custom_snackbar.dart';
import 'package:req_sys_finale/features/workers/services/add_user_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/circular_loader/circular_loader.dart';
import '../../manage_profile/models/user_profile.dart';
import '../services/storage_services.dart';

class AddUserHelper {
  static Future<void> validateAndSubmitForm({
    required UserProfile userProfile,
  }) async {
    // Validate Email
    if (!GetUtils.isEmail(userProfile.email!)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid email.');
      return;
    }

    // Validate Phone Number
    if (userProfile.phoneNumber!.isEmpty ||
        !GetUtils.isPhoneNumber(userProfile.phoneNumber!)) {
      CustomSnackBar.showErrorSnackbar(
          message: 'Please input a valid phone number.');
      return;
    }

    // Validate Name
    if (userProfile.name!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Name is required.');
      return;
    }


    // Validate Role
    if (userProfile.role!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Role is required.');
      return;
    }

    // Show loader while creating user
    Get.dialog(
      const CustomLoader(
        message: 'Creating user',
      ),
      barrierDismissible: false,
    );

    await StaffServices.addStuffToFirebase(userProfile: userProfile)
        .then((response) {
      if (!response.success) {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Something went wrong');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(
            message: 'User account created successfully');
      }
    });
  }

  static Future<DateTime?> pickDate(
      {required BuildContext context,
      required DateTime initialDate,
      DateTime? firstDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    return picked;
  }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
  }) async {
    final picked = await showTimePicker(
        context: context, initialTime: const TimeOfDay(hour: 6, minute: 00));

    return picked;
  }

  static Future<String> showWeekPicker(BuildContext context) async {
    final selectedDays = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        List<String> selectedDays = [];
        List<String> weekDays = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];

        return AlertDialog(
          title: const Text('Select Preferred Work Days'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: weekDays.map((day) {
                  return CheckboxListTile(
                    title: Text(day),
                    value: selectedDays.contains(day),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: <Widget>[
            TextButton(onPressed: Get.back, child: const Text('Cancel')),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(selectedDays);
              },
            ),
          ],
        );
      },
    );

    return selectedDays!.join(', ');
  }

  static List<String> addSpecialisation(
      {required String value, required List<String> specialisations}) {
    if (value.isNotEmpty && !specialisations.contains(value)) {
      specialisations.add(value);
    }
    return specialisations;
  }

  static Future<void> validateAndUpdatePROFILE({
    required UserProfile userProfile,
  }) async {
    // Validate Email
    if (!GetUtils.isEmail(userProfile.email!)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid email.');
      return;
    }

    // Validate Phone Number
    if (userProfile.phoneNumber!.isEmpty ||
        !GetUtils.isPhoneNumber(userProfile.phoneNumber!)) {
      CustomSnackBar.showErrorSnackbar(
          message: 'Please input a valid phone number.');
      return;
    }

    // Validate Name
    if (userProfile.name!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Name is required.');
      return;
    }

    // Validate Role
    if (userProfile.role!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Role is required.');
      return;
    }


    // Show loader while creating user
    Get.dialog(
      const CustomLoader(
        message: 'Creating user',
      ),
      barrierDismissible: false,
    );

    await StaffServices.updateUserProfile(
            email: userProfile.email!, updatedProfile: userProfile)
        .then((response) {
      if (!response.success) {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Something went wrong');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(
            message: 'User account created successfully');
      }
    });
  }
}
