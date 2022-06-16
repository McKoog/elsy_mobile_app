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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    spacingH,
                                    Text('Проверьте введенные данные', style: TextStyle(fontSize: 15)),
                                    spacingH,
                                    Container(height: 1,width: MediaQuery.of(context).size.width-45, color: Colors.white.withOpacity(0.2),),
                                    Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  //height: 43,
                                  width: 350,
                                  //decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.white.withOpacity(0.2)))),
                                  child: Column(
                                      children: [
                                        Text('Колонка № ${controller.order!.FuelPointId!+1}',style: TextStyle(fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text('Тип топлива: ${controller.order!.FuelMarka}',style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                  ),
                                    Container(height: 1,width: MediaQuery.of(context).size.width-45, color: Colors.white.withOpacity(0.2),),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      //height: 43,
                                      width: 350,
                                      //decoration: BoxDecoration(border: Border.(BorderSide(color: Colors.white.withOpacity(0.2)))),
                                      child: Column(
                                        children: [
                                          Text('Сумма к оплате: ${controller.order!.ResultPrice!.toStringAsFixed(2)}',style: TextStyle(fontSize: 16),),
                                          SizedBox(height: 5,),
                                          Text('Количество топлива: ${controller.order!.ResultLitres!.toStringAsFixed(2)}',style: TextStyle(fontSize: 16),),
                                        ],
                                      ),
                                    ),
                                    Container(height: 1,width: MediaQuery.of(context).size.width-45, color: Colors.white.withOpacity(0.2),),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      //height: 43,
                                      width: 350,
                                      //decoration: BoxDecoration(border: Border.(BorderSide(color: Colors.white.withOpacity(0.2)))),
                                      child: Column(
                                        children: [
                                          Text('Количество бонусов: ${20}',style: TextStyle(fontSize: 16),),
                                          SizedBox(height: 5,),
                                          ElevatedButton(onPressed: (){},
                                              child: Text("Списать бонусы",style: TextStyle(fontSize: 16),),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey.shade700,
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(height: 1,width: MediaQuery.of(context).size.width-45, color: Colors.white.withOpacity(0.2),),
                                    spacingH,
                                  ],
                            )),),
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
