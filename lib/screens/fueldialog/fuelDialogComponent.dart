import '../../models/dataServer/fuelDialogData.dart';
import '/routes/navigation.dart';
import '/screens/fueldialog/controller/fuelDialogController.dart';
import '/utils/parseStandartSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

final Widget fuelDialogLabel = Text(
  "fuel_dialog_title".tr,
  style: TextStyle(fontSize: 20),
);

Widget nextButton(FuelDialogController controller, FuelDialogData data) {
  return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: () => controller.onNextButtonTap(data),
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(38, 97, 37, 1).withOpacity(0.3)),
          child: Text(/*"fuel_dialog_next_button".tr*/"column_dialog_pay_button".tr)));
}

Widget qrButton(FuelDialogController controller) {
  return SizedBox(
      height: 50,
      child: ElevatedButton(
          onPressed: (){
              controller.navigateToQR();
            },
          style:
              ElevatedButton.styleFrom(primary: Color.fromRGBO(80, 80, 80, 1)),
          child: Row(
            children: [
              Icon(Icons.qr_code_sharp),
              Text("fuel_dialog_qr_button".tr)
            ],
          )));
}

final Widget rubLabel = Text("fuel_dialog_rub".tr);

final Widget litersLabel = Text("fuel_dialog_liters".tr);

Widget pumpLabel(FuelDialogController controller) {
  return Text(controller.fuelArgData[1].toString(),
      style: TextStyle(fontSize: 25));
}

Widget infoLabel(FuelDialogController controller) {
  return Text(controller.fuelArgData[2].toString(),
      style: TextStyle(fontSize: 15));
}

Widget nameUser(FuelDialogController controller) {
  return Text(controller.fuelArgData[5].toString(),
      style: TextStyle(fontSize: 14));
}

final Widget darkBox = SizedBox(
  width: 158,
  height: 48,
  child: Container(
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(10)),
  ),
);

final Widget spacingW = SizedBox(
  width: 16,
);
final Widget spacingH = SizedBox(
  height: 16,
);

class TrkPicker extends StatefulWidget {
  TrkPicker({Key? key, this.controller, this.minNumber, this.maxNumber, this.data}) : super(key: key);
  FuelDialogController? controller;
  int? minNumber;
  int? maxNumber;
  List<FPData>? data;
  @override
  _TrkPickerState createState() => _TrkPickerState();
}

class _TrkPickerState extends State<TrkPicker> {
  @override
  Widget build(BuildContext context) {
      return Obx(() {
        return NumberPicker(
          textStyle: TextStyle(
              fontSize: 20, color: Colors.white.withOpacity(0.6)),
          selectedTextStyle: TextStyle(fontSize: 22, color: Colors.white),
          itemCount: 3,
          itemHeight: 50,
          itemWidth: 65,
          minValue: widget.minNumber!,
          maxValue: widget.maxNumber!,
          value: widget.controller!.trkPickerValue.value,
          axis: Axis.horizontal,
          decoration: BoxDecoration(
            border: Border.symmetric(
                vertical: BorderSide(color: Colors.white.withOpacity(0.1))),
            // borderRadius: BorderRadius.circular(15),
          ),
          onChanged: (int value) {
            setState(() => widget.controller!.trkPickerValue.value = value);
            widget.controller!.makeAvailableListOfFuelByNumber(value,widget.data!);

          },
        );
      }
      );
  }
}
Widget TrkTable(FuelDialogController controller,int index){
    return InkWell(
      onTap: (){
        if(controller.pickedOne != null){ controller.colorsOfBlocks[controller.pickedOne] = Colors.grey.shade800; }
        controller.colorsOfBlocks[index] = Colors.lightBlueAccent.withOpacity(0.2);
        controller.pickedOne = index;
      },
      child: Obx((){
        return Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
              color: Colors.white.withOpacity(0.5),),
          ),

            /*border: Border.symmetric(
                horizontal: BorderSide(
                    color: Colors.white.withOpacity(0.5)),),*/
          color: controller.colorsOfBlocks[index],
        ),
          child: Center(child: Text(
          controller.availableFuel[index],style: TextStyle( fontSize: 20),),),
      );
    },),
  );
}
Widget AddSubtract(Widget child, FuelDialogController controller){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(onTap: (){controller.decreasePickerValue();},child: Container(width: 50,height: 50,child: Center(child: Text('—', style: TextStyle(fontSize: 22),)))),
      Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade800,
        ),
        child: child,
      ),
      InkWell(onTap: (){controller.increasePickerValue();},child: Container(width: 50,height: 50,child: Center(child: Text('+', style: TextStyle(fontSize: 22),)))),
    ],
  );
}
