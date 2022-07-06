import '../../../models/dataServer/Order.dart';
import '/data/localstorage/local_storage_user_impl.dart';
import '/infrastructurestorage/user/local_storage_user_interface.dart';
import '/screens/paydialog/payDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinkoff_acquiring/tinkoff_acquiring.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class FinalDialogController extends GetxController {
  final LocalStorageInterfaceUser localStorageInterfaceUser;

  FinalDialogController({required this.localStorageInterfaceUser});

  final finalData = Get.arguments;

  final litreTextController = TextEditingController();
  final valueTextController = TextEditingController();
  final valueFromTypeOfFuel = '44.40'.obs;

  Order? order;

  /*Future<String> pay() async {
    const String terminalKey = '1605280872049';
    const String password = 'xtiprrmg73jkiklh';
    const int amount = 10;
    String cardData = '';

    final TinkoffAcquiring acquiring = TinkoffAcquiring(
        TinkoffAcquiringConfig(
            terminalKey: terminalKey,
            password: password,
          debug: true,
        )
    );
    final InitResponse init = await acquiring.init(InitRequest(
      orderId: (99 +
          math.Random(DateTime.now().millisecondsSinceEpoch)
              .nextInt(100000))
          .toString(),
      amount: amount,
      language: Language.ru,
      payType: PayType.one,
    ));
    final url = init.paymentURL;
    if(await canLaunch(url!)){
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
        enableDomStorage: true,
      );
    }
    final GetStateResponse getState = await acquiring.getState(
      GetStateRequest(
        paymentId: int.parse(init.paymentId!),
      ),
    );
    return getState.status.toString();
  }*/
  @override
  onInit() {
    order = finalData[3];
    super.onInit();
  }

  navigateToPayDialog(){
    Get.back();
    Get.dialog(PayDialog(), barrierDismissible: true, arguments: [
      "${finalData[0]}", //ID [0]
      "${finalData[1]}",
      "${finalData[2]}",
      finalData[3],
      finalData[4]
    ]);
  }
  onBackButtonTap(){
    navigateToPayDialog();
  }

  litersChanged(String? value) {
    valueTextController.text =
        (double.parse(value!) * double.parse(valueFromTypeOfFuel.value)).toString();
  }
  resultChanged(String? value) {
    litreTextController.text =
        (double.parse(value!) / double.parse(valueFromTypeOfFuel.value)).toString();
  }
}
