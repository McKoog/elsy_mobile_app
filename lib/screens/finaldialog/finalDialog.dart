import '/screens/finaldialog/controller/finalDialogController.dart';
import '/screens/finaldialog/finalDialogComponent.dart';
import '/screens/history/controller/historyController.dart';
import '/screens/payment_method/controller/paymentMethodController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FinalDialog extends GetWidget<FinalDialogController> {
  final finalController = Get.lazyPut(
      () => FinalDialogController(localStorageInterfaceUser: Get.find()));
  final historyController = Get.find<HistoryController>();
  final paymentMethodController = Get.lazyPut(
          () => PaymentMethodController(), fenix: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
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
                            //height: 350,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Text('Проверьте введенные данные', style: TextStyle(fontSize: 15)),
                                    spacingH,
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          columnNumberLabel,
                                          darkBox(tilePicker(controller)),
                                        ]),
                                    spacingH,
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          fuelTypeLabel,
                                          customFuelTypeDarkBox(fuelPicker(controller),controller),
                                        ]),

                                    /*Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        pricePerLiterLabel,
                                        PricePerLiterField(controller),
                                      ],
                                    ),
                                    spacingH,*/
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        litersLabel,
                                        litreField(controller),
                                      ],
                                    ),
                                    spacingH,
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          resultLabel,
                                          resultField(controller)
                                        ]),
                                    spacingH,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        dropBonusLabel,
                                        customBonusDarkBox(bonusPicker),
                                        /*Stack(
                                          alignment: AlignmentDirectional.center,
                                          children: [darkBox, bonusPicker],
                                        ),*/
                                      ],
                                    ),
                                    spacingH,
                                  ]),
                            )),
                        spacingH,
                        Container(
                          width: 400,
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [backButton(controller), payButton(context,historyController,controller)],
                          ),
                        )
                      ]),
                ),
              ),
            ]),
          ),
        ));
  }
}
