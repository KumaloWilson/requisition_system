import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/constants/dimensions.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';

class RequisitionDetailsScreen extends StatefulWidget {
  final Requisition requisition;
  final UserProfile userProfile;
  const RequisitionDetailsScreen({
    super.key,
    required this.requisition,
    required this.userProfile
  });

  @override
  State<RequisitionDetailsScreen> createState() => _RequisitionDetailsScreenState();
}

class _RequisitionDetailsScreenState extends State<RequisitionDetailsScreen> {
  final _reasonController = TextEditingController();

  bool get canApprove {
    final userPost = widget.userProfile.post?.toLowerCase() ?? '';
    if (userPost == 'financial manager' && !widget.requisition.authorisedFM) {
      return true;
    }
    if (userPost == 'general manager' &&
        widget.requisition.authorisedFM &&
        !widget.requisition.authorisedByGM) {
      return true;
    }
    if (userPost == 'managing director' &&
        widget.requisition.authorisedFM &&
        widget.requisition.authorisedByGM &&
        !widget.requisition.authorisedByMD) {
      return true;
    }
    return false;
  }

  Future<void> _showDisapprovalDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reason for Disapproval'),
          content: TextField(
            controller: _reasonController,
            decoration: const InputDecoration(
              hintText: 'Enter reason for disapproval',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _reasonController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_reasonController.text.trim().isNotEmpty) {
                  // Handle disapproval with reason
                  Navigator.of(context).pop(_reasonController.text);
                  _reasonController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Disapprove',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Requisition Details',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Pallete.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0),
              child: Column(
                children: [
                  _buildDetailsCard(),
                  _buildApprovalStatus(),
                  if (widget.requisition.documents != null) _buildDocuments(),
                 _buildApprovalButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalButtons() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Action Required',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GeneralButton(
                    width: Dimensions.screenWidth,
                    onTap: (){

                    },
                    btnColor: Pallete.primaryColor,
                    borderRadius: 10,
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GeneralButton(
                    width: Dimensions.screenWidth,
                    onTap: _showDisapprovalDialog,
                    btnColor: Pallete.redColor,
                    borderRadius: 10,
                    child: const Text(
                      'Disapprove',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: Dimensions.screenWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Pallete.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'REQ-${widget.requisition.id}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Amount: ${NumberFormat.currency(symbol: '\$').format(widget.requisition.amount)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Date: ${DateFormat('MMM dd, yyyy').format(widget.requisition.date)}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Prepared By', widget.requisition.preparedBy),
            _buildDetailRow('Checked By', widget.requisition.checkedBy),
            _buildDetailRow('Payee', widget.requisition.payee),
            _buildDetailRow('Created By', widget.requisition.createdBy),
            _buildDetailRow('Reason', widget.requisition.reason),
            _buildDetailRow('Received By', widget.requisition.receivedBy),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildApprovalStatus() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Approval Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildApprovalStep(
              'Finance Manager',
              widget.requisition.authorisedFM,
              isFirst: true,
            ),
            _buildApprovalStep(
              'General Manager',
              widget.requisition.authorisedByGM,
            ),
            _buildApprovalStep(
              'Managing Director',
              widget.requisition.authorisedByMD,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalStep(String title, bool isApproved, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                if (!isFirst)
                  const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isApproved ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isApproved ? Icons.check : Icons.pending,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                if (!isLast)
                  const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    isApproved ? 'Approved' : 'Pending',
                    style: TextStyle(
                      fontSize: 14,
                      color: isApproved ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocuments() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attached Documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...widget.requisition.documents!.map((doc) => ListTile(
              leading: const Icon(Icons.file_present),
              title: Text(doc.documentName),
              trailing: const Icon(Icons.download),
              onTap: () {
                // Handle document download/view
              },
            )).toList(),
          ],
        ),
      ),
    );
  }
}