import 'dart:math';
import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/constants/local_image_constants.dart';
import 'package:req_sys_finale/custom_widgets/text_fields/custom_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/utils/providers.dart';
import '../../../custom_widgets/sidebar/user_drawer.dart';
import '../../not_found/user_profile_not_found.dart';
import 'admin_tabs/requisition_tab.dart';

class UserHomeScreen extends ConsumerStatefulWidget {
  const UserHomeScreen({super.key});

  @override
  ConsumerState<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends ConsumerState<UserHomeScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  String searchTerm = '';
  late TabController _tabController;
  final _key = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  List<Requisition> requisitions = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(ProviderUtils.profileProvider(user!.email!));

    return userProfileAsync.hasValue
        ? Scaffold(
            key: _key,
            drawer: Dimensions.isSmallScreen
                ? UserDrawer(
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
                                    borderRadius: BorderRadius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl: user!.photoURL ?? '',
                                  placeholder: (context, url) => Skeletonizer(
                                    enabled: true,
                                    child: SizedBox(
                                      child: Image.asset(
                                        LocalImageConstants.logo,
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfileAsync.value!.name ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  userProfileAsync.when(
                                    data: (userProfile) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userProfile.post!,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    loading: () => const Skeletonizer(
                                        child: Text(
                                      'Post  ',
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    error: (error, stackTrace) =>
                                        Text('Error: $error'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                            labelText: 'Find some Requisitions',
                            prefixIcon: const Icon(Icons.search),
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchTerm = value!;
                              });
                            },
                          ),
                        ],
                      ))),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'My Requisitions',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    unselectedLabelStyle:
                        TextStyle(color: Pallete.greyAccent, fontSize: 14),
                    labelStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    tabAlignment: TabAlignment.start,
                    tabs: const [
                      Tab(text: 'Pending'),
                      Tab(text: 'Approved'),
                      Tab(text: 'Declined'),
                      Tab(text: 'Cancelled'),
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
            ),
          )
        : const UserProfileNotFound();
  }
}
