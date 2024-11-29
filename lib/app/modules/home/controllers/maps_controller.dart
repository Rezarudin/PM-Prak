import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapsController extends GetxController {
  late GoogleMapController mapController;

  // Lokasi default: Malang
  final Rx<LatLng> currentLocation = const LatLng(-7.9666, 112.6326).obs;

  @override
  void onInit() {
    super.onInit();
    // Menjaga lokasi default (Malang) saat aplikasi pertama kali dibuka
    // Jangan langsung ubah lokasi saat inisialisasi
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Pastikan peta dimulai dengan lokasi default (Malang)
    animateCameraToLocation(currentLocation.value);
  }

  // Fungsi untuk mendapatkan lokasi pengguna dan memperbarui lokasi peta
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Layanan lokasi tidak aktif.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          Get.snackbar('Error', 'Izin lokasi ditolak secara permanen.');
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Jika lokasi pengguna berhasil ditemukan, perbarui posisi dan arahkan kamera ke lokasi pengguna
      currentLocation.value = LatLng(position.latitude, position.longitude);

      // Tampilkan Snackbar dengan latitude dan longitude
      Get.snackbar(
        'Lokasi Ditemukan',
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );

      // Pindahkan kamera ke lokasi pengguna
      animateCameraToLocation(currentLocation.value);
    } catch (e) {
      Get.snackbar('Error', 'Gagal mendapatkan lokasi: $e');
    }
  }

  // Fungsi untuk menggerakkan kamera ke lokasi tertentu
  void animateCameraToLocation(LatLng location) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 17.0, // Zoom level untuk memperbesar tampilan lokasi
        ),
      ),
    );
  }

  // Fungsi untuk mengembalikan ke lokasi default (Malang)
  void resetToDefaultLocation() {
    currentLocation.value =
        const LatLng(-7.9666, 112.6326); // Lokasi default: Malang
    animateCameraToLocation(currentLocation.value);
  }
}
