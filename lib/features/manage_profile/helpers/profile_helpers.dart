import 'package:req_sys_finale/features/documents/models/document.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileHelpers {
  static String documentStatus(Document document) {
    final DateTime expiryDate =
        DateFormat('yyyy/MM/dd').parse(document.expiryDate!);
    final DateTime currentDate = DateTime.now();

    final int daysUntilExpiry = expiryDate.difference(currentDate).inDays;

    // Determine the color and status text based on the daysUntilExpiry
    String statusText;

    if (daysUntilExpiry < 0) {
      statusText = 'Expired';

      return statusText;
    } else if (daysUntilExpiry <= 15) {
      // The document expires in 15 days or less
      statusText = '$daysUntilExpiry days left';
      return statusText;
    } else {
      // The document is valid (more than 15 days until expiry)
      statusText = 'Valid';
      return statusText;
    }
  }
  static Future<void> viewDocument(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar('Error', 'Could not open the document.');
    }
  }
}
