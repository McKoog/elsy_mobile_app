import '/screens/qrgenerate/qrGenerateComponent.dart';
import '/widgets/appbarWrapper.dart';
import '/widgets/drawerWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrCodeScreen extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40), child: AppBarWrapper()),
      drawer: DrawerWrapper(),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          children: [
            qrLabel,
            spacingH,
            spacingH,
            qrCode(),
            spacingH,
            showLabel,
            spacingH,
            spacingH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dropBonusLabel,
                Row(
                  children: [valueBonusDrop, bonusLabel],
                )
              ],
            ),
            spacingH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                balanceNowLabel,
                Row(
                  children: [valueNow, bonusLabel],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
