import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageController extends GetxController {
  // Image picker and GetStorage objects
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();

  // Observable variables for image
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var isImageLoading = false.obs;

  // Observable variables for video
  var selectedVideoPath = ''.obs;
  var isVideoPlaying = false.obs;
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }

  // Function to pick image from camera or gallery
  Future<void> getImage(ImageSource imageSource) async {
    isImageLoading.value = true;

    try {
      final pickedFile = await _picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        selectedImageSize.value =
            (File(selectedImagePath.value).lengthSync() / 1024 / 1024)
                    .toStringAsFixed(2) +
                " MB";
        box.write('imagePath', selectedImagePath.value);
      } else {
        Get.snackbar('Error', 'No image selected',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking image: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isImageLoading.value = false;
    }
  }

  // Function to pick video from camera or gallery
  Future<void> pickVideo(ImageSource source) async {
    isImageLoading.value = true;

    try {
      final pickedFile = await _picker.pickVideo(source: source);
      if (pickedFile != null) {
        selectedVideoPath.value = pickedFile.path;
        box.write('videoPath', selectedVideoPath.value);

        // Initialize VideoPlayerController
        videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path))
              ..initialize().then((_) {
                videoPlayerController!.play();
                isVideoPlaying.value = true;
                update(); // Update UI
              });
      } else {
        Get.snackbar('Error', 'No video selected',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error picking video: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isImageLoading.value = false;
    }
  }

  // Function to load stored data from GetStorage
  void _loadStoredData() {
    selectedImagePath.value = box.read('imagePath') ?? '';
    selectedVideoPath.value = box.read('videoPath') ?? '';

    // Load video if there's a stored path
    if (selectedVideoPath.value.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.file(File(selectedVideoPath.value))
            ..initialize().then((_) {
              videoPlayerController!.play();
              isVideoPlaying.value = true;
              update(); // Update UI
            });
    }
  }

  // Function to play video
  void play() {
    videoPlayerController?.play();
    isVideoPlaying.value = true;
    update(); // Update UI
  }

  // Function to pause video
  void pause() {
    videoPlayerController?.pause();
    isVideoPlaying.value = false;
    update(); // Update UI
  }

  // Function to toggle play/pause
  void togglePlayPause() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isVideoPlaying.value = false;
      } else {
        videoPlayerController!.play();
        isVideoPlaying.value = true;
      }
      update(); // Update UI
    }
  }
}
