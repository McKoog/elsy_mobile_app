import 'dart:async';

import 'package:flutter/cupertino.dart';

import '/screens/finaldialog/finalDialog.dart';
import '/screens/paydialog/controller/payController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

Widget pumpLabel(PayDialogController controller) {
  return Text(controller.payData[0], style: TextStyle(fontSize: 25));
}

Widget infoLabel(PayDialogController controller) {
  return Text(controller.payData[1].toString(), style: TextStyle(fontSize: 15));
}

Widget nextButton(PayDialogController controller) {
  return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () => controller.onNextButtonTap(),
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(63, 81, 181, 1)),
          child: Text("column_dialog_pay_button".tr)));
}

Widget backButton(PayDialogController controller) {
  return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () => controller.onBackButtonTap() ,
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text("register_back_button".tr),
      ));
}

final Widget spacingW = SizedBox(
  width: 16,
);

final Widget spacingH = SizedBox(
  height: 16,
);

Widget InputWindowLabel(String RubOrLit){
  return Center(
    child: Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.white.withOpacity(0.1)),
        color: Colors.grey.shade800,
      ),
      //width: 140,
      //height: 35,
      child: RubOrLit == 'Rub' ? Text("Рубли", style: TextStyle(letterSpacing: 5)) : Text("Литры", style: TextStyle(letterSpacing: 5)),
      padding: EdgeInsets.all(2),
    ),
  );
}

Widget InputWindow(PayDialogController controller, String RubOrLit){
  return Container(
    width: 200,
    height: 70,
    decoration: BoxDecoration(
        color: Color.fromRGBO(80, 80, 80, 1),
        image: DecorationImage(
            image: AssetImage("assets/backgroundLogin.png"),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),),
    alignment: Alignment.center,
    child: Center(
      child: SizedBox(
        width: 300,
        height: 70,
        child: Obx((){return TextFormField(
          //autofocus: true,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+")),LengthLimitingTextInputFormatter(RubOrLit == 'Rub' ? 5 : 3),],
          keyboardType: TextInputType.numberWithOptions(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, letterSpacing: 15),
          //initialValue: controller.fullRublesResult.value.toStringAsFixed(2),
          decoration: InputDecoration(
            //labelText: 'Рубли',
            helperText: RubOrLit == 'Rub' ? 'Рублей: ${controller.fullRublesResult.value.toStringAsFixed(2)}' :'Литров: ${controller.fullLitresResult.value.toStringAsFixed(2)}',
            helperStyle: TextStyle(fontSize: 14,),
            // suffixText: ".00",
            // suffixStyle: TextStyle(fontSize: 20,),
            label: InputWindowLabel(RubOrLit),
            filled: true,
            fillColor: Colors.grey.shade800,
            hoverColor: Colors.grey.shade800.withOpacity(0.5),
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
          ),
          controller: RubOrLit == 'Rub' ? controller.RublesTextController : controller.LitreTextController,
          onFieldSubmitted: (string){
            if(RubOrLit == 'Rub'){
              controller.fullRublesResult.value = int.tryParse(string)!.toDouble();
              controller.fullLitresResult.value = controller.countFullResult(controller.fullRublesResult.value, 'Lit');
              controller.LitreTextController.text = controller.fullLitresResult.toInt().toString();
            }
            else{
              controller.fullLitresResult.value = int.tryParse(string)!.toDouble();
              controller.fullRublesResult.value = controller.countFullResult(controller.fullLitresResult.value, 'Rub');
              controller.RublesTextController.text = controller.fullRublesResult.toInt().toString();
            }
          },
          onTap:(){
            if(RubOrLit == 'Rub'){
              controller.lastPicked = 'Money';
            }
            else{
              controller.lastPicked = 'Litres';
            }
          } ,
        );}),
      ),
    ),
  );
}