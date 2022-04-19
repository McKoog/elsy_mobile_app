import '/screens/finaldialog/controller/finalDialogController.dart';
import '/screens/history/controller/historyController.dart';
import '/screens/payment_method/controller/paymentMethodController.dart';
import '/screens/payment_method/paymentMethodScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'package:get/get.dart';

List<Widget> tileList = [Text("1"), Text("2"), Text("3")];

Widget pumpLabel(FinalDialogController controller) {
  return Text(controller.finalData[1], style: TextStyle(fontSize: 25));
}

Widget infoLabel(FinalDialogController controller) {
  return Text(controller.finalData[2], style: TextStyle(fontSize: 15));
}

final Widget spacingW = SizedBox(
  width: 16,
);

final Widget spacingH = SizedBox(
  height: 16,
);

Widget tilePicker(FinalDialogController controller) {
  return Container(
    width: 120,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(15)),
    child: PickerView(
      controller: controller.pickerController,
      itemExtent: 40,
      numberofRowsAtSection: (selection) {
        return tileList.length;
      },
      itemBuilder: (selection, row) {
        return Text(
          "${row + 1}",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      },
    ),
  );
}

final Widget bonusPicker = Container(
    width: 120,
    height: 40,
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(15)),
    child: PickerView(
      controller: PickerController(count: 1),
      itemExtent: 40,
      numberofRowsAtSection: (selection) {
        return 180;
        },
      itemBuilder: (selection, row) {
        return Text(
          "${row}",
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
        },
    )
);

Widget darkBox(Widget child){
  return SizedBox(
    height: 50,
    width: 160,
      child: Container(
      decoration: BoxDecoration(
      color: Colors.black,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15)),
      child: Center(child: child),
      ),
  );
}
Widget customFuelTypeDarkBox(Widget child,FinalDialogController controller){
  return SizedBox(
    height: 70,
      width: 160,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            child: Center(child: child)
          ),
          Obx(() { return Text("final_dialog_pricePerLiter".tr + ' ' + controller.valueFromTypeOfFuel.value + ' руб.', style: TextStyle(fontSize: 14));},),
        ],
      ),);
}
Widget customBonusDarkBox(Widget child){
  return SizedBox(
    height: 70,
    width: 160,
    child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              widthFactor: 1.32,
                heightFactor: 1.14,
                child: child)
        ),
        Text("final_dialog_bonus_value".tr + ' ' + '30', style: TextStyle(fontSize: 14)),
      ],
    ),);
}
final Widget columnNumberLabel =
    Text("column_dialog_number".tr, style: TextStyle(fontSize: 17));

Widget fuelPicker(FinalDialogController controller) {
  return Obx(() {
    return DropdownButton<String>(
      value: controller.fuelTypeStandart.value,
      dropdownColor: Colors.black,
      elevation: 16,
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      iconSize: 24,
      style: const TextStyle(color: Colors.white, fontSize: 25),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        controller.fuelTypeStandart.value = newValue!;
        controller.setTheValuePricePerLiter();
        controller.valueTextController.text = (double.parse(controller.litreTextController.text) * double.parse(controller.valueFromTypeOfFuel.value)).toString();

      },
      items: <String>['АИ-92', 'АИ-95', 'АИ-100', 'Дизель']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  });
}

Widget resultField(FinalDialogController controller) {
  return SizedBox(
      height: 50,
      width: 160,
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
        //initialValue: controller.fuelTypeTextController.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8.0),
          filled: true,
          fillColor: Colors.black,
          hoverColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(color: Colors.white)),
        ),
        controller: controller.valueTextController,
        onChanged: (String? value){ controller.resultChanged(value);}
      ));
}

Widget litreField(FinalDialogController controller) {
  return SizedBox(
      height: 50,
      width: 160,
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
        //initialValue: controller.fuelTypeTextController.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8.0),
          filled: true,
          fillColor: Colors.black,
          hoverColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(
                color: Colors.white,
              )),
        ),
        controller: controller.litreTextController,
        onChanged: (String? value) { controller.litersChanged(value);}
      ));
}

final Widget fuelTypeLabel = Text(
  "column_dialog_fuelType".tr,
  style: TextStyle(fontSize: 17),
);

final Widget litersLabel = Text(
  "final_dialog_liters".tr,
  style: TextStyle(fontSize: 17),
);

final Widget pricePerLiterLabel = Text(
  "final_dialog_pricePerLiter".tr,
  style: TextStyle(fontSize: 17),
);

final Widget dropBonusLabel = Text(
  "final_dialog_drop_bonus".tr,
  style: TextStyle(fontSize: 17),
);

final Widget resultLabel = Text(
  "final_dialog_result".tr,
  style: TextStyle(fontSize: 17),
);

Widget payButton(BuildContext context,HistoryController controller,FinalDialogController controller2) {
  return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () {
            print('added to history');
            controller.adress = controller2.finalData[1] + '\n' + controller2.finalData[2].toString().substring(0,controller2.finalData[2].toString().indexOf(' ',4))
                + '\n' + controller2.finalData[2].toString().substring(controller2.finalData[2].toString().indexOf(' ',4));
            controller.amount = controller2.litreTextController.text;
            controller.fuelSpotAndType = 'ТРК №' + (controller2.pickerController.selectedRowAt(section: 0)+1).toString() + '\n' + controller2.fuelTypeStandart.value;
            controller.priceAndBonus = controller2.valueTextController.text + ' руб. \n ( +30 )';
            controller.addItem(context, controller);
            //print(controller2.pay());
            Get.dialog(PaymentMethodScreenOnFinal());
          },
          style: ElevatedButton.styleFrom(primary: Colors.green),
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
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text("register_back_button".tr),
      ));
}
