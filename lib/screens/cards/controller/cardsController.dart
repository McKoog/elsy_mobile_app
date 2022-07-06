import 'package:elsy_mobile_app/infrastructurestorage/bonusCard/api_storage_bonus_card_interface.dart';
import 'package:elsy_mobile_app/infrastructurestorage/bonusCard/local_strorage_bonus_card_interface.dart';
import 'package:elsy_mobile_app/infrastructurestorage/user/local_storage_user_interface.dart';
import 'package:elsy_mobile_app/models/virtualCard/VirtualCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../cardsScreenComponent.dart';

class CardsController extends GetxController
{
  BuildContext? myContext;
  BoxConstraints? constraints;
  var cardNumberFormatter = new MaskTextInputFormatter(mask: '### ### ### ###', filter: { "#": RegExp(r'[0-9]') });
  var codeFormatter = new MaskTextInputFormatter(mask: '####', filter: { "#": RegExp(r'[0-9]') });
   final ApiStorageInterfaceBonusCard apiStorageInterfaceBonusCard;
   final LocalStorageInterfaceBonusCards localStorageInterfaceBonusCards;
   //String? cardToken;
   String? BonusCardsJson;
   List<VirtualCard> virtualCards = [];
  static List<dynamic> CardList = [].obs;

  //CardsController({this.apiStorageInterfaceBonusCard});

  CardsController(
      {required this.localStorageInterfaceBonusCards,required this.apiStorageInterfaceBonusCard});


  @override
  Future<void> onInit() async {
    print("ON INIT: Получаем бонусные карты");
    final bonusCardsJson = await getBonusCardsFromLocalStorage();
    if(bonusCardsJson != null) {
      print("Преобразуем JSON в обьект");
      virtualCards = VirtualCardsFromJson(bonusCardsJson);
      print("Проверяем получили ли карты");
      if (virtualCards.isNotEmpty) {
        print("Карты получены");
        for (var element in virtualCards) {
          CardList.add(BonusCardLayout(
              cardNumberFormatter.maskText(element.cardNumber.toString()),
              Get.find<CardsController>()));
          //CardsController(localStorageInterfaceBonusCards: localStorageInterfaceBonusCards, apiStorageInterfaceBonusCard: apiStorageInterfaceBonusCard
          print("Рисуем карту");
        }
      }
    }

    super.onInit();
  }

  saveBonusCardsToLocalStorage(VirtualCard virtCard)
  {
    virtualCards.add(virtCard);
    BonusCardsJson = VirtualCardsToJson(virtualCards);
    localStorageInterfaceBonusCards.saveBonusCards(BonusCardsJson!);
    print("Bonus card saved");
    cardNumberFormatter.maskText(virtCard.cardNumber.toString());
    print(cardNumberFormatter.getMaskedText());
    CardList.add(BonusCardLayout(cardNumberFormatter.maskText(virtCard.cardNumber.toString()),Get.find<CardsController>()));
  }

  Future<String?> getBonusCardsFromLocalStorage() async
  {
    final bonusCardsJson =  await localStorageInterfaceBonusCards.getBonusCards();

    if(bonusCardsJson != null) {
      print("Получили бонусные карты: " + bonusCardsJson);
      return bonusCardsJson;
    }
    else {
      return null;
    }
  }

  deleteBonusCard(int CardNumber)
  {
    print("Delete bonus Card");
    apiStorageInterfaceBonusCard.deleteBonusCard(virtualCards.firstWhere((element) => element.cardNumber == CardNumber).cardToken!);
    print("Delete from Server");
    CardList.removeAt(virtualCards.indexOf(virtualCards.firstWhere((element) => element.cardNumber == CardNumber)));
    print("Delete from widget tree");
    virtualCards.remove(virtualCards.firstWhere((element) => element.cardNumber == CardNumber));
    print("Delete from local storage");
    localStorageInterfaceBonusCards.removeBonusCard();
    saveOtherCardsAfterRemoveOfOne();
  }

  saveOtherCardsAfterRemoveOfOne()
  {
    print("RefreshAfterDelete");
    BonusCardsJson = VirtualCardsToJson(virtualCards);
    print("Оставшиеся бонусные карты" + BonusCardsJson.toString());
    localStorageInterfaceBonusCards.saveBonusCards(BonusCardsJson!);
    print("Bonus card saved");
  }

  bool cardValidation(String cardNumber) {
    if (cardNumber != "") {
      return true;
    } else {
      return false;
    }
  }

  bool codeValidation(String code) {
    if (code != "") {
      return true;
    } else {
      return false;
    }
  }

}