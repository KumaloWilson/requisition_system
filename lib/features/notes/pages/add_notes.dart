import 'package:req_sys_finale/core/utils/string_methods.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:req_sys_finale/features/notes/models/note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../custom_widgets/custom_button/general_button.dart';
import '../../../custom_widgets/text_fields/custom_text_field.dart';
import '../helper/notes_helper.dart';

class AddNotesScreen extends StatefulWidget {
  final UserProfile selectedUser;
  const AddNotesScreen({super.key, required this.selectedUser});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController noteTextEditing = TextEditingController();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.selectedUser.name!,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _titleController,
              labelText: 'Note Title',
              prefixIcon: const Icon(Icons.description, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: descriptionController,
              labelText: 'Note Description',
              prefixIcon: const Icon(Icons.description, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: noteTextEditing,
              prefixIcon: const Icon(
                Icons.edit_document,
                color: Colors.grey,
              ),
              labelText: 'Note',
            ),
            const SizedBox(height: 20),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Pallete.primaryColor, width: 2),
          ),
          child: Icon(
            Icons.edit_document,
            size: 100,
            color: Pallete.primaryColor,
          ),
        ),
        Text(
          'Add Note',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Pallete.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return Center(
      child: GeneralButton(
        onTap: () {
          final note = Note(
              content: noteTextEditing.text,
              noteID: StringMethods.generateRandomString(),
              title: _titleController.text,
              description: descriptionController.text,
              email: widget.selectedUser.email!,
              addedBy: currentUser!.email!,
              dateAdded: DateTime.now());

          NotesHelper.validateAndSubmitNotes(note: note);
        },
        borderRadius: 10,
        btnColor: Pallete.primaryColor,
        width: 300,
        child: const Text(
          "Add Notes",
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
