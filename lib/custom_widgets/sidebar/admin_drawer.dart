import 'package:req_sys_finale/core/constants/local_image_constants.dart';
import 'package:req_sys_finale/core/routes/routes.dart';
import 'package:req_sys_finale/core/utils/shared_pref.dart';
import 'package:req_sys_finale/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import '../../core/constants/color_constants.dart';

class AdminDrawer extends StatefulWidget {
  final UserProfile user;
  const AdminDrawer({super.key, required this.user});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.32,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.18,
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .grey.shade300, // Light color for top shadow
                            offset: const Offset(-5, -5),
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors
                                .grey.shade500, // Dark color for bottom shadow
                            offset: const Offset(5, 5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: ClipOval(
                          child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Image.asset(LocalImageConstants.logo),
                      )
                          //  CachedNetworkImage(
                          //   imageUrl: widget.user.photoURL ??
                          //       "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          //   width: MediaQuery.of(context).size.height * 0.18,
                          //   height: MediaQuery.of(context).size.height * 0.18,
                          //   fit: BoxFit.cover,
                          //   placeholder: (context, url) => Skeletonizer(
                          //     enabled: true,
                          //     child: SizedBox(
                          //       height: MediaQuery.of(context).size.height * 0.45,
                          //       child: Image.asset(LocalImageConstants.logo),
                          //     ),
                          //   ),
                          //   errorWidget: (context, url, error) =>
                          //       const Icon(Icons.error),
                          // ),
                          ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.user.name ?? 'username',
                            style: TextStyle(
                              fontSize: 14,
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.user.email ?? 'example@email.com',
                            style: TextStyle(
                              fontSize: 12,
                              color: Pallete.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Pallete.primaryColor,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Get.toNamed(RoutesHelper.adminHomeScreen);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.auto_graph,
                color: Pallete.primaryColor,
              ),
              title: const Text(
                'Staff Statistics',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Get.toNamed(RoutesHelper.adminStaffStatsScreen);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.bar_chart,
                color: Pallete.primaryColor,
              ),
              title: const Text(
                'Shift Statistics',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Get.toNamed(RoutesHelper.adminShiftStatsScreen);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt_outlined,
                color: Pallete.primaryColor,
              ),
              title: const Text(
                'Add Staff',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Get.toNamed(RoutesHelper.adminAddUserScreen);
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Pallete.primaryColor,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.navigate_next),
                onTap: () async {}),
            ListTile(
              onTap: () async {
                await CacheUtils.clearUserRoleFromCache().then((_) async {
                  await AuthServices.signOut();
                });
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
