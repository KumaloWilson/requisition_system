import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/custom_widgets/text_fields/custom_text_field.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:req_sys_finale/features/workers/helper/add_user_helper.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../custom_widgets/custom_dropdown.dart';

class EditUserProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  const EditUserProfileScreen({super.key, required this.userProfile});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;
  late String selectedRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _phoneController =
        TextEditingController(text: widget.userProfile.phoneNumber);
    _addressController =
        TextEditingController(text: widget.userProfile.address);
    _cityController = TextEditingController(text: widget.userProfile.city);
    _stateController = TextEditingController(text: widget.userProfile.state);
    _countryController =
        TextEditingController(text: widget.userProfile.country);
    selectedRole = widget.userProfile.role!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.userProfile.name!,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              width: 150,
              height: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Pallete.primaryColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person,
                size: 100,
                color: Pallete.primaryColor,
              ),
            ),
            Text(
              'Edit Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Pallete.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _nameController,
              labelText: 'Full Name',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _emailController,
              labelText: 'Email Address',
              readOnly: true,
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _phoneController,
              labelText: 'Phone Number',
              readOnly: true,
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _addressController,
              prefixIcon: const Icon(
                Icons.home,
                color: Colors.grey,
              ),
              labelText: 'Address',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _cityController,
              prefixIcon: const Icon(
                Icons.home,
                color: Colors.grey,
              ),
              labelText: 'City',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _stateController,
              prefixIcon: const Icon(
                Icons.home,
                color: Colors.grey,
              ),
              labelText: 'State',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _countryController,
              prefixIcon: const Icon(
                Icons.home,
                color: Colors.grey,
              ),
              labelText: 'Country',
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            GeneralButton(
              onTap: () {
                UserProfile updatedProfile = widget.userProfile.copyWith(
                  name: _nameController.text,
                  email: _emailController.text,
                  phoneNumber: _phoneController.text,
                  address: _addressController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  country: _countryController.text,
                  role: selectedRole,
                );

                AddUserHelper.validateAndUpdatePROFILE(
                    userProfile: updatedProfile);
              },
              width: 300,
              borderRadius: 10,
              btnColor: Pallete.primaryColor,
              child: const Text(
                'Update Profile',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
