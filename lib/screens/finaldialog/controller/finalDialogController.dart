import '/data/localstorage/local_storage_user_impl.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/screens/paydialog/payDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'package:get/get.dart';
import 'package:tinkoff_acquiring/tinkoff_acquiring.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class FinalDialogController extends GetxController {
  final LocalStorageInterfaceUser localStorageInterfaceUser;

  FinalDialogController({required this.localStorageInterfaceUser});

  List<double> pricePerLiter = [44.40, 47.50, 53.20 , 32.15];

  final finalData = Get.arguments;
  final fuelTypeStandart = "АИ-92".obs;

  PickerController pickerController =
      PickerController(count: 1, selectedItems: [0]);

  final litreTextController = TextEditingController();
  final valueTextController = TextEditingController();
  final valueFromTypeOfFuel = '44.40'.obs;

  // Future<String> pay() async {
  //   const String terminalKey = '1605280872049';
  //   const String password = 'xtiprrmg73jkiklh';
  //   const int amount = 10;
  //   String cardData = '';
  //
  //   final TinkoffAcquiring acquiring = TinkoffAcquiring(
  //       TinkoffAcquiringConfig(
  //           terminalKey: terminalKey,
  //           password: password,
  //         debug: true,
  //       )
  //   );
  //   final InitResponse init = await acquiring.init(InitRequest(
  //     orderId: (99 +
  //         math.Random(DateTime.now().millisecondsSinceEpoch)
  //             .nextInt(100000))
  //         .toString(),
  //     amount: amount,
  //     language: Language.ru,
  //     payType: PayType.one,
  //   ));
  //   final url = init.paymentURL;
  //   if(await canLaunch(url!)){
  //     await launch(
  //       url,
  //       forceWebView: true,
  //       enableJavaScript: true,
  //       enableDomStorage: true,
  //     );
  //   }
  //   final GetStateResponse getState = await acquiring.getState(
  //     GetStateRequest(
  //       paymentId: int.parse(init.paymentId!),
  //     ),
  //   );
  //   return getState.status.toString();
  // }
  @override
  onInit() {
    initalDialog();
    super.onInit();
  }

  initalDialog() async {
    final token = await localStorageInterfaceUser.getToken();
    final fuelID = finalData[0];
    final fuelName = finalData[1];
    final valueType = finalData[3];
    final value = finalData[4];
    final columnNumber = finalData[5];
    final fuelType = finalData[6];

    pickerController.animateToRow(int.parse(columnNumber) - 1, atSection: 0);
    fuelTypeStandart.value = fuelType;

    if (valueType.toString() == "litre") {
      litreTextController.text = value;
      valueTextController.text = (double.parse(value!) * 50 /*valueFromTypeOfFuel.value*/).toString();
    } else if (valueType.toString() == "money") {
      valueTextController.text = value;
      litreTextController.text = (double.parse(value!) / 50 /*valueFromTypeOfFuel.value*/).toString();
    }
  }
  navigateToPayDialog(){

    Get.back();
    Get.dialog(PayDialog(), barrierDismissible: true, arguments: [
      "${finalData[0]}", //ID [0]
      "${finalData[1]}",
      "${finalData[2]}",
      "${finalData[3]}",
      "${finalData[4]}",
      "${finalData[7]}",
      "${finalData[8]}",
      "${finalData[9]}",
    ]);
    print(finalData[0] +
        " " +
        finalData[1] +
        " " +
        finalData[2] +
        " " +
        finalData[3] +
        " " +
        finalData[4] +
        " " +
        finalData[5] +
        " " +
        finalData[6] +
        " " +
        finalData[7] +
        " " +
        finalData[8] +
        " " +
        finalData[9] +
        " ");

  }
  onBackButtonTap(){
    navigateToPayDialog();
  }
  setTheValuePricePerLiter(){

    if(fuelTypeStandart.value == 'АИ-92'){ valueFromTypeOfFuel.value = pricePerLiter[0].toString(); }
    if(fuelTypeStandart.value == 'АИ-95'){ valueFromTypeOfFuel.value = pricePerLiter[1].toString(); }
    if(fuelTypeStandart.value == 'АИ-100'){ valueFromTypeOfFuel.value = pricePerLiter[2].toString(); }
    if(fuelTypeStandart.value == 'Дизель'){ valueFromTypeOfFuel.value = pricePerLiter[3].toString(); }

  }
  litersChanged(String? value) {
    valueTextController.text =
        (double.parse(value!) * double.parse(valueFromTypeOfFuel.value)).toString();
  }
  resultChanged(String? value) {
    litreTextController.text =
        (double.parse(value!) / double.parse(valueFromTypeOfFuel.value)).toString();
  }
}
