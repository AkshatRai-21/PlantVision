import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_app/utlis.dart';

class PlantApiService {
  Future<String> api(File? _file) async {
    try {
      // Upload the image to Firebase Storage and get the download URL
      String? downloadUrl = await storeFile(
        path: 'your_storage_path',
        filename: _file!.path.split('/').last, // Set the desired file extension
        file: _file,
      );

      if (downloadUrl != null) {
        // Now you can use the downloadUrl in your API request
        Dio dio = Dio();
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(_file.path),
        });

        Response response = await dio.post(
          'https://ayurvedic-plants-api.onrender.com/predict',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        if (response.statusCode == 200) {
          String content = response.data.toString();
          content = content.trim();
          print("apiresponse: $content");

          return content;
        } else {
          return 'An internal error occurred';
        }
      } else {
        return 'Error uploading file to Firebase Storage';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
