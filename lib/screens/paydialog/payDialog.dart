import 'dart:async';
import 'dart:ui';
import '/screens/paydialog/controller/payController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payDialogComponent.dart';

class PayDialog extends GetWidget<PayDialogController> {
  final payDialogController = Get.lazyPut(
      () => PayDialogController(localStorageInterfaceUser: Get.find()));
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          const ModalBarrier(dismissible: false,),
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
                          pumpLabel(controller),
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
                        height: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                //height: 43,
                                width: 350,
                                decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(0.2)))),
                                child: Column(
                                  children: [
                                    Text('Колонка № ${controller.TrkNumber+1}'),
                                    SizedBox(height: 5,),
                                    Text('Тип топлива: ${controller.standartFuel}'),
                                  ],
                                ),
                              ),

                              InputWindow(controller,'Rub'),
                              Container(height: 1,width: MediaQuery.of(context).size.width, color: Colors.white.withOpacity(0.2),),
                              InputWindow(controller,'Lit'),
                              Container(height: 1,width: MediaQuery.of(context).size.width, color: Colors.white.withOpacity(0.2),),
                            ],
                          ),
                        ),),
                    Container(
                      width: 400,
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          backButton(controller),
                          spacingW,
                          nextButton(controller)
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ]));
  }
}
