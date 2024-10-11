import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/add_user_services.dart';

class StaffNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  StaffNotifier() : super(const AsyncValue.loading()) {
    streamUsers();
  }

  // Stream users and update state in real-time
  void streamUsers() {
    try {
      // Listen to Firestore user stream
      StaffServices.streamAllUsers().listen((users) {
        state = AsyncValue.data(users);
      }, onError: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      });
    } catch (e, stackTrace) {
      state = AsyncValue.error('An unexpected error occurred: $e', stackTrace);
    }
  }
}
