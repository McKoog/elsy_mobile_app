import 'dart:async';

import 'package:flutter/cupertino.dart';

import '/screens/finaldialog/finalDialog.dart';
import '/screens/paydialog/controller/payController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

List<Widget> tileList = [Text("1"), Text("2"), Text("3")];
List<Row> fuel = [
  Row(children: [Text("АИ-92")]),
  Row(children: [Text("АИ-95")]),
  Row(children: [Text("АИ-100")]),
];

Widget fuelPicker(PayDialogController controller) {
  return Obx(() {
    return DropdownButton<String>(
      value: controller.standartFuel.value,
      dropdownColor: Colors.black,
      elevation: 16,
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      iconSize: 24,
      style: const TextStyle(color: Colors.white, fontSize: 25),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        controller.standartFuel.value = newValue!;
      },
      items: <String>['АИ-92', 'АИ-95', 'АИ-100', 'Дизель']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  });
}

Widget pumpLabel(PayDialogController controller) {
  return Text(controller.payData[1], style: TextStyle(fontSize: 25));
}

Widget infoLabel(PayDialogController controller) {
  return Text(controller.payData[2].toString(), style: TextStyle(fontSize: 15));
}

final Widget fuelTypeLabel = Text(
  "column_dialog_fuelType".tr,
  style: TextStyle(fontSize: 17),
);

final Widget columnNumberLabel =
    Text("column_dialog_number".tr, style: TextStyle(fontSize: 17));

final Widget columnLabel = Text(
  "column_dialog_label2".tr,
  style: TextStyle(fontSize: 15),
);

Widget nextButton(PayDialogController controller) {
  return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () => controller.onNextButtonTap(),
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(63, 81, 181, 1)),
          child: Text("column_dialog_pay_button".tr)));
}

Widget backButton(PayDialogController controller) {
  return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () => controller.onBackButtonTap() ,
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text("register_back_button".tr),
      ));
}

final Widget darkBox = SizedBox(
  width: 160,
  height: 50,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15)),
  ),
);

final Widget spacingW = SizedBox(
  width: 16,
);

final Widget spacingH = SizedBox(
  height: 16,
);

Widget InputWindowLabel(String RubOrLit){
  return Center(
    child: Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.white.withOpacity(0.1)),
        color: Colors.grey.shade800,
      ),
      //width: 140,
      //height: 20,
      child: RubOrLit == 'Rub' ? Text("Рубли", style: TextStyle(letterSpacing: 5)) : Text("Литры", style: TextStyle(letterSpacing: 5)),
      padding: EdgeInsets.all(2),
    ),
  );
}
// Widget RublesCounter(
//     BuildContext context,
//     {
//       required int currentLength,
//       required int? maxLength,
//       required bool isFocused,
//     }
//     ) {
//   return Container(
//     color: Colors.amber,
//     child: Text(
//       '$currentLength/$maxLength',
//       semanticsLabel: 'character count',
//     ),
//   );
// }

Widget InputWindow(PayDialogController controller, String RubOrLit){
  return Container(
    width: 200,
    height: 70,
    decoration: BoxDecoration(
        color: Color.fromRGBO(80, 80, 80, 1),
        image: DecorationImage(
            image: AssetImage("assets/backgroundLogin.png"),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),),
    alignment: Alignment.center,
    child: Center(
      child: SizedBox(
        width: 300,
        height: 70,
        child: Obx((){return TextFormField(
          //autofocus: true,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+")),LengthLimitingTextInputFormatter(RubOrLit == 'Rub' ? 5 : 3),],
          keyboardType: TextInputType.numberWithOptions(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, letterSpacing: 15),
          //initialValue: controller.fullRublesResult.value.toStringAsFixed(2),
          decoration: InputDecoration(
            //labelText: 'Рубли',
            helperText: RubOrLit == 'Rub' ? 'Рублей: ${controller.fullRublesResult.value.toStringAsFixed(2)}' :'Литров: ${controller.fullLitresResult.value.toStringAsFixed(2)}',
            helperStyle: TextStyle(fontSize: 14,),
            // suffixText: ".00",
            // suffixStyle: TextStyle(fontSize: 20,),
            label: InputWindowLabel(RubOrLit),
            filled: true,
            fillColor: Colors.grey.shade800,
            hoverColor: Colors.grey.shade800.withOpacity(0.5),
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
          ),
          controller: RubOrLit == 'Rub' ? controller.RublesTextController : controller.LitreTextController,
          onFieldSubmitted: (string){
            if(RubOrLit == 'Rub'){
              controller.fullRublesResult.value = int.tryParse(string)!.toDouble();
              controller.fullLitresResult.value = controller.countFullResult(controller.fullRublesResult.value, 'Lit');
              controller.LitreTextController.text = controller.fullLitresResult.toInt().toString();
            }
            else{
              controller.fullLitresResult.value = int.tryParse(string)!.toDouble();
              controller.fullRublesResult.value = controller.countFullResult(controller.fullLitresResult.value, 'Rub');
              controller.RublesTextController.text = controller.fullRublesResult.toInt().toString();
            }
          },
          onTap:(){
            if(RubOrLit == 'Rub'){
              controller.lastPicked = 'Rub';
            }
            else{
              controller.lastPicked = 'Lit';
            }
          } ,
        );}),
      ),
    ),
  );
}

