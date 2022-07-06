import '/screens/profile/controller/profileController.dart';
import '/screens/profile/profileScreenComponent.dart';
import '/widgets/appbarWrapper.dart';
import '/widgets/drawerWrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40), child: AppBarWrapper()),
        drawer: DrawerWrapper(),
        body: Column(children: [
          Container(
              width: 1000,
              height: 100,
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: /*Color.fromRGBO(63, 81, 181, 1),*/Colors.grey.shade400.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("assets/backgroundLogin.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 1000,
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5, top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              titleIcon,
                              titleText,
                              spacingW,
                              spacingW,
                              accountInfo
                            ],
                          ),
                        ),
                      )),
                ],
              )),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("profile_name".tr, style: TextStyle(color: Colors.grey),),
                  nameField(controller),
                  spacingH,
                  Text("profile_email".tr, style: TextStyle(color: Colors.grey),),
                  emailField(controller),
                  spacingH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("profile_type_of_fuel".tr, style: TextStyle(color: Colors.grey),),
                          fuelPickerGreyBox(context,fuelPicker(controller)),
                        ],
                      ),
                      //fuelField(controller),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("profile_size_of_fuel".tr, style: TextStyle(color: Colors.grey),),
                          valueField(controller, context),
                        ],
                      )
                    ],
                  ),
                  spacingH,
                  saveButton(controller, MediaQuery.of(context).size.width-30)
                ],
              ))
        ]));
  }
}
