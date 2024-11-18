import 'dart:io';
import 'package:myapp/app/data/service/image_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends GetView<ImageController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Selected Image",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return controller.isImageLoading.value
                          ? CircularProgressIndicator()
                          : controller.selectedImagePath.value.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(controller.selectedImagePath.value),
                                    fit: BoxFit.cover,
                                    height: 400,
                                    width: double.infinity,
                                  ),
                                )
                              : const Text(
                                  "No image selected",
                                  style: TextStyle(color: Colors.grey),
                                );
                    }),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => controller.getImage(ImageSource.camera),
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Pick Image from Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => controller.getImage(ImageSource.gallery),
                      icon: const Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                      label: const Text("Pick Image from Gallery",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Navigation button to go to the next page
            ElevatedButton(
              onPressed: () =>
                  Get.toNamed(Routes.VIDEO), // Replace with your actual route
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Video Picker",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
