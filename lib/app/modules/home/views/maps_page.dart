import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/app/modules/home/controllers/maps_controller.dart';
import 'package:url_launcher/url_launcher.dart'; // Untuk membuka Google Maps

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapsController controller = Get.put(MapsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps with GetX'),
      ),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol untuk mencari lokasi
                FloatingActionButton.extended(
                  onPressed: () async {
                    await controller.getCurrentLocation();
                    controller.mapController.animateCamera(
                      CameraUpdate.newLatLng(controller.currentLocation.value),
                    );
                  },
                  label: const Text('Cari Lokasi'),
                  icon: const Icon(Icons.location_searching),
                ),
                SizedBox(
                  height: 10,
                ),
                // Tombol untuk membuka Google Maps
                FloatingActionButton.extended(
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://www.google.com/maps/search/?api=1&query=${controller.currentLocation.value.latitude},${controller.currentLocation.value.longitude}',
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url,
                          mode: LaunchMode.externalApplication);
                    } else {
                      Get.snackbar('Error', 'Tidak dapat membuka Google Maps');
                    }
                  },
                  label: const Text('Buka Maps'),
                  icon: const Icon(Icons.map),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
