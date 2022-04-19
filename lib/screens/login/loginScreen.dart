import '/screens/login/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loginComponent.dart';

/*
  Экран логина.
*/
class LoginScreen extends GetWidget<LoginController> {
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(63, 81, 181, 1),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgroundLogin.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [svgPicture, loginTitle],
                ),
                spacingH,
                emailField(controller),
                spacingH,
                passwordField(controller),
                additionalButton,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loginButton(controller),
                      spacingW,
                      registerButton(controller)
                    ]),
              ],
            ),
          ),
        ),
      ),
      Positioned.fill(child: Obx(() {
        if (controller.loginState.value == LoginState.loading) {
          return Container(
              color: Colors.black54,
              child: Center(
                  child: SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
                width: 50,
                height: 50,
              )));
        } else {
          return const SizedBox.shrink();
        }
      }))
    ]);
  }
}
