import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

final Widget qrLabel = Text("Ваш QR-Код", style: TextStyle(fontSize: 30));

final Widget spacingH = SizedBox(
  height: 8,
);

Widget qrCode() {
  return Stack(alignment: AlignmentDirectional.center, children: [
    Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    ),
    //TODO: MAKE DATA FOR QR-CODE
    Container(
      height: 150,
      width: 150,
      child: PrettyQr(
        data: "Нужно больше золота!",
        size: 150,
      ),
    )
  ]);
}

final Widget showLabel =
    Text("Покажите его оператору", style: TextStyle(fontSize: 23));

final Widget dropBonusLabel =
    Text("Вы снимаете", style: TextStyle(fontSize: 20));

final Widget balanceNowLabel =
    Text("Текущий баланс", style: TextStyle(fontSize: 20));

final Widget bonusLabel = Text("Бонусов", style: TextStyle(fontSize: 20));

final Widget valueBonusDrop = //TODO MAKE WITH CUPERTINO PICKER
    Text('10', style: TextStyle(backgroundColor: Colors.black, fontSize: 20));

final Widget valueNow = Text(
  '30',
  style: TextStyle(backgroundColor: Colors.black, fontSize: 20),
);
