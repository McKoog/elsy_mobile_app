import 'package:elsy_mobile_app/data/apistorage/api_storage_fuel_dialog_data_impl.dart';

import '../../../infrastructurestorage/data/api_storage_interface_data.dart';
import '../../../infrastructurestorage/user/api_storage_user_infrastructure.dart';
import '../../../models/dataServer/fuelDialogData.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/routes/navigation.dart';
import '/screens/paydialog/payDialog.dart';
import '/utils/parseStandartSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/dataServer/Order.dart';

List<String> GlobalFuels = ['ДТ','АИ-92','АИ-95','АИ-98'];
class FuelDialogController extends GetxController {

  String UserSettingsLiters = '';

  Order order = Order();
  var fuelArgData = Get.arguments;
  var trkPickerValue = 1.obs;
  List<String> availableFuel = ['ДТ','АИ-92','АИ-95','АИ-98',].obs;
  List<Color?> colorsOfBlocks = [Colors.grey.shade800,Colors.grey.shade800,Colors.grey.shade800].obs;
  var pickedOne;
  late Future<FuelDialogData> data;
  String? clientId;

  final LocalStorageInterfaceUser localStorageInterfaceUser;
  final ApiStorageInterfaceData apiStorageInterfaceData;

   FuelDialogController(
       {required this.localStorageInterfaceUser, required this.apiStorageInterfaceData});

  @override
  void onInit() {
    getStockLitres();
    data = getFuelDialogData();
    getClientId();
    order.ClientId = clientId;

    order.id = "1";
    order.dateCreate = DateTime.now();
    order.StationId = int.parse(fuelArgData[0]);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

   getFuelDialogData(){
    final d = apiStorageInterfaceData.getFuelDialogData(fuelArgData[0],fuelArgData[3]);
    return d;
  }

  getClientId() async{
    final clientId = await localStorageInterfaceUser.getToken();
  }

  getBonusUser() async {}

  getStockLitres () async{
    final settings = await localStorageInterfaceUser.getUserSettings();
    print("${settings.name} ${settings.email} ${settings.fuelType} ${settings.fuelSize}");
    UserSettingsLiters = settings.fuelSize;
  }

  increasePickerValue(){
    trkPickerValue.value++;
  }
  decreasePickerValue(){
    trkPickerValue.value--;
  }

  makeAvailableListOfFuelByNumber(int TRK,List<FPData> fpData){
    pickedOne = null;
    int c = 0;
    for(int i = 0;i < fpData.length;i++){
        if (fpData[i].id == TRK - 1) {
          availableFuel.clear();
          colorsOfBlocks.clear();
          for (int k = 0; k < fpData[i].fuelsInfo!.length; k++) {
            availableFuel.add(fpData[i].fuelsInfo![k].fuelName!);
          }
          for (int i = 0; i <= availableFuel.length - 1; i++) {
            colorsOfBlocks.add(Colors.grey.shade800);
          }
        }
        else{
          c++;
        }
        if(c == fpData.length){
          availableFuel.clear();
        }
    }
  }

  navigateToQR() {
    //TODO: ADD ARGS;git
    Get.toNamed(Routes.qruser, preventDuplicates: false);
  }

  navigateToPayDialog(FuelDialogData data) {

    order.FuelPointId = trkPickerValue.value-1;
    order.FuelId = pickedOne;
    order.FuelMarka = availableFuel[pickedOne];
    //order.PriceId =
    order.Price = data.fPData!.firstWhere((element) => element.id == trkPickerValue.value-1).fuelsInfo![pickedOne].fuelPrice!;
    order.PriceId = data.fPData!.firstWhere((element) => element.id == trkPickerValue.value-1).fuelsInfo![pickedOne].priceId!;


    Get.back();
    Get.dialog(PayDialog(), barrierDismissible: true, arguments: [
      "${fuelArgData[1]}",
      "${fuelArgData[2]}",
      UserSettingsLiters,
      order,
      fuelArgData[3]
    ]);
  }

  onNextButtonTap(FuelDialogData data) {

    if(pickedOne != null) {
      if(Get.isSnackbarOpen){
        Get.back(closeOverlays: true);
        navigateToPayDialog(data);
      }
      else{
        navigateToPayDialog(data);
      }
    }
    else {
      if(!Get.isSnackbarOpen) {
        Get.snackbar(
            'Ошибка', 'Выберите тип топлива',
            snackPosition: SnackPosition.TOP,
            duration: Duration(milliseconds: 1500));
      }
    }
  }
}
