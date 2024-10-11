import 'package:req_sys_finale/features/home/pages/user_home_screen.dart';
import 'package:req_sys_finale/features/manage_profile/pages/manage_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class UserTabScreensContainer extends StatelessWidget {
  const UserTabScreensContainer(
      {super.key, required this.controller, required this.user});
  final User user;
  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const UserHomeScreen();
          case 1:
            return UserProfileScreen(profileEmail: user.email!);
          case 2:
            return Container();
          default:
            return Text(
              'Not Found',
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
