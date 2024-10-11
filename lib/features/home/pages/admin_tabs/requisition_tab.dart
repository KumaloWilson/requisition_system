import 'package:req_sys_finale/custom_widgets/cards/requisitions_card.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:flutter/material.dart';

class RequisitionTab extends StatefulWidget {
  final String searchTerm;
  final List<Requisition> requisition;
  const RequisitionTab({
    super.key,
    required this.requisition,
    required this.searchTerm,
  });

  @override
  State<RequisitionTab> createState() => _RequisitionTabState();
}

class _RequisitionTabState extends State<RequisitionTab> {
  @override
  Widget build(BuildContext context) {
    if (widget.requisition.isEmpty) {
      return const Center(child: Text('No Requisitions Found'));
    }

    final filteredUsers = widget.requisition.where((requisitions) {
      final nameMatch =
      requisitions.reason.toLowerCase().contains(widget.searchTerm.toLowerCase());
      final emailMatch =
      requisitions.preparedBy.toLowerCase().contains(widget.searchTerm.toLowerCase());
      return nameMatch || emailMatch;
    }).toList();

    if (filteredUsers.isEmpty) {
      return const Center(child: Text('No matching staff found.'));
    }

    return ListView.builder(
      itemCount: filteredUsers.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final requisition = filteredUsers[index];
        return RequisitionCard(requisition: requisition);
      },
    );
  }
}
