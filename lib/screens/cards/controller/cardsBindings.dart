import 'package:elsy_mobile_app/data/apistorage/api_storage_bonus_card_impl.dart';
import 'package:elsy_mobile_app/data/localstorage/local_storage_bonus_card_impl.dart';
import 'package:elsy_mobile_app/screens/cards/controller/cardsController.dart';
import 'package:get/get.dart';

class CardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (CardsController(
        apiStorageInterfaceBonusCard: Get.put(ApiStorageBonusCardImpl()),
        localStorageInterfaceBonusCards: Get.put(LocalStorageImplBonusCards()))));
  }
}