import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/routes/routes.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/providers.dart';

class AdminViewUsers extends ConsumerWidget {
  const AdminViewUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(ProviderUtils.staffProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Staff List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userState.when(
          data: (users) {
            if (users.isEmpty) {
              return const Center(
                child: Text('No users found.'),
              );
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Pallete.primaryColor.withOpacity(0.2))),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CachedNetworkImage(
                      imageUrl: '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                    ),
                    title: Text(
                      user.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      "${user.email}\n${user.phoneNumber}",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    trailing: SizedBox(
                      width: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            user.post!,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12),
                          ),
                          PopupMenuButton<int>(
                            itemBuilder: (BuildContext context) => [
                              buildPopUpOption(
                                title: 'View Profile',
                                icon: Icons.remove_red_eye_outlined,
                                value: 0,
                                onTap: () {
                                  Get.toNamed(RoutesHelper.userProfileScreen,
                                      arguments: user.email);
                                },
                              ),
                              buildPopUpOption(
                                  title: 'Add Shift',
                                  icon: Icons.calendar_month,
                                  value: 1,
                                  onTap: () => Get.toNamed(
                                      RoutesHelper.addRequisitionScreen,
                                      arguments: user)),
                              buildPopUpOption(
                                  title: 'Add Hours Worked',
                                  icon: Icons.watch_later_outlined,
                                  value: 2,
                                  onTap: () => Get.toNamed(
                                      RoutesHelper.addHoursWorkedScreen,
                                      arguments: [user])),
                              buildPopUpOption(
                                  title: 'Add Document',
                                  icon: Icons.file_copy,
                                  value: 2,
                                  onTap: () => Get.toNamed(
                                      RoutesHelper.addDocumentsScreen,
                                      arguments: [user])),
                              buildPopUpOption(
                                  title: 'Add Feedback',
                                  icon: Icons.feedback,
                                  value: 1,
                                  onTap: () => Get.toNamed(
                                      RoutesHelper.addUserFeedbackScreen,
                                      arguments: [user, null])),
                              buildPopUpOption(
                                  title: 'Edit Profile',
                                  icon: Icons.edit,
                                  value: 2,
                                  onTap: () => Get.toNamed(
                                      RoutesHelper.editUserProfileScreen,
                                      arguments: user)),
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to load users: $error'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(ProviderUtils.staffProvider.notifier)
                        .streamUsers();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: GeneralButton(
          onTap: () {
            Get.toNamed(RoutesHelper.adminAddUserScreen);
          },
          btnColor: Pallete.primaryColor,
          borderRadius: 10,
          width: 300,
          child: const Text(
            'Add User',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
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
