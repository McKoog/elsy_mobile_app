import '/screens/signup/controller/signUpController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final svgPicture = SvgPicture.asset(
  "assets/logo.svg",
  semanticsLabel: 'Acme Logo',
  height: 100,
  width: 100,
  color: Colors.white,
);

final signupTitle = Text(
  "register_main_title".tr,
  style: TextStyle(fontSize: 50),
);

Widget passwordField(SignUpController controller) {
  return TextFormField(
    cursorColor: Colors.white,
    obscureText: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!controller.passwordValidation(value!)) {
        return "Пароль указан не верно!";
      }
      return null;
    },
    controller: controller.passwordTextController,
    decoration: const InputDecoration(
      hintText: 'Пароль',
    ),
  );
}

Widget emailField(SignUpController controller) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    cursorColor: Colors.white,
    obscureText: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!controller.emailValidation(value!)) {
        return "Почта введена не верно!";
      }
      return null;
    },
    controller: controller.emailTextController,
    decoration: const InputDecoration(
      hintText: 'Почта',
    ),
  );
}

Widget nameField(SignUpController controller) {
  return TextFormField(
    keyboardType: TextInputType.name,
    cursorColor: Colors.white,
    obscureText: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!controller.nameValidation(value!)) {
        return "ФИО не может быть пустым!";
      }
      return null;
    },
    controller: controller.nameTextController,
    decoration: const InputDecoration(
      hintText: 'ФИО',
    ),
  );
}

Widget mobileField(SignUpController controller) {
  return TextFormField(
    keyboardType: TextInputType.number,
    cursorColor: Colors.white,
    obscureText: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!controller.numberValidation(value!)) {
        return "Номер телефона указан не верно!";
      }
      return null;
    },
    controller: controller.mobileTextController,
    decoration: const InputDecoration(
      hintText: 'Телефон',
    ),
  );
}

Widget registerButton(SignUpController controller) {
  return SizedBox(
      height: 50,
      width: 210,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () => controller.onSignUpButtonClick(),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person_add),
                Text(
                  "register_button".tr,
                  style: TextStyle(fontSize: 14),
                )
              ])));
}

final Widget additionalButton = ElevatedButton(
  onPressed: () {},
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.info),
      Text("register_additional_title".tr,
          style: TextStyle(
            fontSize: 15,
          ))
    ],
  ),
  style: ElevatedButton.styleFrom(primary: Colors.white54),
);

Widget backButton(SignUpController controller) {
  return SizedBox(
      height: 50,
      width: 100,
      child: ElevatedButton(
        onPressed: () => controller.onBackButtonClick(),
        child: Text(
          "register_back_button".tr,
          style: TextStyle(fontSize: 15),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.red),
      ));
}

final Widget spacingW = SizedBox(
  width: 16,
);
final Widget spacingH = SizedBox(
  height: 16,
);
