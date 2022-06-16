import 'dart:async';

import '../../../models/dataServer/Order.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/screens/finaldialog/controller/finalDialogController.dart';
import '/screens/finaldialog/finalDialog.dart';
import '/screens/fueldialog/fuelDialogScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayDialogController extends GetxController {
  LocalStorageInterfaceUser localStorageInterfaceUser;

  PayDialogController({required this.localStorageInterfaceUser});

  double? price;

  var payData = Get.arguments;
  var standartFuel = "АИ-92".obs;

  int TrkNumber = 1;

  var fullRublesResult = 0.0.obs;
  var fullLitresResult = 0.0.obs;

  final LitreTextController = TextEditingController();
  final RublesTextController = TextEditingController();

  String lastPicked = '';

  Order? order;

  @override
  onInit() {
    order = payData[3];
    TrkNumber = order!.FuelPointId!;
    standartFuel.value = order!.FuelMarka!;
    fullLitresResult.value = double.parse(payData[2]);
    price = order!.Price;
    fullRublesResult.value = countFullResult(fullLitresResult.value, 'Rub');

     RublesTextController.text = fullRublesResult.value.toInt().toString();
     LitreTextController.text = fullLitresResult.value.toInt().toString();
    super.onInit();
  }

  double countFullResult(double stock, String RubOrLit) {
    if (RubOrLit == 'Rub') {
      return stock * price!;
    }

    if (RubOrLit == 'Lit') {
      return stock / price!;
    }

    else
      return 0.0;
  }

  navigateToFinalScreen() {
    order!.OrderType = lastPicked;
    lastPicked == "Money" ? order!.OrderVolume = fullRublesResult.value : order!.OrderVolume = fullLitresResult.value;
    order!.ResultPrice = fullRublesResult.value;
    order!.ResultLitres = fullLitresResult.value;

    Get.back();
    Get.dialog(FinalDialog(), barrierDismissible: true, arguments: [
      "${payData[0]}", //ID [0]
      "${payData[1]}", //Name Pump [1]
      "${payData[2]}",
      order,
      payData[4]
    ]);
  }

  navigateToFuelDialog() {
    Get.back();
    Get.dialog(FuelDialog(), barrierDismissible: true, arguments: [
      "${order!.StationId}", //ID [0]
      "${payData[0]}",
      "${payData[1]}",
      payData[4]
    ]);
  }

  onNextButtonTap() {
    navigateToFinalScreen();
  }

  onBackButtonTap() {
    navigateToFuelDialog();
  }
}