import 'package:req_sys_finale/core/utils/string_methods.dart';
import 'package:req_sys_finale/features/documents/helpers/document_helper.dart';
import 'package:req_sys_finale/features/workers/helper/storage_helper.dart';
import 'package:req_sys_finale/features/documents/models/document.dart';
import 'package:req_sys_finale/features/manage_profile/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/color_constants.dart';
import '../../../custom_widgets/custom_button/general_button.dart';
import '../../../custom_widgets/snackbar/custom_snackbar.dart';
import '../../../custom_widgets/text_fields/custom_text_field.dart';
import '../../workers/helper/add_user_helper.dart';
import '../../workers/services/media_services.dart';

class AddDocumentScreen extends StatefulWidget {
  final UserProfile selectedUser;
  const AddDocumentScreen({super.key, required this.selectedUser});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final TextEditingController _documentNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController expiryDateTextEditing = TextEditingController();
  User? currentUser;
  List<Document> documents = [];
  String selectedDocumentUrl = "";
  dynamic selectedFile;

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
            _buildDocumentUpload(),
            const SizedBox(height: 12),
            CustomTextField(
              controller: descriptionController,
              labelText: 'Description',
              prefixIcon: const Icon(Icons.description, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                await AddUserHelper.pickDate(
                        context: context, initialDate: DateTime.now())
                    .then((date) {
                  setState(() {
                    if (date != null) {
                      String formattedDate =
                          DateFormat('yyyy/MM/dd').format(date);
                      expiryDateTextEditing.text = formattedDate;
                    }
                  });
                });
              },
              child: CustomTextField(
                enabled: false,
                controller: expiryDateTextEditing,
                prefixIcon: const Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                ),
                labelText: 'Expiry Date',
              ),
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
          'Add Document',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Pallete.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDocumentUpload() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CustomTextField(
            controller: _documentNameController,
            labelText: 'Document Name',
            prefixIcon: const Icon(Icons.description, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: GeneralButton(
            onTap: () async {
              selectedFile = await MediaServices.pickDocument();
            },
            borderRadius: 10,
            btnColor: Colors.white,
            width: 60,
            height: 50,
            boxBorder: Border.all(color: Pallete.primaryColor),
            child: Icon(Icons.upload, color: Pallete.primaryColor),
          ),
        )
      ],
    );
  }

  Widget _buildUpdateButton() {
    return Center(
      child: GeneralButton(
        onTap: () async {
          if (selectedFile != null) {
            await StorageHelper.triggerDocUpload(
                    documentName: _documentNameController.text,
                    selectedFile: selectedFile)
                .then((documentUrl) {
              if (documentUrl != null) {
                setState(() {
                  selectedDocumentUrl = documentUrl;
                  documents.add(Document(
                    docID: StringMethods.generateRandomString(),
                    documentName: _documentNameController.text,
                    expiryDate: expiryDateTextEditing.text,
                    documentDescription: descriptionController.text,
                    documentUrl: documentUrl,
                  ));
                });

                // Once uploaded, validate and submit the document
                DocumentHelper.validateAndSubmitDocument(
                  profile: widget.selectedUser,
                  docName: _documentNameController.text,
                  docDescription: descriptionController.text,
                  expiryDate: expiryDateTextEditing.text,
                  docLink: documentUrl,
                );
              } else {
                CustomSnackBar.showErrorSnackbar(
                    message: 'Document upload failed.');
              }
            });
          } else {
            CustomSnackBar.showErrorSnackbar(
                message: 'Please pick a document to upload first');
          }
        },
        borderRadius: 10,
        btnColor: Pallete.primaryColor,
        width: 300,
        child: const Text(
          "Add Document",
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
