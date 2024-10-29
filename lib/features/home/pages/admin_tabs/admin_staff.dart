import 'package:flutter/material.dart';
import 'package:req_sys_finale/features/home/pages/admin_tabs/staff_tab.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';

import '../../../../core/constants/color_constants.dart';

class AdminStaffUsers extends StatefulWidget {
  final List<UserProfile> users;
  final String searchTerm;
  const AdminStaffUsers({super.key, required this.users, required this.searchTerm});

  @override
  State<AdminStaffUsers> createState() => _AdminStaffUsersState();
}

class _AdminStaffUsersState extends State<AdminStaffUsers> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Staff',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TabBar(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            unselectedLabelStyle: TextStyle(
              color: Pallete.greyAccent,
              fontSize: 14,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'Executive'),
              Tab(text: 'Operational'),
            ],
          ),
          SizedBox(
            height: 800,
            child: TabBarView(
              controller: _tabController,
              children: [
                StaffTab(
                  searchTerm: widget.searchTerm,
                  users: widget.users
                      .where((user) =>
                  user.post!.toLowerCase() == 'managing director' ||
                      user.post!.toLowerCase() == 'general manager' ||
                      user.post!.toLowerCase() == 'finance director' ||
                      user.post!.toLowerCase() == 'sales director'
                  ).toList(),
                ),
                StaffTab(
                  searchTerm: widget.searchTerm,
                  users: widget.users
                      .where((user) =>
                  user.post!.toLowerCase() != 'managing director' &&
                      user.post!.toLowerCase() != 'general manager' &&
                      user.post!.toLowerCase() != 'finance director' &&
                      user.post!.toLowerCase() != 'sales director')
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
