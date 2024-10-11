import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:flutter/material.dart';

import '../../../custom_widgets/text_fields/custom_text_field.dart';
import '../../auth/helpers/helpers.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    super.key,
  });

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 120,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.lock,
                color: Pallete.primaryColor,
                size: 120,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Change Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Password should contain at least one\nuppercase, lowercase, number\n and special characters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: oldPasswordController,
                    obscureText: true,
                    labelText: 'Old password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: newPasswordController,
                    obscureText: true,
                    labelText: 'New password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    labelText: 'Confirm password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GeneralButton(
                    btnColor: Pallete.primaryColor,
                    width: 300,
                    borderRadius: 10,
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => AuthHelpers.validatePasswordUpdate(
                        oldPass: oldPasswordController.text.trim(),
                        newPass: newPasswordController.text.trim(),
                        confirmPass: confirmPasswordController.text.trim()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
