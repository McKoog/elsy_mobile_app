
import 'package:elsy_mobile_app/models/virtualCard/VirtualCard.dart';

abstract class ApiStorageInterfaceBonusCard {
  Future<bool> addBonusCard(String cardNumber);
  Future<VirtualCard?> confirmBonusCard(String cardNumber,String code);
  Future<void> deleteBonusCard(String cardToken);
}