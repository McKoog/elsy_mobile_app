import 'package:elsy_mobile_app/data/apistorage/api_storage_markers_impl.dart';

import '/data/apistorage/api_storage_user_impl.dart';
import '/data/localstorage/local_storage_user_impl.dart';
import '/screens/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (LoginController(
        localStorageInterface: Get.put(LocalStorageImplUser()),
        apiStorageInterface: Get.put(ApiStorageImplUser()),
        apiStorageInterfaceMarkers: Get.put(ApiStorageMarkerImpl()))));
  }
}
