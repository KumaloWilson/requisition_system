import 'package:req_sys_finale/custom_widgets/text_fields/custom_phone_input.dart';
import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/custom_widgets/text_fields/custom_text_field.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../custom_widgets/country_city_state/country_city_state.dart';
import '../../../custom_widgets/custom_dropdown.dart';
import '../../manage_profile/models/user_profile.dart';
import '../helper/add_user_helper.dart';
import '../services/media_services.dart';

class AdminAddUser extends ConsumerStatefulWidget {
  const AdminAddUser({super.key});

  @override
  ConsumerState<AdminAddUser> createState() => _AdminAddUserState();
}

class _AdminAddUserState extends ConsumerState<AdminAddUser> {
  String selectedRole = 'User';
  PhoneNumberInputController? phoneNumberController;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController postTextEditingController =  TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController = PhoneNumberInputController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add User',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            const SizedBox(height: 30),
            CustomDropDown(
              prefixIcon: Icons.person,
              items: const ['Admin', 'User'],
              selectedValue: selectedRole,
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
              isEnabled: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Post (in full)',
              controller: postTextEditingController,
              prefixIcon:const Icon(Icons.work, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              labelText: 'Full Name',
              prefixIcon: const Icon(Icons.person, color: Colors.grey),
            ),

            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              labelText: 'Email Address',
              prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            CustomPhoneInput(
              labelText: 'Phone Number',
              pickFromContactsIcon: const Icon(Icons.perm_contact_cal),
              controller: phoneNumberController,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Center(
              child: GeneralButton(
                onTap: (){
                  AddUserHelper.validateAndSubmitForm(
                    userProfile: UserProfile(
                      post: postTextEditingController.text,
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      phoneNumber: phoneNumberController!.fullPhoneNumber.trim(),
                      role: selectedRole,
                    ),
                  );
                },
                borderRadius: 10,
                btnColor: Pallete.primaryColor,
                width: 300,
                child: const Text(
                  "Add User",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
