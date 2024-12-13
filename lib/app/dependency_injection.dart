import 'package:modul_2_public_api/app/modules/connection/bindings/connection_binding.dart';

class DependencyInjection {
  
  static void init() {
    ConnectionBinding().dependencies();
  }
}