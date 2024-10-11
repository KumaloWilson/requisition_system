import 'package:req_sys_finale/features/notes/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/api_response.dart';

class NotesServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a user to Firebase Firestore
  static Future<APIResponse<String?>> addNotesToFirebase({
    required Note note,
  }) async {
    try {
      final userNotes = note.toJson();
      await _firestore.collection('notes').add(userNotes);

      return APIResponse(
          success: true, data: '', message: 'Notes added successfully');
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  // Existing method for fetching feedback by email
  static Stream<List<Note>> streamNotesByEmail({required String email}) {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Note.fromJson(doc.data())).toList();
    });
  }
}