Widget LitreInputDialog(PayDialogController controller, String type){
  TextEditingController control;
  int maxLenght;
  String typo = '';
  if(controller.scheme == 'TwoFour') {
    if (type == 'Rubles') {
      control = controller.RublesTextController;
      maxLenght = 4;
    }
    else {
      control = controller.LitreTextController;
      maxLenght = 2;
    }
  }
  else{
    if (type == 'Rubles') {
      typo = 'Рубли';
      control = controller.RublesTextController;
      maxLenght = 5;
    }
    else {
      typo = 'Литры';
      control = controller.LitreTextController;
      maxLenght = 3;
    }
  }
  return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
          children: [
          const ModalBarrier(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(typo),
                SizedBox(height: 10,),
                Center(
                    child:Container(
                      width: 165,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(80, 80, 80, 1),
                          image: DecorationImage(
                              image: AssetImage("assets/backgroundLogin.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Center(
                        child: SizedBox(
                          width: 150,
                          height: 50,
                          child: TextFormField(
                            //autofocus: true,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                            maxLength: maxLenght,
                            keyboardType: TextInputType.numberWithOptions(),
                            textAlign: TextAlign.center,
                          //initialValue: controller.LitreResult.value.toString(),
                          decoration: InputDecoration(
                          labelText: 'Введите количество',
                          filled: true,
                            fillColor: Colors.grey.shade800,
                            hoverColor: Colors.grey.shade800.withOpacity(0.5),
                            enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                          ),
                            controller: control,
                    ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    if(type == 'Litres') {
                      controller.fullLitresResult.value = double.parse(control.text);
                      controller.setLitresPickerAndMiliLiters(
                          controller.fullLitresResult.value);
                      controller.animatePickers('Lit');
                      Get.back();
                      control.text = '';
                      print(control.text);
                    }
                    else{
                      controller.fullRublesResult.value = double.parse(control.text);
                      controller.setRublesPickerAndKopeyki(
                          controller.fullRublesResult.value);
                      controller.animatePickers('Rub');
                      Get.back();
                      control.text = '';
                      print(control.text);
                    }
                  },
                  child: Container(
                    width: 165,
                    height: 40,
                    color: Colors.green.shade600,
                    child: Center(child: Text('Подтвердить')),
                  ),
                )
              ],
            ),
          ]
      )
  );
}

Widget MyOwnPickers(PayDialogController controller, int itemCount, String RubOrLit){

  return  Container(
      width: 50*itemCount.toDouble(),
      height: 50,
      decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(5),
  color: Colors.grey.shade800,
  ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return OwnPicker(index:index,myController: controller,RubOrLit: RubOrLit);
        },));
}

class OwnPicker extends StatefulWidget {
  OwnPicker({Key? key, this.index, this.myController, this.RubOrLit}) : super(key: key);
  final int? index;
  PayDialogController? myController;
  String? RubOrLit;
  @override
  _OwnPickerState createState() => _OwnPickerState();
}

