import 'package:get/get.dart';
import 'package:myapp/app/modules/home/controllers/maps_controller.dart';

class MapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(() => MapsController());
  }
}
