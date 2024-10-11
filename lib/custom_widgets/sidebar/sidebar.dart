import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/utils/providers.dart';
import 'package:req_sys_finale/global/global.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/shared_pref.dart';
import '../../features/auth/services/auth_service.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(ProviderUtils.userRoleProvider);

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        hoverColor: Colors.blueGrey.withOpacity(0.4),
        textStyle: TextStyle(
            color: Pallete.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        selectedTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        itemTextPadding: const EdgeInsets.only(left: 20),
        selectedItemTextPadding: const EdgeInsets.only(left: 20),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Pallete.primaryColor.withOpacity(0.2),
          border: Border.all(color: Pallete.primaryColor, width: 3),
        ),
        iconTheme: IconThemeData(
          color: Pallete.primaryColor,
          size: 22,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 22,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      footerDivider: const Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Icon(
                Icons.account_circle,
                size: 60,
                color: Pallete.primaryColor,
              ),
            ),
          ),
        );
      },
      items: [
        const SidebarXItem(
          icon: Icons.home,
          label: 'Home',
        ),
        SidebarXItem(
          icon: userRole == UserRole.admin ? Icons.edit_note : Icons.person,
          label: userRole == UserRole.admin ? 'Add User' : 'User Profile',
        ),
        SidebarXItem(
          icon: Icons.auto_graph_outlined,
          label: userRole == UserRole.admin
              ? 'Staff Statistics'
              : 'Work Statistics',
        ),
        if (userRole == UserRole.admin)
          const SidebarXItem(
            icon: Icons.analytics,
            label: 'Shift Statistics',
          ),
        SidebarXItem(
          icon: Icons.logout,
          label: 'Sign Out',
          onTap: () async {
            await CacheUtils.clearUserRoleFromCache().then((_) async {
              await AuthServices.signOut();
            });
          },
        ),
      ],
    );
  }
}
