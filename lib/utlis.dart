import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<String?> storeFile({
  required String path,
  required String filename,
  required File? file,
}) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(path).child(filename);
    UploadTask uploadTask;

    uploadTask = ref.putFile(file!);

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print('Error uploading file: $e');
    return null;
  }
}

int extractIdFromApiResponse(String apiResponse) {
  try {
    // Remove curly braces and split the string to get "id: 31"
    String idString =
        apiResponse.replaceAll('{', '').replaceAll('}', '').trim();

    // Split by ":" to get ["id", "31"]
    List<String> idParts = idString.split(':');

    // Extract the id part and parse it to an integer
    int id = int.parse(idParts[1].trim());

    return id;
  } catch (e) {
    print("Error extracting id: $e");
    // Handle the error as needed, possibly return a default value or throw an exception
    return -1; // Default value or indicator for error
  }
}
