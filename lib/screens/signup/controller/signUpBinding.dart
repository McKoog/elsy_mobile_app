import '/data/apistorage/api_storage_user_impl.dart';
import '/screens/signup/controller/signUpController.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (SignUpController(
        apiStorageInterfaceUser: Get.put(ApiStorageImplUser()))));
  }
}
