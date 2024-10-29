import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/notes/state/notes_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/state/search_notifier.dart';
import '../../features/notes/models/note.dart';
import '../../features/shift/state/requisition_provider.dart';
import '../../features/workers/state/stuff_provider.dart';
import '../../features/auth/state/authentication_provider.dart';
import '../../features/manage_profile/state/user_profile_provider.dart';
import '../../features/manage_profile/models/user_profile.dart';
import '../../global/global.dart';

class ProviderUtils {
  static final staffProfilePicProvider = StateProvider<String?>((ref) => null);

  static final staffProvider = StateNotifierProvider<StaffNotifier, AsyncValue<List<UserProfile>>>(
          (ref) {
        return StaffNotifier();
      });

  static final notesProvider = StateNotifierProvider.family<NotesNotifier,
      AsyncValue<List<Note>>, String>((ref, profileEmail) {
    return NotesNotifier(profileEmail: profileEmail);
  });

  static final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
    return UserNotifier();
  });

  static final profileProvider = StateNotifierProvider.family<ProfileNotifier,
      AsyncValue<UserProfile>, String>((ref, profileEmail) {
    return ProfileNotifier(profileEmail: profileEmail);
  });

  static final requisitions = StateNotifierProvider.family<
      RequisitionsNotifier,
      AsyncValue<List<Requisition>>,
      String>((ref, profileEmail) {
    return RequisitionsNotifier(profileEmail: profileEmail);
  });

  // New provider for streaming all requisitions
  static final allRequisitionsProvider = StateNotifierProvider<RequisitionsNotifier,
      AsyncValue<List<Requisition>>>((ref) {
    final notifier = RequisitionsNotifier(profileEmail: '');
    notifier.streamAllRequisitions();
    return notifier;
  });

  static final searchProvider =
  StateNotifierProvider<SearchStaffNotifier, List<UserProfile>>((ref) {
    return SearchStaffNotifier();
  });

  static final userRoleProvider = StateProvider<UserRole?>((ref) {
    return null;
  });
}
