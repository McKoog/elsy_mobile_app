

import 'package:elsy_mobile_app/main.dart';
import 'package:elsy_mobile_app/models/virtualCard/VirtualCard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cardsController.dart';

Widget BonusCardLayout(String? cardNumber,CardsController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Dismissible(
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade700.withOpacity(0.7),
                title: Center(child: const Text("Подтверждение",style: TextStyle(color: Colors.white),)),
                content: const Text("Действительно хотите удалить карту?",style: TextStyle(color: Colors.white),),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            controller.deleteBonusCard(int.parse(controller.cardNumberFormatter.unmaskText(cardNumber!)));
                            Navigator.of(context).pop(true);
                            },
                          child: const Text("Удалить"),
                          style: ElevatedButton.styleFrom(primary: Colors.red.shade500.withOpacity(0.6)),
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Отменить"),
                          style: ElevatedButton.styleFrom(primary: Colors.grey.shade700.withOpacity(0.5)),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        },
        key: UniqueKey(),
        background: Container(
          decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(20),
          color: Colors.red.shade900.withOpacity(0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.delete_forever_outlined),
              ),
              Text("Удалить")
            ],
          ),
        ),
        direction: DismissDirection.endToStart,
        child: Container(
          height: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade700.withOpacity(0.6),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Бонусная карта ",style: TextStyle(fontSize: 18),),
              Text("СКИДКА 10%", style: TextStyle(fontSize: 20),),
              Text(cardNumber.toString(), style: TextStyle(fontSize: 17),),
            ],
          ),),
      ),
    ),
  );
}

class BonusCard extends StatefulWidget {
  BonusCard({Key? key, required this.controller}) : super(key: key);
  CardsController? controller;
  @override
  _BonusCardState createState() => _BonusCardState();
}

class _BonusCardState extends State<BonusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(

        height: widget.controller!.constraints!.maxHeight-widget.controller!.constraints!.maxHeight/11-16,
        width: widget.controller?.constraints!.maxWidth,
        color: Colors.grey.shade600.withOpacity(0.2),
        child: Obx((){return ListView.builder(itemBuilder: (BuildContext context,int index){
          /*return Dismissible(
              key: Key(index.toString()),
              child: CardsController.CardList[index],
              background: Container(color: Colors.red.withOpacity(0.1),),
              direction: DismissDirection.endToStart,
          );*/
          return CardsController.CardList[index];
        }, itemCount: CardsController.CardList.length,);})
    );
  }
}

Widget addCardButton(CardsController controller){
  return InkWell(
    onTap: (){
      Get.dialog(addNewBonusCard(controller));
    },
    child: Container(
      height: controller.constraints!.maxHeight/11,
      width: controller.constraints!.maxWidth,
      color: Colors.grey.shade600.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Добавить бонусную карту'),
          SizedBox(width: 20,),
          Icon(Icons.add, size: 16,)
        ],
      ),
    ),
  );
}

Widget addNewBonusCard(CardsController controller)
{
  return Center(
      child: Container(
      width: controller.constraints!.maxWidth-50,
      height: controller.constraints!.maxHeight/3,
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
                child: Center(child: Text('Добавление бонусной карты')),
              ),
              Container(
                width: controller.constraints!.maxWidth-90,
                height: controller.constraints!.maxHeight/14,
                child: TextFormField(
                  validator: (value) {
                    if (!controller.cardValidation(value!)) {
                      return "Неверный номер карты";
                    }
                    return null;
                  },
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
              InkWell(
                onTap: () async {
                  final isSuccess = await controller.apiStorageInterfaceBonusCard.addBonusCard(controller.cardNumberFormatter.getUnmaskedText());
                  print(isSuccess);
                  if(isSuccess)
                  {
                  if(Get.isSnackbarOpen) {
                      Get.closeCurrentSnackbar();
                      Future.delayed(Duration(milliseconds: 200), (){
                        Get.back();
                        Get.dialog(EnterCode(controller,controller.cardNumberFormatter.getUnmaskedText()));});

                  }
                  else
                  {
                    Get.back();
                    Get.dialog(EnterCode(controller,controller.cardNumberFormatter.getUnmaskedText()));
                  }
                  }
                  else {
                    if (!Get.isSnackbarOpen) {
                      Get.snackbar(
                          'Ошибка',
                          'Кажется, что карта лояльности с указанным номером не найдена в системе. Пожалуйста, проверьте вводимые данные',
                          snackPosition: SnackPosition.TOP,
                          duration: Duration(milliseconds: 4000),
                          animationDuration: Duration(milliseconds: 100)
                      );
                    }
                  }
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
  ));
}

Widget EnterCode(CardsController controller, String cardNumber)
{
  controller.cardNumberFormatter.clear();
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Center(
          child: Container(
            width: controller.constraints!.maxWidth-50,
            height: controller.constraints!.maxHeight/3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100.withOpacity(0.6)),
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade800.withOpacity(0.3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Введите код')),
                ),
                Container(
                  width: controller.constraints!.maxWidth-90,
                  height: controller.constraints!.maxHeight/14,
                  child: TextFormField(
                    validator: (value) {
                      if (!controller.codeValidation(value!)) {
                        return "Неверный код";
                      }
                      return null;
                    },
                    inputFormatters: [controller.codeFormatter],
                    style: TextStyle(fontSize: 14),
                    scrollPadding: EdgeInsets.all(5),
                    decoration: InputDecoration(
                      labelText: 'Код',
                      labelStyle: TextStyle(fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 1)
                      ),
                    ),
                  ),
                ),
                InkWell(
                        onTap: () async {
                          if(controller.codeFormatter.getUnmaskedText() != "") {
                            Get.closeCurrentSnackbar();
                            final virtCard = await controller
                                .apiStorageInterfaceBonusCard.confirmBonusCard(
                                cardNumber,
                                controller.codeFormatter.getUnmaskedText());
                            if (virtCard != null) {
                              controller.saveBonusCardsToLocalStorage(virtCard);
                              /*controller.virtualCards.add(virtCard);
                            controller.localStorageBonusCards = VirtualCardsToJson(controller.virtualCards);*/
                              Future.delayed(Duration(milliseconds: 200),(){
                                Get.back();
                              });

                              //CardsController.CardList.add(BonusCardLayout(controller.cardNumberFormatter.getMaskedText()));
                            }
                            //CardsController.CardList.add(BonusCardLayout(controller));
                            else{
                              if(!Get.isSnackbarOpen) {
                                Get.snackbar(
                                    'Ошибка',
                                    'Неверный код. Пожалуйста, проверьте вводимые данные',
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(milliseconds: 4000),
                                    animationDuration: Duration(milliseconds: 100)
                                );
                              }
                            }
                          }
                          else{
                            if(!Get.isSnackbarOpen) {
                              Get.snackbar(
                                  'Ошибка',
                                  'Неверный код. Пожалуйста, проверьте вводимые данные',
                                  snackPosition: SnackPosition.TOP,
                                  duration: Duration(milliseconds: 4000),
                                  animationDuration: Duration(milliseconds: 100)
                              );
                            }
                          }
                        },
                        child: Container(
                          width: controller.constraints!.maxWidth,
                          height: controller.constraints!.maxHeight/14,
                          color: Colors.green.shade700.withOpacity(0.5),
                          child: Center(child: Text('Подтвердить')),
                        ),
                      ),
              ],
            ))),
  );
}