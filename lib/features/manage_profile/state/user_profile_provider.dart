import 'package:req_sys_finale/core/utils/logs.dart';
import 'package:req_sys_finale/features/workers/services/add_user_services.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/api_response.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final String profileEmail;

  ProfileNotifier({required this.profileEmail})
      : super(const AsyncValue.loading()) {
    fetchUser(profileEmail: profileEmail);
  }

  Future<void> fetchUser({required String profileEmail}) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      // Fetch user profile from the service
      final APIResponse<UserProfile> response =
          await StaffServices.fetchUserProfile(profileEmail: profileEmail);

      if (response.success) {
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(
            response.message ?? 'Failed to fetch user', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('An unexpected error occurred: $e', stackTrace);
    }
  }
}
