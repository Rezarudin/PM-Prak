import 'package:get/get.dart';
import 'package:myapp/app/data/service/image_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageController>(
      () => ImageController(),
    );
  }
}