class _OwnPickerState extends State<OwnPicker> {
  late FixedExtentScrollController scrollController;
  PayDialogController? controller;
  String? RubOrLit;
  int? index;
  bool isLitScrollable = true;
  @override
  void initState() {
    super.initState();
    if(widget.RubOrLit == 'Lit') {
      scrollController = FixedExtentScrollController(
          initialItem: widget.myController!.LitrePickerValues[widget.index!]
              .value);
      widget.myController!.ScrollOfLitrePickers.add(scrollController);
    }
    else {
      scrollController = FixedExtentScrollController(
          initialItem: widget.myController!.RublesPickerValues[widget.index!]
              .value);
      widget.myController!.ScrollOfRublesPickers.add(scrollController);
    }
    controller = widget.myController!;
    RubOrLit = widget.RubOrLit!;
    index = widget.index;


      controller!.PhysicsChanged.listen((p0) {
        int myIndex;
        if(RubOrLit == 'Rub') {
          myIndex = index!;
        }
        else{ myIndex = index!+5;}
        controller!.callbacksDone[myIndex] = false;

        if(controller!.callbacksDone[myIndex] == false) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if(RubOrLit == 'Rub') {
              if(controller!.canRublesPickerChange) {
                controller!.changePhysics('Rub', true);

              }
              else{controller!.changePhysics('Rub', false);}
            }
            else {
              if(controller!.canLitrePickerChange) {
                controller!.changePhysics('Lit', true);

              }
              else{controller!.changePhysics('Lit', false);}
            }
            setState(() {
            });
            controller!.callbacksDone[myIndex] = true;
          });
        }
        });
  }


  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int childCount;
    bool RubOrLitB = false;

    if(RubOrLit =='Lit'){
      RubOrLitB = false;
    }
    else{
      RubOrLitB = true;
    }
    if(RubOrLit == 'Rub' && index == 0){
      childCount = controller!.ChildRublesCounts[0];
    }
    else {
      childCount = 10;
    }
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.white.withOpacity(0.4)))
      ),
      child: ListWheelScrollView.useDelegate(
          controller: scrollController,
          physics: RubOrLitB ? controller!.RubScrollPhysics[index!] : controller!.LitScrollPhysics[index!],
          // physics: RubOrLitB ? (FixedExtentScrollPhysics()) : (isLitScrollable ? FixedExtentScrollPhysics() : NeverScrollableScrollPhysics()),
          itemExtent: 50,
          perspective: 0.001,
          squeeze: 1.1,
          useMagnifier: true,
          childDelegate: ListWheelChildBuilderDelegate(
              childCount: childCount,
              builder: (context, index) {
                return OwnElement(index,scrollController,widget.myController!,RubOrLit!, widget.index!);
              }),
          onSelectedItemChanged: (int) {
            // setState(() {
              SystemSound.play(SystemSoundType.click);
              if(RubOrLit == 'Rub'){
                controller!.setIndexedDigitForResult(index!, int, RubOrLit!);
              }
              if(RubOrLit =='Lit'){
                controller!.setIndexedDigitForResult(index!, int, RubOrLit!);
              }
            // });
          },
        ),
    );
  }

}

