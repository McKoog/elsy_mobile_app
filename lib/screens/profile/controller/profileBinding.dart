import '/screens/profile/controller/profileController.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (ProfileController(
        apiStorageInterfaceUser: Get.find(),
        localStorageInterfaceUser: Get.find())));
  }
}
