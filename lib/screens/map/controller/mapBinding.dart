import '/data/apistorage/api_storage_markers_impl.dart';
import '/data/apistorage/api_storage_user_impl.dart';
import '/data/localstorage/local_storage_user_impl.dart';
import '/screens/map/controller/mapController.dart';
import 'package:get/get.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (MapScreenController(
        apiStorageInterfaceUser: Get.put(ApiStorageImplUser()),
        localStorageInterfaceUser: Get.put(LocalStorageImplUser()),
        apiStorageInterfaceMarkers: Get.put(ApiStorageMarkerImpl()))));
  }
}
