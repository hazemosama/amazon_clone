import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      dismissDirection: DismissDirection.down,
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (var i in files.files) {
        images.add(File(i.path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
