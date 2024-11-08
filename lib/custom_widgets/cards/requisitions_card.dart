import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:req_sys_finale/core/routes/routes.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:req_sys_finale/features/requisition_details/helper/requisition_helper.dart';

import '../../core/utils/providers.dart';

class RequisitionCard extends ConsumerWidget {
  final Requisition requisition;
  const RequisitionCard({super.key, required this.requisition,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(ProviderUtils.profileProvider(FirebaseAuth.instance.currentUser!.email!));

    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesHelper.requisitionDetailsScreen, arguments: [requisition, userProfileAsync.value]);
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
                    onTap: () {

                    },
                  ),
                  buildPopUpOption(
                    title: 'Save As PDF',
                    icon: Icons.download,
                    onTap: () async{
                      await RequisitionHelper.generateRequisitionPdf(requisition);
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
    required void Function() onTap,
  }) {
    return PopupMenuItem<int>(
      onTap: onTap,
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
