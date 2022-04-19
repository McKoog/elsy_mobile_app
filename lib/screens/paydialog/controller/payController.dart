import 'dart:async';

import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/screens/finaldialog/controller/finalDialogController.dart';
import '/screens/finaldialog/finalDialog.dart';
import '/screens/fueldialog/fuelDialogScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'package:get/get.dart';

class PayDialogController extends GetxController {
  LocalStorageInterfaceUser localStorageInterfaceUser;

  PayDialogController({required this.localStorageInterfaceUser});

  List<double> pricePerLiter = [44.40, 47.50, 53.20, 32.17];
  var choosedPriceIndex = 0;


  var payData = Get.arguments;
  var standartFuel = "АИ-92".obs;


  String scheme = '';
  int TrkNumber = 1;


  var RublesPickerValue1 = 0.obs;
  var RublesPickerValue2 = 0.obs;
  var RublesPickerValue3 = 0.obs;
  var RublesPickerValue4 = 0.obs;
  var RublesPickerValue5 = 0.obs;

  var fullRublesResult = 0.0.obs;
  int oldRublesResult = 0;


  var LitrePickerValue1 = 0.obs;
  var LitrePickerValue2 = 0.obs;
  var LitrePickerValue3 = 0.obs;

  var fullLitresResult = 0.0.obs;
  int oldLitresResult = 0;


  List<RxInt> RublesPickerValues = [];
  List<RxInt> LitrePickerValues = [];

  final LitreTextController = TextEditingController();
  final RublesTextController = TextEditingController();


  var maxRubles = 0.0;


  List<FixedExtentScrollController> ScrollOfLitrePickers = [];
  List<FixedExtentScrollController> ScrollOfRublesPickers = [];

  String lastScrolled = '';

  List<int> MaxesForRublesPickers = [];
  List<int> ChildRublesCounts = [];

  var PhysicsChanged = true.obs;

  List<ScrollPhysics> LitScrollPhysics = [FixedExtentScrollPhysics(),FixedExtentScrollPhysics(),FixedExtentScrollPhysics()];
  List<ScrollPhysics> RubScrollPhysics = [FixedExtentScrollPhysics(),FixedExtentScrollPhysics(),FixedExtentScrollPhysics(),FixedExtentScrollPhysics(),FixedExtentScrollPhysics()];

  var fixOldLit = '';

  bool canRublesPickerChange = true;
  bool canLitrePickerChange = true;
  List<bool> callbacksDone = [true,true,true,true,true,true,true,true];

  @override
  onInit() {

    setControllerRublesValuesInList();
    setControllerLitresValuesInList();

    TrkNumber = payData[3];
    standartFuel.value = payData[4];
    fullLitresResult.value = double.parse(payData[5]);
    if (standartFuel == 'АИ-92') {
      choosedPriceIndex = 0;
    }
    if (standartFuel == 'АИ-95') {
      choosedPriceIndex = 1;
    }
    if (standartFuel == 'Premium') {
      choosedPriceIndex = 2;
    }
    if (standartFuel == 'ДТ') {
      choosedPriceIndex = 3;
    }
    maxForRublesPicker();
    initChildRublesCount();
    fullRublesResult.value = countFullResult(fullLitresResult.value, 'Rub');
    if (int.parse(payData[5]) < 100) {
      scheme = 'TwoFour';
    }
    else {
      scheme = 'ThreeFive';
      maxRubles = 999.99 * pricePerLiter[choosedPriceIndex];
    }
    print('Количество топлива: ' + fullLitresResult.value.toString());

     setLitresPickerAndMiliLiters(fullLitresResult.value);
     setRublesPickerAndKopeyki(fullRublesResult.value);



    super.onInit();
  }

  rebuildAfterChangeOfPhysics(bool canLPChange, bool canRPChange){
    canLitrePickerChange = canLPChange;
    canRublesPickerChange = canRPChange;
    if (PhysicsChanged.value == true) {
      PhysicsChanged.value = false;
    }
    else {
      PhysicsChanged.value = true;
    }
  }

