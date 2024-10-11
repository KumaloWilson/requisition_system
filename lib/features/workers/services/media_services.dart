import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaServices {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<dynamic?> getImageFromGallery() async {
    var fileResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (fileResult != null) {
      return fileResult;
    }

    return null;
  }

  static Future<List<File>?> getMultipleImagesFromGallery() async {
    final List<XFile> files = await _imagePicker.pickMultiImage();

    if (files.isNotEmpty) {
      return files.map((file) => File(file.path)).toList();
    }

    return null;
  }

  static Future<dynamic> pickDocument() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.bytes != null) {
      return {
        "bytes": result.files.single.bytes,
        "name": result.files.single.name
      };
    }
    return null;
  }

  static Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }
}
