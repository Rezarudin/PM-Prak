import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/home/views/maps_page.dart';
import 'package:myapp/app/modules/home/bindings/maps_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MapsBinding(), // Pastikan ini terpasang
      home: MapsPage(),
    );
  }
}