  changePhysics(String RubOrLit, bool canPickerChange) {
    print('Физика изменена');
    // if(RubOrLit == 'Rub') {
    //   // for(int i = 0; i < ScrollOfRublesPickers.length;i++){
    //   //   ScrollOfRublesPickers[i].position.context.setCanDrag(canPickerChange);
    //   if (canRublesPickerChange != canPickerChange) {
    //     canRublesPickerChange = canPickerChange;
    //     if (PhysicsChanged.value == false) {
    //       PhysicsChanged.value = true;
    //     }
    //     else {
    //       PhysicsChanged.value = false;
    //     }
    //   }
    // }
    //   else {
    //   if (canLitrePickerChange != canPickerChange) {
    //     canLitrePickerChange = canPickerChange;
    //     if (PhysicsChanged.value == false) {
    //       PhysicsChanged.value = true;
    //     }
    //     else {
    //       PhysicsChanged.value = false;
    //     }
    //   }
    // }
    if (RubOrLit == 'Rub') {
      if(canPickerChange) {
        if (RubScrollPhysics[0].toString() == 'NeverScrollableScrollPhysics') {
          for (int i = 0; i < RubScrollPhysics.length; i++) {
            RubScrollPhysics[i] = FixedExtentScrollPhysics();
            // print('Поменяли на меняемую');
          }
        }
      }
      else{
        if(RubScrollPhysics[0].toString() == 'FixedExtentScrollPhysics') {
          for (int i = 0; i < RubScrollPhysics.length; i++) {
            RubScrollPhysics[i] = NeverScrollableScrollPhysics();
            // print('Поменяли на неменяемую');
          }
        }
      }
    }
    else {
      if(canPickerChange) {
        if (LitScrollPhysics[0].toString() == 'NeverScrollableScrollPhysics') {
          for (int i = 0; i < LitScrollPhysics.length; i++) {
            LitScrollPhysics[i] = FixedExtentScrollPhysics();
            // print('Поменяли на меняемую');
          }
        }
      }
      else {
        if(LitScrollPhysics[0].toString() == 'FixedExtentScrollPhysics') {
          for (int i = 0; i < LitScrollPhysics.length; i++) {
            LitScrollPhysics[i] = NeverScrollableScrollPhysics();
            print('Поменяли на неменяемую');
          }
        }
      }
    }
  }

  checkPickersScrollEnd(){
    for(int i = 0;i < ScrollOfLitrePickers.length;i++) {
    }
  }

  initChildRublesCount(){
    ChildRublesCounts.add(MaxesForRublesPickers[0] + 1);
    for(int i = 0; i < 4;i++) {
      ChildRublesCounts.add(10);
    }
  }

  setControllerRublesValuesInList() {
    RublesPickerValues.add(RublesPickerValue1);
    RublesPickerValues.add(RublesPickerValue2);
    RublesPickerValues.add(RublesPickerValue3);
    RublesPickerValues.add(RublesPickerValue4);
    RublesPickerValues.add(RublesPickerValue5);
  }

  setControllerLitresValuesInList() {
    LitrePickerValues.add(LitrePickerValue1);
    LitrePickerValues.add(LitrePickerValue2);
    LitrePickerValues.add(LitrePickerValue3);
  }


  maxForRublesPicker(){
    int max = ((999.99 * pricePerLiter[choosedPriceIndex]) ~/ 1);
    MaxesForRublesPickers.add(max ~/ 10000);
    MaxesForRublesPickers.add((max ~/ 1000) - (MaxesForRublesPickers[0] * 10));
    MaxesForRublesPickers.add((max ~/ 100) - ((MaxesForRublesPickers[0] * 100) + (MaxesForRublesPickers[1] * 10)));
    MaxesForRublesPickers.add((max ~/ 10) - ((MaxesForRublesPickers[0] * 1000) + (MaxesForRublesPickers[1] * 100) + (MaxesForRublesPickers[2] * 10)));
    MaxesForRublesPickers.add((max ~/ 1) - ((MaxesForRublesPickers[0] * 10000) + (MaxesForRublesPickers[1] * 1000) + (MaxesForRublesPickers[2] * 100) + MaxesForRublesPickers[3] * 10));

  }

  double countFullResult(double stock, String RubOrLit) {
    if (RubOrLit == 'Rub') {
      return stock * pricePerLiter[choosedPriceIndex];
    }

    if (RubOrLit == 'Lit') {
      return stock / pricePerLiter[choosedPriceIndex];
    }

    else
      return 0.0;
  }

