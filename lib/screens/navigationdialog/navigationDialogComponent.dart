import '/screens/navigationdialog/controller/navigationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget googleButton(NavigationDialogController controller) {
  return SizedBox(
      height: 50,
      width: 157,
      child: ElevatedButton(
          onPressed: () => controller.openYandexMap(),
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(63, 81, 181, 1)),
          child: Text("navigation_dialog_yandex_button".tr,
              style: TextStyle(fontSize: 14))));
}

Widget yandexButton(NavigationDialogController controller) {
  return SizedBox(
      height: 50,
      width: 157,
      child: ElevatedButton(
          onPressed: () => controller.openGoogleMap(),
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(63, 81, 181, 1)),
          child: Text("navigation_dialog_google_button".tr,
              style: TextStyle(fontSize: 14))));
}

Widget errorButton(NavigationDialogController controller) {
  return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: () => controller.goToFuelDialog(),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent),
          child: Text("navigation_dialog_error_button".tr)));
}

Widget navigationDialogLabel() {
  return Text(
    "navigation_dialog_label".tr,
    style: TextStyle(fontSize: 20),
  );
}

Widget navigationDialogText() {
  return Text(
    "navigation_dialog_text_main".tr,
    style: TextStyle(
      fontSize: 14,
    ),
  );
}

Widget pumpLabel(String namePump) {
  return Text(namePump, style: TextStyle(fontSize: 25));
}

Widget infoLabel(NavigationDialogController controller) {
  return Text(controller.argumentData[2].toString(),
      style: TextStyle(fontSize: 14));
}

Widget navigationDialogTextQuestion() {
  return Text(
    "navigation_dialog_text_question".tr,
    style: TextStyle(
      fontSize: 14,
    ),
  );
}

Widget rubLabel() {
  return Text("fuel_dialog_rub".tr);
}

Widget litersLabel() {
  return Text("fuel_dialog_liters".tr);
}

final Widget darkBox = SizedBox(
  width: 160,
  height: 50,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(15)),
  ),
);

final Widget spacingW = SizedBox(
  width: 16,
);

final Widget spacingH = SizedBox(
  height: 16,
);
