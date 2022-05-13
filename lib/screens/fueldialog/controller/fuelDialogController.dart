import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/routes/navigation.dart';
import '/screens/paydialog/payDialog.dart';
import '/utils/parseStandartSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'package:get/get.dart';

class FuelDialogController extends GetxController {

   String UserSettingsLiters = '';

  var fuelArgData = Get.arguments;
  late List<int> list = [];
  var trkPickerValue = 2.obs;
  List<String> availableFuel = ['АИ-92','АИ-95','Premium','ДТ',].obs;
  List<Color?> colorsOfBlocks = [Colors.grey.shade800,Colors.grey.shade800,Colors.grey.shade800].obs;
  var pickedOne;

  PickerController pickerController =
      PickerController(count: 6, selectedItems: [0, 0, 0, 0, 0, 0]);

  final LocalStorageInterfaceUser localStorageInterfaceUser;

  FuelDialogController({required this.localStorageInterfaceUser});

  @override
  void onInit() {
    getStockLitres();
    makeAvailableListOfFuelByNumber(trkPickerValue.value);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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

  makeAvailableListOfFuelByNumber(int TRK){
    pickedOne = null;
    if (TRK == 1){
      availableFuel.clear();
      availableFuel.add('АИ-92');
      availableFuel.add('АИ-95');
      availableFuel.add('ДТ');
      colorsOfBlocks.clear();
      for (int i = 0; i <= availableFuel.length-1; i++){
        colorsOfBlocks.add(Colors.grey.shade800);
      }
    }
    if (TRK == 2) {
      availableFuel.clear();
      availableFuel.add('АИ-92');
      availableFuel.add('АИ-95');
      availableFuel.add('Premium');
      colorsOfBlocks.clear();
      for (int i = 0; i <= availableFuel.length-1; i++){
        colorsOfBlocks.add(Colors.grey.shade800);
      }
    }
    if (TRK == 3){
      availableFuel.clear();
      availableFuel.add('ДТ');
      colorsOfBlocks.clear();
      for (int i = 0; i <= availableFuel.length-1; i++){
        colorsOfBlocks.add(Colors.grey.shade800);
      }
    }
    if (TRK >= 4){
      availableFuel.clear();
      availableFuel.add('АИ-92');
      availableFuel.add('АИ-95');
      availableFuel.add('Premium');
      availableFuel.add('ДТ');
      // availableFuel.add('АИ-100');
      // availableFuel.add('АИ-102');
      colorsOfBlocks.clear();
      for (int i = 0; i <= availableFuel.length-1; i++){
        colorsOfBlocks.add(Colors.grey.shade800);
      }
    }
  }

  navigateToQR() {
    //TODO: ADD ARGS;git
    Get.toNamed(Routes.qruser, preventDuplicates: false);
  }

  navigateToPayDialog() {
    Get.back();
    Get.dialog(PayDialog(), barrierDismissible: true, arguments: [
      "${fuelArgData[0]}",
      "${fuelArgData[1]}",
      "${fuelArgData[2]}",
      trkPickerValue.value, // Номер колонки
      "${availableFuel[pickedOne]}", // Тип топлива
      UserSettingsLiters,
      // "litre",
      // "$result",
      // "${fuelArgData[3]}",
      // "${fuelArgData[4]}",
      // "${fuelArgData[5]}",
    ]);
    print(fuelArgData[0] +
        " " +
        fuelArgData[1] +
        " " +
        fuelArgData[2]+
        " " +
        trkPickerValue.value.toString() +
        " " +
        availableFuel[pickedOne] +
        " " +
        UserSettingsLiters);
  }

  onNextButtonTap() {
    //TODO: Add check on null
    if(pickedOne != null) {
      if(Get.isSnackbarOpen){
        Get.back();
        navigateToPayDialog();
      }
      else{navigateToPayDialog();}
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
