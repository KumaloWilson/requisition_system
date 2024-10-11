import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';

class SearchStaffNotifier extends StateNotifier<List<UserProfile>> {
  List<UserProfile> _allUsers = [];

  SearchStaffNotifier() : super([]);

  void setAllUsers(List<UserProfile> users) {
    _allUsers = users;
    state = users; // Initially, show all users
  }

  // Method to filter users based on search term
  void filterUsers(String searchTerm) {
    if (searchTerm.isEmpty) {
      state = _allUsers;
    } else {
      state = _allUsers
          .where((user) =>
              user.name != null &&
              user.name!.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
  }
}
