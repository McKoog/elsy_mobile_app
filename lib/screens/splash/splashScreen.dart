import '/screens/splash/controller/splashController.dart';
import '/screens/splash/splashComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* 
  Начальный экран.
*/

class SplashScreen extends GetWidget<SplashController> {
  final splashController = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 81, 181, 1),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundLogin.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: logoPicture),
      ),
    );
  }
}
