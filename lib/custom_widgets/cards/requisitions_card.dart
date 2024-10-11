import 'package:flutter/material.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';

class RequisitionCard extends StatelessWidget {
  final Requisition requisition;
  const RequisitionCard({super.key, required this.requisition});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                requisition.preparedBy,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                requisition.reason,
                style:const TextStyle(fontSize: 12),
              ),
              trailing: PopupMenuButton<int>(
                itemBuilder: (BuildContext context) => [
                  buildPopUpOption(
                    title: 'View Requisition',
                    icon: Icons.remove_red_eye_outlined,
                    value: 0,
                    onTap: () {

                    },
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic buildPopUpOption({
    required String title,
    required IconData icon,
    required int value,
    required void Function() onTap,
  }) {
    return PopupMenuItem<int>(
      onTap: onTap,
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
