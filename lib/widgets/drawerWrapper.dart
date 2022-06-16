import '/data/localstorage/local_storage_user_impl.dart';
import '/routes/navigation.dart';
import '/screens/cards/cardsScreen.dart';
import '/screens/history/historyScreen.dart';
import '/widgets/drawerController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DrawerWrapper extends GetWidget<DraawerController>{
  final drawerController = Get.find<DraawerController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            height: 115.0,
            child: DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/octan_logo_test.svg",
                          semanticsLabel: 'Acme Logo',
                          height: 50,
                          width: 50,
                          color: Colors.blue,
                        ),
                      ],
                    )
                  ]),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage("assets/backgroundLogin.png"),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            title: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 3),
                height: 65,
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5),
                      child: Text(
                        "drawer_navigation_user".tr + ':',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 40,),
                        SizedBox(
                          width: 2,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 0),
                            Text(controller.NameOfUser()),
                            SizedBox(height: 5),
                            Text(controller.EmailOfUser()),
                          ],
                        ),

                        Container(
                            margin: EdgeInsets.only(right: 5),
                            height: 30,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(6)),
                            child: IconButton(
                              onPressed: () {
                                LocalStorageImplUser().clearAllData();
                                Get.offAllNamed(Routes.login);
                              },
                              iconSize: 15,
                              icon: Icon(Icons.logout_sharp),
                            ))
                      ],
                    ),
                  ],
                )),
            onTap: () {
              Get.toNamed(Routes.profile);
            },
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.history),
              SizedBox(
                width: 2,
              ),
              Text("drawer_navigation_history".tr)
            ]),
            onTap: () {
              Get.to(HistoryScreen());
            },
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.payment_rounded),
              SizedBox(
                width: 2,
              ),
              Text("drawer_navigation_payment".tr)
            ]),
            onTap: () {
              Get.toNamed(Routes.cardPay);
            },
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.card_membership),
              SizedBox(
                width: 2,
              ),
              Text("drawer_navigation_card".tr)
            ]),
            onTap: () {
              Get.to(CardScreen());
            },
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.map),
              SizedBox(
                width: 2,
              ),
              Text("drawer_navigation_map".tr)
            ]),
            onTap: () {
              Get.offAllNamed(Routes.map);
            },
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.info),
              SizedBox(
                width: 2,
              ),
              Text("drawer_navigation_additionally".tr)
            ]),
            onTap: () {},
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.help_outline_rounded),
              SizedBox(
                width: 2,
              ),
              Text("drawer_navigation_help".tr)
            ]),
            onTap: () {
            },
          ),
        ],
      )),
    );
  }
}
