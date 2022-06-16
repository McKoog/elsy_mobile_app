import 'package:elsy_mobile_app/data/apistorage/api_storage_fuel_dialog_data_impl.dart';
import 'package:elsy_mobile_app/data/localstorage/local_storage_user_impl.dart';
import 'package:elsy_mobile_app/screens/fueldialog/controller/fuelDialogController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class FuelDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (FuelDialogController(
        localStorageInterfaceUser: Get.put(LocalStorageImplUser()),
        apiStorageInterfaceData: Get.put(ApiStorageFuelDialogData()))
    )/*, fenix: true*/);
  }
}