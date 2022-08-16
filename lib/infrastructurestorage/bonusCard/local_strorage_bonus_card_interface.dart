
abstract class LocalStorageInterfaceBonusCards {
  Future<String?> getBonusCards();
  Future<String?> saveBonusCards(String BonusCardsJson);
  Future<void> removeBonusCard();
}