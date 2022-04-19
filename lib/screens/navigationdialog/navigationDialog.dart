import 'dart:ui';
import '/screens/navigationdialog/controller/navigationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigationDialogComponent.dart';

class NavigationDialog extends GetWidget<NavigationDialogController> {
  final navigationController = Get.lazyPut(
      () => NavigationDialogController(localStorageInterfaceUser: Get.find()));
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          const ModalBarrier(),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(80, 80, 80, 1),
                          image: DecorationImage(
                              image: AssetImage("assets/backgroundLogin.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      width: 400,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          pumpLabel(controller.argumentData[1]),
                          infoLabel(controller)
                        ],
                      ),
                    ),
                    spacingH,
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(80, 80, 80, 1),
                          image: DecorationImage(
                              image: AssetImage("assets/backgroundLogin.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      width: 400,
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          navigationDialogLabel(),
                          spacingH,
                          navigationDialogText(),
                          navigationDialogTextQuestion(),
                          spacingH,
                          errorButton(controller),
                        ],
                      ),
                    ),
                    spacingH,
                    Container(
                      width: 400,
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          yandexButton(controller),
                          spacingW,
                          googleButton(controller)
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ]));
  }
}
