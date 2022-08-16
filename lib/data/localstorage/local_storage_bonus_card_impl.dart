import 'package:elsy_mobile_app/infrastructurestorage/bonusCard/local_strorage_bonus_card_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pref_bonusCards = "BONUSCARDS";

class LocalStorageImplBonusCards extends LocalStorageInterfaceBonusCards {
  @override
  Future<String?> getBonusCards() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final bonusCards = sharedPreferences.getString(pref_bonusCards);
    return bonusCards;

  }

  @override
  Future<String?> saveBonusCards(String BonusCardsJson) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(pref_bonusCards, BonusCardsJson);
    return BonusCardsJson;

  }
  @override
  Future<void> removeBonusCard() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(pref_bonusCards);
  }
}