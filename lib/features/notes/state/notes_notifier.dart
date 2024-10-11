import 'dart:async';
import 'package:req_sys_finale/features/notes/services/notes_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/note.dart';

class NotesNotifier extends StateNotifier<AsyncValue<List<Note>>> {
  final String profileEmail;
  StreamSubscription<List<Note>>? _notesSubscription;

  NotesNotifier({required this.profileEmail})
      : super(const AsyncValue.loading()) {
    streamFeedbacks(profileEmail: profileEmail);
  }

  // Stream user shifts in real-time
  void streamFeedbacks({required String profileEmail}) {
    _notesSubscription?.cancel();

    _notesSubscription =
        NotesServices.streamNotesByEmail(email: profileEmail).listen(
      (notes) {
        state = AsyncValue.data(notes);
      },
      onError: (error) {
        state = AsyncValue.error(
            'Failed to fetch user notes: $error', StackTrace.current);
      },
    );
  }

  @override
  void dispose() {
    _notesSubscription?.cancel();
    super.dispose();
  }
}
