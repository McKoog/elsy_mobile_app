import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '/screens/login/controller/login_controller.dart';

import 'controller/login_controller.dart';

final svgPicture = SvgPicture.asset(
  "assets/logo.svg",
  semanticsLabel: 'Acme Logo',
  height: 100,
  width: 100,
  color: Colors.white,
);

Widget emailField(LoginController controller) {
  return TextFormField(
    cursorColor: Colors.white,
    controller: controller.emailTextController,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!controller.emailValidation(value!)) {
        return "Почта введена не верно!";
      }
      return null;
    },
    decoration: const InputDecoration(
      hintText: 'Почта',
    ),
  );
}

Widget passwordField(LoginController controller) {
  return TextFormField(
    cursorColor: Colors.white,
    obscureText: true,
    controller: controller.passwordTextController,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (!controller.passwordValidation(value!)) {
        return "Пароль введен не верно!";
      }
      return null;
    },
    decoration: const InputDecoration(
      hintText: 'Пароль',
    ),
  );
}

final Widget loginTitle = Text(
  "login_main_title".tr,
  style: TextStyle(fontSize: 50),
);

Widget loginButton(LoginController controller) {
  return SizedBox(
      height: 50,
      width: 104,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () => controller.onLoginButtonClick(),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person),
              Text("login_button".tr, style: TextStyle(fontSize: 14))
            ]),
      ));
}

Widget registerButton(LoginController controller) {
  return SizedBox(
      height: 50,
      width: 210,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () => controller.navigateToSignUpScreen(),
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
      Text("login_additional_title".tr,
          style: TextStyle(
            fontSize: 15,
          ))
    ],
  ),
  style: ElevatedButton.styleFrom(primary: Colors.white54),
);

final Widget spacingW = SizedBox(
  width: 16,
);
final Widget spacingH = SizedBox(
  height: 16,
);
