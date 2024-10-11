import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/constants/dimensions.dart';
import 'package:req_sys_finale/custom_widgets/text_fields/custom_text_field.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/home/pages/admin_tabs/requisition_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/providers.dart';
import '../../../custom_widgets/sidebar/admin_drawer.dart';
import '../../manage_profile/models/user_profile.dart';
import '../../not_found/user_profile_not_found.dart';
import 'admin_tabs/staff_tab.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber
  ];
  final _key = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  String searchTerm = '';
  final TextEditingController _searchTextEditingController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(ProviderUtils.profileProvider(user!.email!));

    final staffState = ref.watch(
      ProviderUtils.staffProvider,
    );

    return userProfileAsync.hasValue
        ? Scaffold(
      key: _key,
      drawer: Dimensions.isSmallScreen
          ? AdminDrawer(
        user: userProfileAsync.value!,
      )
          : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    if (Dimensions.isSmallScreen)
                      IconButton(
                        onPressed: () {
                          _key.currentState!.openDrawer();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.network(
                        userProfileAsync.value!.profilePicture ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfileAsync.value!.name ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user!.email ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  controller: _searchTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      searchTerm = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: _buildContentBasedOnRole(userProfileAsync.value!, staffState),
    )
        : const UserProfileNotFound();
  }

  Widget _buildContentBasedOnRole(UserProfile userProfile, AsyncValue<List<UserProfile>> staffState) {
    // If the user is an admin but not in an executive post, show only staff
    if (userProfile.role == 'admin' && !_isExecutivePost(userProfile.post!)) {
      return staffState.when(
        data: (users) => _buildStaffForAdmin(users),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      );
    }

    // If the user is an admin in an executive post, show the tabs with requisitions as the default view
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            unselectedLabelStyle: TextStyle(
              color: Pallete.greyAccent,
              fontSize: 14,
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            tabAlignment: TabAlignment.fill,
            tabs: const [
              Tab(text: 'Requisitions'),
              Tab(text: 'Staff'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRequisitionsForExecutives([]),
                staffState.when(
                  data: (users) => _buildStaffForAdmin(users),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(child: Text('Error: $error')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isExecutivePost(String post) {
    return post.toLowerCase() == 'managing director' ||
        post.toLowerCase() == 'general manager' ||
        post.toLowerCase() == 'finance director' ||
        post.toLowerCase() == 'sales director';
  }


  Widget _buildStaffForAdmin(List<UserProfile> users) {
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
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                StaffTab(
                  searchTerm: searchTerm,
                  users: users
                      .where((user) =>
                  user.post!.toLowerCase() == 'managing director' ||
                      user.post!.toLowerCase() == 'general manager' ||
                      user.post!.toLowerCase() == 'finance director' ||
                      user.post!.toLowerCase() == 'sales director'
                  ).toList(),
                ),
                StaffTab(
                  searchTerm: searchTerm,
                  users: users
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


  Widget _buildRequisitionsForExecutives(List<Requisition> requisitions) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Requisitions',
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
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
            ],
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                RequisitionTab(
                  searchTerm: searchTerm,
                  requisition: requisitions
                      .where((requisition) =>  requisition.authorisedByMD == false
                  ).toList(),
                ),
                RequisitionTab(
                  searchTerm: searchTerm,
                  requisition: requisitions
                      .where((requisition) =>  requisition.authorisedByMD == true
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
