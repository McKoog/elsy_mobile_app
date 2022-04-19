import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/historyController.dart';

Widget HistoryItem(BuildContext context, HistoryController controller){
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white.withOpacity(0.5)),
      color: Colors.black.withOpacity(0.2)
    ),
     child:Table(
       columnWidths: {0:FractionColumnWidth(.10),1: FractionColumnWidth(.20),2: FractionColumnWidth(.13),3: FractionColumnWidth(.10),4: FractionColumnWidth(.14), 5: FractionColumnWidth(.13)},
       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
       border: TableBorder.all(color: Colors.white.withOpacity(0.5),width: 0.5),
       children: [
         TableRow(
           children: [
             SizedBox(child: Center(child: Text('Дата',textAlign: TextAlign.center,)),height:MediaQuery.of(context).size.height/16,),
             Text('Адрес',textAlign: TextAlign.center,),
             FittedBox(
               fit: BoxFit.scaleDown,
               child: Padding(
                 padding: const EdgeInsets.all(3.0),
                 child: Text('Топливо',textAlign: TextAlign.center,),
               ),
             ),
             FittedBox(
               fit: BoxFit.scaleDown,
               child: Padding(
                 padding: const EdgeInsets.all(3.0),
                 child: Text('Кол-во',textAlign: TextAlign.center,),
               ),
             ),
             FittedBox(
               fit: BoxFit.scaleDown,
               child: Padding(
                 padding: const EdgeInsets.all(3.0),
                 child: Text('Стоимость \n(Бонусы)',textAlign: TextAlign.center,),
               ),
             ),
           ]
         ),
         TableRow(
           children: [
             SizedBox(child: Center(child: Text('${controller.getDate()}',textAlign: TextAlign.center,)),height:MediaQuery.of(context).size.height/16,),
             FittedBox(
               fit: BoxFit.scaleDown,
               child: Padding(
                 padding: const EdgeInsets.all(3.0),
                 child: Text(controller.adress,textAlign: TextAlign.center,maxLines: 3,),
               ),
             ),
             Text(controller.fuelSpotAndType,textAlign: TextAlign.center,),
             Text(controller.amount,textAlign: TextAlign.center,),
             Text(controller.priceAndBonus,textAlign: TextAlign.center,),
           ]
         ),
       ],
     )
  );
}