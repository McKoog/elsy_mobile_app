import 'package:get/instance_manager.dart';
import 'data/apistorage/api_storage_markers_impl.dart';
import 'data/apistorage/api_storage_user_impl.dart';
import 'data/localstorage/local_storage_user_impl.dart';
import 'infrastructurestorage/markers/api_storage_interface_markers.dart';
import 'infrastructurestorage/user/api_storage_user_infrastructure.dart';
import 'infrastructurestorage/user/local_storage_user_interface.dart';

class MainBinding extends Bindings {
  //Устанавливаем основные зависимости.
  @override
  void dependencies() {
    Get.lazyPut<LocalStorageInterfaceUser>(() => LocalStorageImplUser());
    Get.lazyPut<ApiStorageInterfaceUser>(() => ApiStorageImplUser());
    Get.lazyPut<ApiStorageInterfaceMarkers>(() => ApiStorageMarkerImpl());
  }
}
