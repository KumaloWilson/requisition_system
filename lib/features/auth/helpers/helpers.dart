import 'dart:async';
import 'package:req_sys_finale/core/utils/logs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/shared_pref.dart';
import '../../../custom_widgets/circular_loader/circular_loader.dart';
import '../../../custom_widgets/snackbar/custom_snackbar.dart';
import '../../../global/global.dart';
import '../services/auth_service.dart';

class AuthHelpers {
  static Future<void> handleEmailVerification({required User user}) async {
    if (!user.emailVerified) {
      Get.offAllNamed(RoutesHelper.emailVerificationScreen, arguments: user);
    } else {
      Get.offAllNamed(RoutesHelper.initialScreen);
    }
  }

  static Future<void> checkEmailVerification(
      {required User currentUser}) async {
    await currentUser.reload().then((value) {
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        Get.offAllNamed(RoutesHelper.initialScreen);
      }
    });
  }

  static setTimerForAutoRedirect() {
    const Duration timerPeriod = Duration(seconds: 5);
    Timer.periodic(
      timerPeriod,
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload().then((value) {
          final user = FirebaseAuth.instance.currentUser;

          if (user?.emailVerified ?? false) {
            timer.cancel();

            Get.offAllNamed(RoutesHelper.successfulVerificationScreen);
          }
        });
      },
    );
  }

  static Future<String?> getCurrentUserToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? token = await user.getIdToken();
        return token;
      } else {
        return null;
      }
    } catch (e) {
      DevLogs.logError('Error getting user token: $e');
      return null;
    }
  }

  static void validateAndSubmitForm({
    required String password,
    required String email,
  }) async {
    if (password.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Password is required.');
      return;
    }

    if (password.length < 8) {
      CustomSnackBar.showErrorSnackbar(message: 'Password too Short');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid email');
      return;
    }

    Get.dialog(
      const CustomLoader(
        message: 'Logging in',
      ),
      barrierDismissible: false,
    );

    await AuthServices.login(
      emailAddress: email.trim(),
      password: password.trim(),
    ).then((response) {
      if (!response.success &&
          response.message != 'No user found for that email.') {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Something went wrong');
      } else if (!response.success &&
          response.message == 'No user found for that email.') {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(
          message: response.message ?? 'Something went wrong',
        );
      } else {
        if (Get.isDialogOpen!) Get.back();

        // Show success snackbar

        CustomSnackBar.showSuccessSnackbar(
          message: 'Login Successful',
        );
        Get.offAllNamed(RoutesHelper.initialScreen);
      }
    });
  }

  static void validatePasswordUpdate(
      {required String oldPass,
      required String newPass,
      required String confirmPass}) async {
    if (oldPass.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Password is required.');
      return;
    }

    if (oldPass.length < 8) {
      CustomSnackBar.showErrorSnackbar(message: 'Old Password too Short');
      return;
    }

    if (newPass.length < 8) {
      CustomSnackBar.showErrorSnackbar(message: 'New Password too Short');
      return;
    }

    if (newPass == oldPass) {
      CustomSnackBar.showErrorSnackbar(
          message: 'Old password is the same as the new Password');
      return;
    }

    if (newPass != confirmPass) {
      CustomSnackBar.showErrorSnackbar(message: 'Passwords don`t match');
      return;
    }

    Get.dialog(
      const CustomLoader(
        message: 'Changing Password',
      ),
      barrierDismissible: false,
    );

    await AuthServices.updatePassword(
      newPassword: confirmPass.trim(),
      currentPassword: oldPass.trim(),
    ).then((response) {
      if (!response.success) {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showErrorSnackbar(
            message: response.message ?? 'Something went wrong');
      } else {
        if (Get.isDialogOpen!) Get.back();
        CustomSnackBar.showSuccessSnackbar(
          message: 'Password Changed Successfully',
        );
        Get.offAllNamed(RoutesHelper.initialScreen);
      }
    });
  }

  static Future<UserRole?> getUserRole(User user) async {
    UserRole? userRole = await CacheUtils.getUserRoleFromCache();

    if (userRole == null) {
      await AuthServices.fetchUserRole(user.email!).then((response) async {
        DevLogs.logInfo("USER ROLE = ${response.data}");

        if (response.data != null) {
          await CacheUtils.saveUserRoleToCache(response.data!);

          userRole = await CacheUtils.getUserRoleFromCache();
        }
      });
    }

    return userRole;
  }
}
