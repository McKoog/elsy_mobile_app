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
    double itemCountRubles = 0;
    double itemCountLitres = 0;
    if( controller.scheme == 'TwoFour'){ itemCountRubles = 4; itemCountLitres = 2; }
    else { itemCountRubles = 5; itemCountLitres = 3;}
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                                    Text('Колонка № ${controller.TrkNumber}'),
                                    SizedBox(height: 5,),
                                    Text('Тип топлива: ${controller.standartFuel}'),
                                  ],
                                ),
                              ),
                              //Text('Рубли', style: TextStyle(fontSize: 18),),
                              InputWindow(controller,'Rub'),
                              //Obx((){return Text('Рублей: ${controller.fullRublesResult.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 16),);}),
                              //MyOwnPickers(controller, 5, 'Rub'),
                               // SizedBox(height: 5,),
                              /*Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Obx((){return Text('Рублей: ${controller.fullRublesResult.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 16),);}),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        Get.dialog(LitreInputDialog(controller,'Rubles'));
                                      },
                                      highlightColor: Colors.white10.withOpacity(0.01),
                                      splashColor: Colors.white10.withOpacity(0.05),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(height:30, width:148, decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white38.withOpacity(0.08)),
                                              borderRadius: BorderRadius.circular(2),
                                              color: Colors.white38.withOpacity(0.05),),
                                              child: Stack(children: [
                                                Positioned(child: Icon(Icons.apps, size: 25, color: Colors.grey.shade500,),top: 1,left:5,),
                                                Positioned(child: Icon(Icons.touch_app_rounded, size: 10,), top: 18, left: 20),
                                                Positioned(child: Text('Ввести вручную', style: TextStyle(fontSize: 14),),left: 32, top: 7)
                                              ],))
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,)
                                ],
                              ),*/
                              Container(height: 1,width: MediaQuery.of(context).size.width, color: Colors.white.withOpacity(0.2),),
                              //Text('Литры', style: TextStyle(fontSize: 18),),
                              InputWindow(controller,'Lit'),
                              //MyOwnPickers(controller, 3, 'Lit'),
                              // SizedBox(height: 5,),
                              // Column(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(3.0),
                              //       child: Obx((){return Text('Литров: ${controller.fullLitresResult.value.toStringAsFixed(2)}', style: TextStyle(fontSize: 16),);}),
                              //     ),
                              //     Material(
                              //       color: Colors.transparent,
                              //       child: InkWell(
                              //         highlightColor: Colors.white10.withOpacity(0.01),
                              //         splashColor: Colors.white10.withOpacity(0.05),
                              //         onTap: (){
                              //           Get.dialog(LitreInputDialog(controller,'Litres'));
                              //         },
                              //         child: Stack(
                              //           children: [
                              //             Positioned(
                              //                 child: Container(height:30, width:148, decoration: BoxDecoration(
                              //                   border: Border.all(color: Colors.white38.withOpacity(0.08)),
                              //                   borderRadius: BorderRadius.circular(2),
                              //                   color: Colors.white38.withOpacity(0.05),),
                              //                     child: Stack(children: [
                              //                       Positioned(child: Icon(Icons.apps, size: 25, color: Colors.grey.shade500,),top: 1,left:5,),
                              //                       Positioned(child: Icon(Icons.touch_app_rounded, size: 10,), top: 18, left: 20),
                              //                       Positioned(child: Text('Ввести вручную', style: TextStyle(fontSize: 14),),left: 32, top: 7)
                              //                     ],))
                              //             ),
                              //
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(height: 5,)
                              //   ],
                              // ),
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
