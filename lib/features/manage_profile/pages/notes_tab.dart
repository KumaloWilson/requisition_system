import 'package:req_sys_finale/core/utils/logs.dart';
import 'package:req_sys_finale/core/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../custom_widgets/cards/notes_card.dart';

class NotesTab extends ConsumerWidget {
  final String selectedUserEmail;

  const NotesTab({super.key, required this.selectedUserEmail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the shiftsProvider using the profileEmail
    final notesState =
        ref.watch(ProviderUtils.notesProvider(selectedUserEmail));

    return Scaffold(
      body: notesState.when(
          data: (notes) {
            if (notes.isEmpty) {
              return const Center(child: Text('No Notes Found.'));
            }

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NotesCard(note: note);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            DevLogs.logError(error.toString());
            return Center(
              child: Text('Error: $error'),
            );
          }),
    );
  }
}
