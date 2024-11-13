import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/constants/local_image_constants.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/custom_widgets/custom_switch/custom_switch.dart';
import 'package:req_sys_finale/custom_widgets/text_fields/custom_text_field.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import '../../../core/constants/dimensions.dart';
import '../../workers/helper/add_user_helper.dart';
import '../helpers/shift_helpers.dart';

class AddRequisition extends StatefulWidget {
  final UserProfile selectedUser;
  const AddRequisition({super.key, required this.selectedUser});

  @override
  State<AddRequisition> createState() => _AddRequisitionState();
}

class _AddRequisitionState extends State<AddRequisition> {
  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  bool _isFullyApproved = false;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Requisition",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.isSmallScreen ? 350 : 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Hero Image or Banner
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          LocalImageConstants.addRequisition,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Create a New Requisition',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Pallete.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form Fields
                  _buildFormSection('Payee', Icons.person, _payeeController),
                  _buildFormSection('Reason', Icons.notes, _reasonController),
                  _buildFormSection('Amount', Icons.attach_money, _amountController, TextInputType.number),

                  // Date Picker
                  _buildDatePickerSection(),

                  // Approval Toggle
                  _buildApprovalToggle(),

                  const SizedBox(height: 20),
                  // Submit Button with Floating Action Button
                  Center(
                    child: FloatingActionButton.extended(
                      onPressed: _submitRequisition,
                      backgroundColor: Pallete.primaryColor,
                      label: const Text(
                        "Submit Requisition",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build form sections as cards
  Widget _buildFormSection(String label, IconData icon, TextEditingController controller, [TextInputType? keyboardType]) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: CustomTextField(
          controller: controller,
          labelText: label,
          prefixIcon: Icon(icon, color: Pallete.primaryColor),
          keyBoardType: keyboardType,
        ),
      ),
    );
  }

  // Helper for the date picker section
  Widget _buildDatePickerSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          await AddUserHelper.pickDate(
            context: context,
            initialDate: DateTime.now(),
          ).then((date) {
            if (date != null) {
              String formattedDate = DateFormat('yyyy/MM/dd').format(date);
              setState(() {
                _dateController.text = formattedDate;
              });
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: CustomTextField(
            enabled: false,
            controller: _dateController,
            labelText: 'Date',
            prefixIcon: Icon(Icons.calendar_today, color: Pallete.primaryColor),
          ),
        ),
      ),
    );
  }

  // Helper for the approval toggle section
  Widget _buildApprovalToggle() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: const Text(
          'Is Fully Approved?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: CustomSwitch(
          height: 25,
          activeColor: Pallete.primaryColor,
          value: _isFullyApproved,
          onChanged: (bool value) {
            setState(() {
              _isFullyApproved = value;
            });
          },
        ),
      ),
    );
  }

  // Submit Requisition
  void _submitRequisition() {
    final requisition = Requisition(
      id: RequisitionHelpers.generateRandomId(widget.selectedUser.email!),
      createdBy: currentUser!.email!,
      payee: _payeeController.text,
      reason: _reasonController.text,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      date: DateFormat('yyyy/MM/dd').parse(_dateController.text),
      approvals: [],
      preparedBy: widget.selectedUser.name!,
      checkedBy: '',  // To be filled in as needed
      authorisedFM: false,
      authorisedByGM: false,
      authorisedByMD: false,
      receivedBy: '',
      isFullyApproved: _isFullyApproved,
    );

    RequisitionHelpers.addRequisition(requisition: requisition);
  }
}
