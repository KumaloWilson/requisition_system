import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/custom_widgets/custom_switch/custom_switch.dart';
import 'package:req_sys_finale/custom_widgets/text_fields/custom_text_field.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import '../../../core/constants/color_constants.dart';
import '../../home/model/requisition.dart';
import '../../workers/helper/add_user_helper.dart';
import '../helpers/shift_helpers.dart';

class EditUserRequisition extends StatefulWidget {
  final UserProfile selectedUser;
  final Requisition requisition;

  const EditUserRequisition({
    super.key,
    required this.selectedUser,
    required this.requisition,
  });

  @override
  State<EditUserRequisition> createState() => _EditUserRequisitionState();
}

class _EditUserRequisitionState extends State<EditUserRequisition> {
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
    setState(() {
      _payeeController.text = widget.requisition.payee;
      _reasonController.text = widget.requisition.reason;
      _amountController.text = widget.requisition.amount.toString();
      _dateController.text = DateFormat('yyyy/MM/dd').format(widget.requisition.date);
      _isFullyApproved = widget.requisition.isFullyApproved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.selectedUser.name!,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                Icons.edit,
                size: 100,
                color: Pallete.primaryColor,
              ),
            ),
            Text(
              'Edit Requisition',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Pallete.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _payeeController,
              labelText: 'Payee',
              prefixIcon: const Icon(Icons.person, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _reasonController,
              labelText: 'Reason',
              prefixIcon: const Icon(Icons.notes, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: _amountController,
              labelText: 'Amount',
              prefixIcon: const Icon(Icons.attach_money, color: Colors.grey),
              keyBoardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                await AddUserHelper.pickDate(
                    context: context, initialDate: DateTime.now())
                    .then((date) {
                  setState(() {
                    if (date != null) {
                      String formattedDate =
                      DateFormat('yyyy/MM/dd').format(date);
                      _dateController.text = formattedDate;
                    }
                  });
                });
              },
              child: CustomTextField(
                enabled: false,
                controller: _dateController,
                prefixIcon: const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                ),
                labelText: 'Date',
              ),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Pallete.greyAccent),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Is Fully Approved?',
                  style: TextStyle(
                    fontSize: 12,
                  ),
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
            ),
            const SizedBox(height: 20),
            Center(
              child: GeneralButton(
                onTap: () {
                  final updatedRequisition = widget.requisition.copyWith(
                    payee: _payeeController.text,
                    reason: _reasonController.text,
                    amount: double.tryParse(_amountController.text) ?? 0.0,
                    date: DateFormat('yyyy/MM/dd').parse(_dateController.text),
                    isFullyApproved: _isFullyApproved,
                  );

                  RequisitionHelpers.updateRequisition(
                      requisition: updatedRequisition);
                },
                borderRadius: 10,
                btnColor: Pallete.primaryColor,
                width: 300,
                child: const Text(
                  "Edit Requisition",
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
