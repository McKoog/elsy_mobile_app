import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../historyComponent.dart';
import '../historyScreen.dart';

class HistoryController extends GetxController{
  String adress = 'АЗС №1 \nул. Фуллстек \nстр.1';
  String fuelSpotAndType = 'ТРК №1 \nАИ-92';
  String amount = '50 л.';
  String priceAndBonus = '2500 руб. \n( +30 )';

  onInit(){
  }

  String getDate(){
    DateTime now = DateTime.now();
    String date = now.toString().substring(0,10);
    String year = date.substring(2,4);
    String month = date.substring(5,7);
    String day = date.substring(8,10);
    String neededDate = day+'.'+month+'.'+year;
    return neededDate;
  }
  addItem(BuildContext context,HistoryController controller){
    HistoryScreen.HistoryItems.add(HistoryItem(context,controller));
  }
}