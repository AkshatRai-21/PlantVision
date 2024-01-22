import 'dart:io';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/api_service.dart';
import 'package:my_app/core/plant_list.dart';
import 'package:my_app/responsive/responsive.dart';
import 'package:my_app/utlis.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _file;
  bool _loading = false;
  String _apiResponse = ''; // Variable to store the API response
  Map<String, String>? plantInfo;

  Future<void> _pickImageFromFile() async {
    _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImageFromCamera() async {
    _pickImage(ImageSource.camera);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? xFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (xFile != null) {
        setState(() {
          _file = File(xFile.path);
          _loading = true;
        });

        // Trigger your API call here using PlantApiService
        PlantApiService plantApiService = PlantApiService();
        String apiResponse = await plantApiService.api(_file!);
        int extractedPlantId = extractIdFromApiResponse(apiResponse);
        Map<String, String>? newPlantInfo =
            Constants.getPlantInfoById(extractedPlantId);

        // Simulate API call delay
        // await Future.delayed(const Duration(seconds: 2));

        // Update the API response variable and plantInfo
        setState(() {
          _apiResponse = apiResponse;
          plantInfo = newPlantInfo;
          _loading = false;
        });

        // Once API call is complete, navigate to the back side of the card.
        _flipCardKey.currentState!.toggleCard();
      }
    } catch (e) {
      print("Error in Uploading Image: $e");
      // Handle the error as needed
    }
  }

  final GlobalKey<FlipCardState> _flipCardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlantVision: Green Explorer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Responsive(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Use the FlipCard widget to display both front and back sides
                FlipCard(
                  key: _flipCardKey,
                  flipOnTouch: true,
                  front: Stack(
                    children: [
                      Container(
                        // Display the selected image or XFile in the image preview
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                            style: BorderStyle.solid,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: _file != null
                            ? Image.file(
                                _file!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text(
                                  'Random Text\nuntil an image is selected',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                      if (_loading)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  back: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                              style: BorderStyle.solid,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                              child: _loading
                                  ? Text(
                                      'Searching...',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  : (plantInfo != null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name: ${plantInfo!['name']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              'Uses: ${plantInfo!['uses']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          'No Matching Plant found',
                                          style: TextStyle(fontSize: 16),
                                        )),
                            ),
                          ),
                        ),
                      ),
                      if (_loading)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _loading ? null : _pickImageFromFile,
                      child: const Text('Pick from File'),
                    ),
                    ElevatedButton(
                      onPressed: _loading ? null : _pickImageFromCamera,
                      child: const Text('Pick from Camera'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
