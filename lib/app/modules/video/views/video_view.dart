import 'package:myapp/app/data/service/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoView extends GetView<ImageController> {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Picker'),
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
                      "Selected Video",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return controller.selectedVideoPath.value.isNotEmpty
                          ? Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: controller.videoPlayerController
                                          ?.value.aspectRatio ??
                                      1.0,
                                  child: VideoPlayer(
                                      controller.videoPlayerController!),
                                ),
                                VideoProgressIndicator(
                                  controller.videoPlayerController!,
                                  allowScrubbing: true,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        controller.isVideoPlaying.value
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.blue,
                                      ),
                                      onPressed: controller.togglePlayPause,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const Text(
                              "No video selected",
                              style: TextStyle(color: Colors.grey),
                            );
                    }),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => controller.pickVideo(ImageSource.camera),
                      icon: const Icon(
                        Icons.videocam,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Pick Video from Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () =>
                          controller.pickVideo(ImageSource.gallery),
                      icon: const Icon(
                        Icons.video_library,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Pick Video from Gallery",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
