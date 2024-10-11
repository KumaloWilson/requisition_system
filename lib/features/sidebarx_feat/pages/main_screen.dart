import 'package:req_sys_finale/core/constants/dimensions.dart';
import 'package:req_sys_finale/features/sidebarx_feat/pages/user_tabs_container.dart';
import 'package:req_sys_finale/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../../custom_widgets/sidebar/sidebar.dart';
import 'admin_tabs_container.dart';

class MainScreen extends StatelessWidget {
  final UserRole selectedRole;
  final User user;
  MainScreen({super.key, required this.selectedRole, required this.user});
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          key: _key,
          body: Row(
            children: [
              if (!Dimensions.isSmallScreen) Sidebar(controller: _controller),
              Expanded(
                child: Center(
                  child: selectedRole == UserRole.admin
                      ? AdminTabScreensContainer(
                          controller: _controller,
                        )
                      : UserTabScreensContainer(
                          controller: _controller,
                          user: user,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
