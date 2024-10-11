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
  PhoneNumberInputController? contactInformationController;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController previousEmployerController = TextEditingController();
  TextEditingController documentNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController postTextEditingController =  TextEditingController();
  String selectedGender = 'Male';
  String? selectedCity;
  String? selectedState;
  String? selectedCountry;
  DateTime? dob;
  dynamic pickedImage;

  @override
  void initState() {
    super.initState();
    phoneNumberController = PhoneNumberInputController(context);
    contactInformationController = PhoneNumberInputController(context);
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
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
              onTap: () async {
                await MediaServices.getImageFromGallery().then((file) {
                  setState(() {
                    pickedImage = file;
                  });
                });
              },
              child: Stack(
                children: [
                  // Profile Picture
                  Container(
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(4),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Pallete.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: pickedImage != null
                        ? ClipOval(
                            child: Center(
                                child: Text(
                              "Image Added",
                              style: TextStyle(
                                  color: Pallete.primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                          )
                        : const Icon(
                            Icons.add_a_photo_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                  ),
                  // Icon Overlay
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Pallete.primaryColor),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            )),

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
            GestureDetector(
              onTap: () async {
                dob = await AddUserHelper.pickDate(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900));
                setState(() {});
              },
              child: CustomTextField(
                labelText: 'Date of Birth',
                prefixIcon: const Icon(Icons.cake, color: Colors.grey),
                enabled: false,
                controller: TextEditingController(
                  text:
                      dob != null ? DateFormat('yyyy-MM-dd').format(dob!) : '',
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomDropDown(
              prefixIcon: Icons.transgender,
              items: const ['Male', 'Female'],
              selectedValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
              isEnabled: true,
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
            CustomTextField(
              controller: addressController,
              labelText: 'Address',
              prefixIcon: const Icon(Icons.home, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            CountryCityState(
              onSelectionChanged: (country, state, city) {
                setState(() {
                  selectedCity = city;
                  selectedState = state;
                  selectedCountry = country;
                });
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: previousEmployerController,
              labelText: 'Previous Employer\'s Name',
              prefixIcon: const Icon(Icons.business_center, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            CustomPhoneInput(
              labelText: 'Previous Employer\'s Contact Information',
              pickFromContactsIcon: const Icon(Icons.perm_contact_cal),
              controller: contactInformationController,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Center(
              child: GeneralButton(
                onTap: (){
                  if (pickedImage != null) {
                    AddUserHelper.validateAndSubmitForm(
                      pickedImageBytes: pickedImage!.files.single.bytes,
                      fileName: pickedImage!.files.single.name,
                      userProfile: UserProfile(
                        post: postTextEditingController.text,
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phoneNumber:
                            phoneNumberController!.fullPhoneNumber.trim(),
                        address: addressController.text.trim(),
                        previousEmployer:
                            previousEmployerController.text.trim(),
                        contactInformation:
                            contactInformationController!.fullPhoneNumber,
                        role: selectedRole,
                        gender: selectedGender,
                        dob: dob,
                        city: selectedCity!,
                        state: selectedState!,
                        country: selectedCountry!,
                      ),
                    );
                  } else {
                    AddUserHelper.validateAndSubmitForm(
                      userProfile: UserProfile(
                        post: postTextEditingController.text,
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phoneNumber:
                            phoneNumberController!.fullPhoneNumber.trim(),
                        address: addressController.text.trim(),
                        previousEmployer:
                            previousEmployerController.text.trim(),
                        contactInformation:
                            contactInformationController!.fullPhoneNumber,
                        role: selectedRole,
                        gender: selectedGender,
                        dob: dob,
                        city: selectedCity!,
                        state: selectedState!,
                        country: selectedCountry!,
                        profilePicture: null,
                      ),
                    );
                  }
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
