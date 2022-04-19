import '/screens/fueldialog/controller/fuelDialogController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

import 'fuelDialogComponent.dart';

class FuelDialog extends GetWidget<FuelDialogController> {
  final fuelController = Get.lazyPut(
      () => FuelDialogController(localStorageInterfaceUser: Get.find()),fenix: true);
  @override
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Выберите номер колонки'),
                          AddSubtract(TrkPicker(controller: controller,),controller),
                          Container(height: 1,width: MediaQuery.of(context).size.width-45, color: Colors.white.withOpacity(0.2),),
                          Text('Выберите тип топлива'),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade800,
                            ),
                            child: Obx(() {
                              return ListView.builder(
                                  itemCount: controller.availableFuel.length,
                                  itemBuilder: (BuildContext context, int) {
                                    return TrkTable(controller, int);
                                  });
                            })
                            ),
                        ]),
                    ),
                    Container(
                      width: 400,
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [qrButton(controller), nextButton(controller)],
                      ),
                    )
                  ],
              ),
            ),
          ),
        ])
    );
  }
}