  animatePickers(String RubOrLit) {
    if (RubOrLit == 'Rub') {
      for (int i = 0; i < ScrollOfRublesPickers.length; i++) {
        if (ScrollOfRublesPickers[i].selectedItem !=
            RublesPickerValues[i].value) {
          ScrollOfRublesPickers[i].animateToItem(
              RublesPickerValues[i].value,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut);
          // ScrollOfRublesPickers[i].jumpToItem(
          //     RublesPickerValues[i].value);
        }
      }
      print('Значения всех пикеров рублей изменены');
    }
    else {
      for (int i = 0; i < ScrollOfLitrePickers.length; i++) {
        if (ScrollOfLitrePickers[i].selectedItem !=
            LitrePickerValues[i].value) {
          ScrollOfLitrePickers[i].animateToItem(
              LitrePickerValues[i].value, duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut);
          // ScrollOfLitrePickers[i].jumpToItem(
          //     LitrePickerValues[i].value);
        }
      }
    }
  }

  setRublesPickerAndKopeyki(double value) {

    if (scheme == 'TwoFour') {
      if (value / 1000 != 0) {
        RublesPickerValue1.value = (value ~/ 1000);
        value -= (RublesPickerValue1.value * 1000);
      } else {
        RublesPickerValue1.value = 0;
      }
      if (value / 100 != 0) {
        RublesPickerValue2.value = (value ~/ 100);
        value -= (RublesPickerValue2.value * 100);
      } else {
        RublesPickerValue2.value = 0;
      }
      if (value / 10 != 0) {
        RublesPickerValue3.value = (value ~/ 10);
        value -= (RublesPickerValue3.value * 10);
      } else {
        RublesPickerValue3.value = 0;
      }
      if (value / 1 >= 1) {
        RublesPickerValue4.value = value ~/ 1;
      } else {
        RublesPickerValue4.value = 0;
      }
    }
    else {
      if (value / 10000 != 0) {
        RublesPickerValue1.value = (value ~/ 10000);
        value -= (RublesPickerValue1.value * 10000);
      } else {
        RublesPickerValue1.value = 0;
      }
      if (value / 1000 != 0) {
        RublesPickerValue2.value = (value ~/ 1000);
        value -= (RublesPickerValue2.value * 1000);
      } else {
        RublesPickerValue2.value = 0;
      }
      if (value / 100 != 0) {
        RublesPickerValue3.value = (value ~/ 100);
        value -= (RublesPickerValue3.value * 100);
      } else {
        RublesPickerValue3.value = 0;
      }
      if (value / 10 >= 1) {
        RublesPickerValue4.value = value ~/ 10;
        value -= (RublesPickerValue4.value * 10);
      } else {
        RublesPickerValue4.value = 0;
      }
      if (value / 1 >= 1) {
        RublesPickerValue5.value = value ~/ 1;
      } else {
        RublesPickerValue5.value = 0;
      }
    }
  }

  setLitresPickerAndMiliLiters(double stock) {

    if (scheme == 'TwoFour') {
      if (stock / 10 >= 1) {
        LitrePickerValue1.value = (stock ~/ 10);
        stock -= (LitrePickerValue1.value * 10);
      } else {
        LitrePickerValue1.value = 0;
      }
      if (stock / 1 >= 1) {
        LitrePickerValue2.value = stock ~/ 1;
      } else {
        LitrePickerValue2.value = 0;
      }
    }
    else if (scheme == 'ThreeFive') {
      if (stock / 100 >= 1) {
        LitrePickerValue1.value = (stock ~/ 100);
        stock -= (LitrePickerValue1.value * 100);
      } else {
        LitrePickerValue1.value = 0;
      }
      if (stock / 10 >= 1) {
        LitrePickerValue2.value = (stock ~/ 10);
        stock -= (LitrePickerValue2.value * 10);
      } else {
        LitrePickerValue2.value = 0;
      }
      if (stock / 1 >= 1) {
        LitrePickerValue3.value = stock ~/ 1;
      } else {
        LitrePickerValue3.value = 0;
      }
    }
  }

