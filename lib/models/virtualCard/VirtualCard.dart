import 'dart:convert';

import '../fuelpump/Stations.dart';

List<VirtualCard> VirtualCardsFromJson(String str) => List<VirtualCard>.from(json.decode(str).map((x) => VirtualCard.fromJson(x)));

String VirtualCardsToJson(List<VirtualCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VirtualCard {
  int? cardNumber;
  String? cardToken;

  VirtualCard({this.cardNumber, this.cardToken});

  VirtualCard.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    cardToken = json['cardToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNumber'] = this.cardNumber;
    data['cardToken'] = this.cardToken;
    return data;
  }
}