Widget OwnElement(int index, ScrollController scroll, PayDialogController controller, String RubOrLit, int IndexOfPicker){

  if(scroll.position.isScrollingNotifier.hasListeners == false) {
    scroll.position.isScrollingNotifier.addListener(() {
      if(controller.fullRublesResult.value > controller.maxRubles){
        controller.fullRublesResult.value = controller.maxRubles;
        controller.setRublesPickerAndKopeyki(controller.fullRublesResult.value);
        controller.animatePickers('Rub');

      }
      if(RubOrLit == 'Rub') {
        if (controller.RubScrollPhysics.toString() != 'NeverScrollableScrollPhysics') {
          print('Скролл пикера рублей = ${scroll.position.isScrollingNotifier
              .value}');
          if (controller.lastScrolled == 'Lit') {
            controller.rebuildAfterChangeOfPhysics(true,false);
          }
          else {
            controller.rebuildAfterChangeOfPhysics(false, true);
          }


          if (controller.ScrollOfRublesPickers[0].position.isScrollingNotifier
              .value == false
              &&
              controller.ScrollOfRublesPickers[1].position.isScrollingNotifier
                  .value == false
              &&
              controller.ScrollOfRublesPickers[2].position.isScrollingNotifier
                  .value == false
              &&
              controller.ScrollOfRublesPickers[3].position.isScrollingNotifier
                  .value == false
              &&
              controller.ScrollOfRublesPickers[4].position.isScrollingNotifier
                  .value == false) {
            print('Анимация прокрутки рублей завершена');


            controller.rebuildAfterChangeOfPhysics(false,true);


            if (controller.lastScrolled == 'Lit') {
              controller.lastScrolled = '';
              print('Сброс последнего скрола');

              controller.rebuildAfterChangeOfPhysics(true,true);
            }
            else if (controller.lastScrolled == '') {
              controller.oldLitresResult =
                  controller.fullLitresResult.value ~/ 1;
              controller.fullRublesResult.value =
                  (controller.fullRublesResult.value ~/ 1).toDouble();
              controller.lastScrolled = 'Rub';


              controller.fullLitresResult.value = controller.countFullResult(
                  controller.fullRublesResult.value, 'Lit');
              controller.setLitresPickerAndMiliLiters(
                  controller.fullLitresResult.value);

              controller.animatePickers('Lit');
              if (controller.oldLitresResult ==
                  controller.fullLitresResult.value ~/ 1) {
                controller.lastScrolled = '';
                controller.rebuildAfterChangeOfPhysics(true,true);
              }
              print(controller.lastScrolled);
            }
            else {
              controller.lastScrolled = 'Rub';

              controller.fullLitresResult.value = controller.countFullResult(
                  controller.fullRublesResult.value, 'Lit');
              controller.setLitresPickerAndMiliLiters(
                  controller.fullLitresResult.value);
              controller.animatePickers('Lit');
              print(controller.lastScrolled);
              controller.rebuildAfterChangeOfPhysics(true,true);
            }
          }
          // else{
          //   if(controller.LitScrollPhysics[0].toString() == 'FixedExtentScrollPhysics'){controller.changePhysics('Lit');}
        }
      }
       else {
        if (controller.LitScrollPhysics.toString() !=
            'NeverScrollableScrollPhysics') {
          // controller.changePhysics('Rub', false);
          // if(controller.LitScrollPhysics[IndexOfPicker].toString() != 'NeverScrollableScrollPhysics') {
          //   controller.rebuildAfterChangeOfPhysics();
          // }
          if (controller.lastScrolled == 'Lit') {
            controller.rebuildAfterChangeOfPhysics(true,false);
          }
          else if(controller.lastScrolled == 'Rub') {
            controller.rebuildAfterChangeOfPhysics(false,true);
          }
          else{controller.rebuildAfterChangeOfPhysics(true,false);}

          if (controller.ScrollOfLitrePickers[0].position.isScrollingNotifier
              .value == false
              && controller.ScrollOfLitrePickers[1].position.isScrollingNotifier
                  .value == false
              && controller.ScrollOfLitrePickers[2].position.isScrollingNotifier
                  .value == false) {
            print('Анимация прокрутки литров завершена');
            controller.rebuildAfterChangeOfPhysics(true,false);

            if (controller.lastScrolled == 'Rub') {
              controller.lastScrolled = '';
              print('Сброс последнего скрола');
              controller.rebuildAfterChangeOfPhysics(true,true);
              // controller.changePhysics('Lit', true);
              // controller.changePhysics('Rub', true);
              // controller.rebuildAfterChangeOfPhysics();
            }
            else if (controller.lastScrolled == '' ||
                controller.lastScrolled == 'Lit') {
              controller.oldRublesResult =
                  controller.fullRublesResult.value ~/ 1;
              controller.lastScrolled = 'Lit';
              if (controller.fixOldLit == '') {
                controller.fixOldLit = 'Lit';
              }
              else {
                controller.fixOldLit = '';
              }
              controller.fullLitresResult.value =
                  (controller.fullLitresResult.value ~/ 1).toDouble();


              controller.fullRublesResult.value = controller.countFullResult(
                  controller.fullLitresResult.value, 'Rub');
              controller.setRublesPickerAndKopeyki(
                  controller.fullRublesResult.value);
              if (controller.oldRublesResult ==
                  controller.fullRublesResult.value ~/ 1 &&
                  controller.fixOldLit != 'Lit') {
                controller.lastScrolled = '';
              }

              controller.animatePickers('Rub');
              print(controller.lastScrolled);
            }
          }
          // else{
          //   if(controller.RubScrollPhysics[0].toString() == 'FixedExtentScrollPhysics'){controller.changePhysics('Rub');}
          // }
        }
      }
    });
  }
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Center(
      child: Container(
        width: 40,
        height: 40,
        child: Center(child: Text(index.toString(), style: TextStyle(fontSize: 20),)),
      ),
    ),
  );
}