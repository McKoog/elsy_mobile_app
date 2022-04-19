import '/screens/splash/controller/splashController.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(
        localStorageInterfaceUser: Get.find(),
        apiStorageInterfaceMarkers: Get.find(),
        apiStorageInterfaceUser: Get.find()));
  }
}
