import '/screens/profile/controller/profileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Widget titleText = Text(
  "profile_title".tr,
  style: TextStyle(fontSize: 15),
);

final titleIcon = Icon(
  Icons.person,
  size: 40,
);

final Widget accountInfo = Container(
  decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(10),
  ),
  child: SizedBox(
      width: 128,
      height: 30,
      child: Row(
        children: [Icon(Icons.lock), Text("profile_bloc_user".tr)],
      )),
);

Widget nameField(ProfileController controller) {
  return TextFormField(
    //initialValue: controller.nameTextController.text,
    decoration: InputDecoration(
      //labelText: "profile_name".tr,
      filled: true,
      fillColor: Color.fromRGBO(80, 80, 80, 1),
      hoverColor: Color.fromRGBO(80, 80, 80, 1),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(80, 80, 80, 1), width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color.fromRGBO(80, 80, 80, 1))),
    ),
    controller: controller.nameTextController,
  );
}

Widget emailField(ProfileController controller) {
  return TextFormField(
    //initialValue: controller.emailTextController.text,
    decoration: InputDecoration(
      //labelText: "profile_email".tr,
      filled: true,
      fillColor: Color.fromRGBO(80, 80, 80, 1),
      hoverColor: Color.fromRGBO(80, 80, 80, 1),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(80, 80, 80, 1), width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color.fromRGBO(80, 80, 80, 1))),
    ),
    controller: controller.emailTextController,
  );
}

Widget fuelField(ProfileController controller) {
  return SizedBox(
      height: 50,
      width: 160,
      child: TextFormField(
        //initialValue: controller.fuelTypeTextController.text,
        decoration: InputDecoration(
          //labelText: "profile_size_of_fuel".tr,
          filled: true,
          fillColor: Color.fromRGBO(80, 80, 80, 1),
          hoverColor: Color.fromRGBO(80, 80, 80, 1),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(80, 80, 80, 1), width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Color.fromRGBO(80, 80, 80, 1))),
        ),
        //controller: controller.fuelTypeTextController,
      ));
}

Widget fuelPickerGreyBox(BuildContext context, Widget child)
{
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width / 2 - 30,
    decoration: BoxDecoration
      (
        color: Color.fromRGBO(80,80,80,1),
        borderRadius: BorderRadius.all(Radius.circular(5.0))
    ),
    child: Center(
      child: child,
    ),
  );
}

Widget fuelPicker(ProfileController controller) {
  return Obx(() {
    return DropdownButton<String>(
      value: controller.fuelTypeStandart.value,
      dropdownColor: Color.fromRGBO(80, 80, 80, 1),
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
      },
      items: <String>['АИ-92', 'АИ-95', 'АИ-100', 'Дизель']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 18),),
        );
      }).toList(),
    );
  });
}

Widget valueField(ProfileController controller,BuildContext context) {
  return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 2 - 30,
      child: TextFormField(
        //initialValue: controller.fuelSizeTextController.text,
        decoration: InputDecoration(
          //labelText: "profile_size_of_fuel".tr,
          filled: true,
          fillColor: Color.fromRGBO(80, 80, 80, 1),
          hoverColor: Color.fromRGBO(80, 80, 80, 1),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromRGBO(80, 80, 80, 1), width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Color.fromRGBO(80, 80, 80, 1))),
        ),
        controller: controller.fuelSizeTextController,
      ));
}

Widget saveButton(ProfileController profileController, double width) {
  return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: /*Color.fromRGBO(63, 81, 181, 1),*/Colors.grey.shade400.withOpacity(0.5),
          ),
          onPressed: () => profileController.onSetSettingsButtonTap(),
          child: Text("profile_save_button".tr)));
}

final Widget spacingW = SizedBox(
  width: 20,
);

final Widget spacingH = SizedBox(
  height: 8,
);
