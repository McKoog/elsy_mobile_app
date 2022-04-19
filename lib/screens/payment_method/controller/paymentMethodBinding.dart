import '/screens/payment_method/controller/paymentMethodController.dart';
import 'package:get/get.dart';

class PaymentMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (PaymentMethodController()));
  }
}