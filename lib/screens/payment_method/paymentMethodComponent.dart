import '/screens/payment_method/controller/paymentMethodController.dart';
import '/screens/payment_method/paymentMethodScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinkoff_acquiring/tinkoff_acquiring.dart';

Widget title(){
  return Center(child: Text('Выберите способ оплаты'));
}

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key? key, required this.controller}) : super(key: key);
  PaymentMethodController? controller;
  static List<dynamic> CardList = [].obs;
  static List<CardData> cardsInfo = [];
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
      return Container(

          height: widget.controller!.constraints!.maxHeight/2+widget.controller!.constraints!.maxHeight/3.8,
          width: widget.controller?.constraints!.maxWidth,
          color: Colors.grey.shade600.withOpacity(0.2),
          child: Obx((){return ListView.builder(itemBuilder: (BuildContext context,int index){
            return PaymentMethod.CardList[index];
          }, itemCount: PaymentMethod.CardList.length,);})
      );
  }
}


Widget addCardButton(PaymentMethodController controller){
  return InkWell(
    onTap: (){
      Get.dialog(addNewCardScreen(controller));
    },
    child: Container(
      height: controller.constraints!.maxHeight/11,
      width: controller.constraints!.maxWidth,
      color: Colors.grey.shade600.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Добавить банковскую карту'),
          SizedBox(width: 20,),
          Icon(Icons.add, size: 16,)
        ],
      ),
    ),
  );
}

Widget methodGooglePay(BoxConstraints constraints){

  return InkWell(
    onTap: (){
      print(PaymentMethod.cardsInfo);
    },
    child: Container(
      height: constraints.maxHeight/11,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400.withOpacity(0.1),
        ),
          color: Colors.grey.shade700.withOpacity(0.3)
      ),
      //color: Colors.grey.shade700.withOpacity(0.3),
      child: Center(child: Text('GooglePay')),
    ),
  );
}

Widget cardLayout(BoxConstraints constraints,PaymentMethodController controller){
  return Padding(
    padding: const EdgeInsets.all(4),
    child: InkWell(
      onTap: (){
        if(PaymentMethodScreen.onRightPayScreen) {
           controller.showCardInformation(PaymentMethod.cardsInfo.length-1);
           controller.pay(PaymentMethod.cardsInfo.length-1);
        }
      },
      child: Container(
        height: constraints.maxHeight/8,
        width: constraints.maxWidth,
        color: Colors.grey.shade700.withOpacity(0.2),
        child: Center(child: Text('Карта '+ PaymentMethod.cardsInfo.length.toString() + ' ( **** **** ****  ' + PaymentMethod.cardsInfo[PaymentMethod.cardsInfo.length-1].pan.substring(12)+ ' )')),
      ),
    ),
  );
}

Widget addNewCardScreen(PaymentMethodController controller){
  return Center(
    child: Container(
      width: controller.constraints!.maxWidth-50,
      height: controller.constraints!.maxHeight/2.5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100.withOpacity(0.3),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Добавление карты')),
            ),
            Container(
              width: controller.constraints!.maxWidth-90,
              height: controller.constraints!.maxHeight/14,
              child: TextFormField(
                inputFormatters: [controller.cardNumberFormatter],
                style: TextStyle(fontSize: 14),
                scrollPadding: EdgeInsets.all(5),
                decoration: InputDecoration(
                  labelText: 'Номер карты',
                  labelStyle: TextStyle(fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.white, width: 1)
                  ),
                ),
              ),
            ),
            //SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                Container(
                    width: controller.constraints!.maxWidth/5.5,
                    height: controller.constraints!.maxHeight/14,
                    child: TextFormField(
                      inputFormatters: [controller.cardDateFormatter],
                      style: TextStyle(fontSize: 14),
                      scrollPadding: EdgeInsets.all(5),
                      decoration: InputDecoration(
                        labelText: 'мм/гг',
                        labelStyle: TextStyle(fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1)
                        ),
                      ),
                    )),
                SizedBox(width: 20,),
                Container(
                    width: controller.constraints!.maxWidth/5.8,
                    height: controller.constraints!.maxHeight/14,
                    child: TextFormField(
                      inputFormatters: [controller.cardCvvFormatter],
                      style: TextStyle(fontSize: 14),
                      scrollPadding: EdgeInsets.all(5),
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        labelStyle: TextStyle(fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1)
                        ),
                      ),
                    )),
              ],
            ),
            //SizedBox(height: 20),
            InkWell(
              onTap: (){
                print(controller.cardNumberFormatter.getUnmaskedText());
                print(controller.cardDateFormatter.getUnmaskedText());
                print(controller.cardCvvFormatter.getUnmaskedText());
                controller.createCard(
                    controller.cardNumberFormatter.getUnmaskedText(),
                    controller.cardDateFormatter.getUnmaskedText(),
                    controller.cardCvvFormatter.getUnmaskedText()
                );
                // controller.addCardToList(cardLayout(controller.constraints!,controller),);
                PaymentMethod.CardList.add(cardLayout(controller.constraints!,controller),);
                Get.back();
              },
              child: Container(
                width: controller.constraints!.maxWidth,
                height: controller.constraints!.maxHeight/14,
                color: Colors.green.shade700.withOpacity(0.5),
                child: Center(child: Text('Добавить')),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
