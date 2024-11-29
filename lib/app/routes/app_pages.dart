import 'package:get/get.dart';

import '../modules/home/bindings/maps_binding.dart';
import '../modules/home/views/maps_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAPS;

  static final routes = [
    GetPage(
      name: _Paths.MAPS,
      page: () => MapsPage(),
      binding: MapsBinding(),
    ),
  ];
}
