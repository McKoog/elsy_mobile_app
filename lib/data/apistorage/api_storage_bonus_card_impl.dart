import 'dart:convert';

import 'package:elsy_mobile_app/infrastructurestorage/bonusCard/api_storage_bonus_card_interface.dart';
import 'package:elsy_mobile_app/models/virtualCard/VirtualCard.dart';

import '../../constants.dart';
import 'package:http/http.dart' as http;

class ApiStorageBonusCardImpl extends ApiStorageInterfaceBonusCard
{
  @override
  Future<bool> addBonusCard(String cardNumber) async {
    Uri uri = Uri.https(baseUrl, '/DiscountCards/AddCard',
        {"cardNumber" : cardNumber});
    final response = await http.post(uri,headers: {
      "Accept": "text/plain",
      "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
      "Access-Control-Allow-Credentials" : 'true',
    });

    print(uri);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<VirtualCard?> confirmBonusCard(String cardNumber, String code) async {
      Uri uri = Uri.https(baseUrl, '/DiscountCards/ConfirmCard',
          {"cardNumber" : cardNumber, "code": code});
      final response = await http.post(uri,headers: {
        "Accept": "text/plain",
        "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
        "Access-Control-Allow-Credentials" : 'true',
      });

      print(uri);
      print(response.body);
      if (response.statusCode == 200) {
        return VirtualCard.fromJson(jsonDecode(response.body));
      }
      else {
        return null;
      }
  }

  @override
  Future<void> deleteBonusCard(String cardToken) async {
    Uri uri = Uri.https(baseUrl, '/DiscountCards/DeleteCard',
        {"cardToken" : cardToken});
    final response = await http.delete(uri,headers: {
      "Accept": "text/plain",
      "Access-Control-Allow-Origin" : "https://192.168.4.22:7242",
      "Access-Control-Allow-Credentials" : 'true',
    });
    print(uri);
    print(response.body);
  }

}