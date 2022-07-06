import 'package:elsy_mobile_app/screens/cards/cardsScreenComponent.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/drawerWrapper.dart';
import '/widgets/appbarWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cardsController.dart';

class CardScreen extends GetWidget<CardsController> {
  final cardsController = Get.find<CardsController>();
  @override
  Widget build(BuildContext context) {
    //final items = List.generate(40, (counter) => '$counter');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerWrapper(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBarWrapper(),
      ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            controller.constraints = constraints;
            return Column(
              mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BonusCard(controller: controller),
                Container(
                  alignment: Alignment.center,
                  width: constraints.maxWidth,
                  color: Colors.grey.shade600.withOpacity(0.3),
                    child: Text("Для удаления карты, сдвиньте её влево",
                      style: TextStyle(color: Colors.red.shade500.withOpacity(0.4)),)
                ),
                addCardButton(controller),
              ],
            );
          },
        ),

        /*Container(
            //margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Container(
              color: Colors.grey.shade900,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    //final item = items[index];
                    return BonusCard(index);
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                        color: Colors.transparent,
                      ),
                  itemCount: 1),
            ))*/);
  }
}
