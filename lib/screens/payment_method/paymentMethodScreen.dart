import '/screens/payment_method/paymentMethodComponent.dart';
import '/widgets/appbarWrapper.dart';
import '/widgets/drawerWrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'paymentMethodComponent.dart';
import 'controller/paymentMethodController.dart';


class PaymentMethodScreen extends GetWidget<PaymentMethodController> {
  final paymentMethodController = Get.find<PaymentMethodController>();
  static bool onRightPayScreen = false;
  @override
  Widget build(BuildContext context) {
    onRightPayScreen = false;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: DrawerWrapper(),
    appBar: PreferredSize(
    preferredSize: Size.fromHeight(40),
    child: AppBarWrapper(),
    ),
    body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          controller.constraints = constraints;
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              title(),
              SizedBox(height: 8,),
              PaymentMethod(controller: controller),
              methodGooglePay(constraints),
              //SizedBox(height: 10,),
              addCardButton(controller),
            ],
          );
        },
    ),
    );
  }
}
class PaymentMethodScreenOnFinal extends GetWidget<PaymentMethodController> {
  final paymentMethodController = Get.find<PaymentMethodController>();
  @override
  Widget build(BuildContext context) {
    paymentMethodController.myContext = context;
    PaymentMethodScreen.onRightPayScreen = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          controller.constraints = constraints;
          return Column(
            mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /*title(),
              SizedBox(height: 20,),
              PaymentMethod(controller: controller),
              methodGooglePay(constraints),
              SizedBox(height: 10,),
              addCardButton(controller),*/
              SizedBox(height: 8 ,),
              title(),
              SizedBox(height: 8,),
              PaymentMethod(controller: controller),
              methodGooglePay(constraints),
              //SizedBox(height: 10,),
              addCardButton(controller),
            ],
          );
        },
      ),
    );
  }
}
