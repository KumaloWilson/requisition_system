import 'package:req_sys_finale/features/home/pages/admin_home_screen.dart';
import 'package:req_sys_finale/features/workers/pages/add_user.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class AdminTabScreensContainer extends StatelessWidget {
  const AdminTabScreensContainer({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const AdminHomeScreen();
          case 1:
            return const AdminAddUser();
          case 2:
            return Container();
          case 3:
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
