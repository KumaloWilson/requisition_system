import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../documents/models/document.dart';

class HomeHelper {
  static void showExpiringDocuments({required String message, required List<Document> documents}) {
    // Define the date format matching 'YYYY/MM/DD'
    final DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    // Parse the document expiry date using the defined format
    final documentList = documents.map((doc) {
      DateTime expiryDate;
      try {
        expiryDate = dateFormat.parse(doc.expiryDate!);
      } catch (e) {
        // If parsing fails, print the error and return an empty string for that document
        print("Error parsing date: ${doc.expiryDate}");
        return '- ${doc.documentName}: Invalid expiry date';
      }
      return '- ${doc.documentName}: expires on ${DateFormat('yyyy/MM/dd').format(expiryDate)}';
    }).join('\n');

    // Show the dialog using Get.dialog
    Get.dialog(
        AlertDialog(
          title: const Text("Expiring Documents"),
          content: Text("$message\n\n$documentList"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
        barrierDismissible: false,
        useSafeArea: true,
        name: 'Expiry Alert'
    );
  }
}
