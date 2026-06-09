import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<List<String>> convertImagesToBase64(List<XFile> images) async {
  List<String> base64Images = [];

  for (var img in images) {
    try {
      final file = File(img.path);
      final bytes = await file.readAsBytes();
      base64Images.add(base64Encode(bytes));
    } catch (e) {
      debugPrint("ERROR IMAGE: $e");
    }
  }

  return base64Images;
}