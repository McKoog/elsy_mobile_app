import '/screens/finaldialog/controller/finalDialogController.dart';
import '/screens/history/controller/historyController.dart';
import '/screens/payment_method/controller/paymentMethodController.dart';
import '/screens/payment_method/paymentMethodScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/finalDialogController.dart';


Widget pumpLabel(FinalDialogController controller) {
  return Text(controller.finalData[0], style: TextStyle(fontSize: 25));
}

Widget infoLabel(FinalDialogController controller) {
  return Text(controller.finalData[1], style: TextStyle(fontSize: 15));
}

final Widget spacingW = SizedBox(
  width: 16,
);

final Widget spacingH = SizedBox(
  height: 16,
);

Widget payButton(BuildContext context,HistoryController controller,FinalDialogController controller2) {
  return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () {
            print('added to history');
            controller.adress = controller2.finalData[0] + '\n' + controller2.finalData[1].toString().substring(0,controller2.finalData[1].toString().indexOf(' ',4))
                + '\n' + controller2.finalData[1].toString().substring(controller2.finalData[1].toString().indexOf(' ',4));
            controller.amount = controller2.order!.ResultLitres!.toStringAsFixed(2);
            controller.fuelSpotAndType = 'ТРК №' + ((controller2.order!.FuelPointId!+1).toString() + '\n' + controller2.order!.FuelMarka!);
            controller.priceAndBonus = controller2.order!.ResultPrice!.toStringAsFixed(2) + '\n ( +30 )';
            controller.addItem(context, controller);
            //controller3.pay(0);
            Get.dialog(PaymentMethodScreenOnFinal());
          },
          style: ElevatedButton.styleFrom(primary: Color.fromRGBO(38, 97, 37, 1).withOpacity(0.3)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.payment),
            Text("final_dialog_pay_button".tr)
          ])));
}

Widget backButton(FinalDialogController controller) {
  return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () => controller.onBackButtonTap(),
        style: ElevatedButton.styleFrom(primary: Color.fromRGBO(97, 37, 37, 1).withOpacity(0.3)),
        child: Text("register_back_button".tr),
      ));
}
