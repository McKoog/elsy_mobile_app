import '/screens/qrgenerate/controller/qrGenerateController.dart';
import 'package:get/get.dart';

class QrGenerateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrGenerateController());
  }
}
