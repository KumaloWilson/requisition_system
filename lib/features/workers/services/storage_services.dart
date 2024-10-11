import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../core/utils/api_response.dart';

class StorageServices {
  static Future<APIResponse<String>> uploadFileAsBase64({
    required String base64String,
    required String fileName,
  }) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('documents/$fileName');
      final uploadTask =
          storageRef.putString(base64String, format: PutStringFormat.base64);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return APIResponse<String>(data: downloadUrl, success: true);
    } catch (e) {
      return APIResponse<String>(message: e.toString(), success: false);
    }
  }

  static Future<APIResponse<String>> uploadDocumentAsUint8List({
    required String location,
    required dynamic uploadfile,
    required String fileName,
  }) async {
    Get.log("Uploading document $fileName");
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('$location/$fileName');
      var uploadTask;
      if (location == "users/dps") {
        final metadata = SettableMetadata(
          contentType: "image/png",
        );
        uploadTask = storageRef.putData(uploadfile, metadata);
      } else {
        uploadTask = storageRef.putData(uploadfile);
      }

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return APIResponse<String>(data: downloadUrl, success: true);
    } catch (e) {
      return APIResponse<String>(message: e.toString(), success: false);
    }
  }

  static Future<APIResponse<File>> downloadAndDecodeFile(
      String url, String savePath) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      final base64String = await ref.getData();
      if (base64String != null) {
        final bytes = base64Decode(String.fromCharCodes(base64String));
        final file = File(savePath);
        await file.writeAsBytes(bytes);
        return APIResponse<File>(data: file, success: true);
      }
      return APIResponse<File>(
          message: "Failed to decode the file.", success: false);
    } catch (e) {
      return APIResponse<File>(message: e.toString(), success: false);
    }
  }
}