  setIndexedDigitForResult(int index, int value, String RubOrLit){

    if(RubOrLit == 'Rub'){

      var ind0 = 0;
      var ind1 = 0;
      var ind2 = 0;
      var ind3 = 0;
      var ind4 = 0;

      ind0 = fullRublesResult.value ~/ 10000;
      ind1 = fullRublesResult.value ~/ 1000 - ind0 * 10;
      ind2 = fullRublesResult.value ~/ 100 - (ind0 * 100 + ind1 * 10);
      ind3 = fullRublesResult.value ~/ 10 - (ind0 * 1000 + ind1 * 100 + ind2 * 10);
      ind4 = (fullRublesResult.value - (ind0 * 10000 + ind1 * 1000 + ind2 * 100 + ind3 * 10)) ~/ 1;

      if(index == 0){
        fullRublesResult.value = (fullRublesResult.value - ind0 * 10000) + (value * 10000);
        print('[AFTER PICKER] Новый результат рублей : ' + fullRublesResult.value.toString());
      }
      if(index == 1){
        fullRublesResult.value = (fullRublesResult.value - ind1 * 1000) + (value * 1000);
        print('[AFTER PICKER] Новый результат рублей : ' + fullRublesResult.value.toString());
      }
      if(index == 2){
        fullRublesResult.value = (fullRublesResult.value - ind2 * 100) + (value * 100);
        print('[AFTER PICKER] Новый результат рублей : ' + fullRublesResult.value.toString());
      }
      if(index == 3){
        fullRublesResult.value = (fullRublesResult.value - ind3 * 10) + (value * 10);
        print('[AFTER PICKER] Новый результат рублей : ' + fullRublesResult.value.toString());
      }
      if(index == 4){
        fullRublesResult.value = fullRublesResult.value - ind4 + value;
        print('[AFTER PICKER] Новый результат рублей : ' + fullRublesResult.value.toString());
      }
    }
    if(RubOrLit == 'Lit'){

      var ind0 = 0;
      var ind1 = 0;
      var ind2 = 0;

      ind0 = fullLitresResult.value ~/ 100;
      ind1 = fullLitresResult.value ~/ 10 - (ind0 * 10);
      ind2 = (fullLitresResult.value ~/ 1 - (ind0 * 100 + ind1 * 10));

      if(index == 0){
        fullLitresResult.value = (fullLitresResult.value - ind0 * 100) + (value * 100);
        print('[AFTER PICKER] Новый результат литров : ' + fullLitresResult.value.toString());
      }
      if(index == 1){
        fullLitresResult.value = (fullLitresResult.value - ind1 * 10) + (value * 10);
        print('[AFTER PICKER] Новый результат литров : ' + fullLitresResult.value.toString());
      }
      if(index == 2){
        fullLitresResult.value = fullLitresResult.value - ind2 + value;
        print('[AFTER PICKER] Новый результат литров : ' + fullLitresResult.value.toString());
      }

    }
  }

  navigateToFinalScreen() {
    Get.back();
    Get.dialog(FinalDialog(), barrierDismissible: true, arguments: [
      "${payData[0]}", //ID [0]
      "${payData[1]}", //Name Pump [1]
      "${payData[2]}",
      "${payData[3]}", //Litre/Rub [2]
      "${payData[4]}", //Money or Litre value [3]
      //Column number [4]
      "${standartFuel.value}", //Fuel Type [5]
      "${payData[5]}",
      "${payData[6]}",
      "${payData[7]}",
    ]);
    print(payData[0] +
        " " +
        payData[1] +
        " " +
        payData[2] +
        " " +
        payData[3] +
        " " +
        payData[4] +
        " " +
        payData[5] +
        " " +
        payData[6] +
        " " +
        payData[7] +
        " " +
        " " +
        standartFuel.value);
  }

  navigateToFuelDialog() {
    Get.back();
    Get.dialog(FuelDialog(), barrierDismissible: true, arguments: [
      "${payData[0]}", //ID [0]
      "${payData[1]}",
      "${payData[2]}",
    ]);
  }

  // initialDialog() async {
  //   final user = await localStorageInterfaceUser.getUserSettings();
  //   if(user.fuelType != null) {
  //     standartFuel.value = user.fuelType;
  //   }
  // }

  onNextButtonTap() {
    navigateToFinalScreen();
  }

  onBackButtonTap() {
    navigateToFuelDialog();
  }
}