import '/screens/news/newsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBarWrapper extends StatelessWidget {
  final String logoAsset = "assets/logo.svg";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*SvgPicture.asset(
            "assets/logo.svg",
            semanticsLabel: 'Acme Logo',
            height: 40,
            width: 40,
            color: Colors.white,
          ),*/
          /*SvgPicture.asset(
            "assets/octan_logo_test.svg",
            semanticsLabel: 'Acme Logo',
            height: 30,
            width: 30,
            color: Colors.white,
          ),*/
          /*Container(
              padding: const EdgeInsets.all(0),
              child: Text(
                "app_bar_title".tr,
                style: TextStyle(fontSize: 17),
              )),*/
          /*SvgPicture.asset(
            "assets/octan_name_logo_test.svg",
            semanticsLabel: 'Acme Logo',
            height: 30,
            color: Colors.white,
          ),*/
          Image.asset("assets/Png_octan_logo.png", fit: BoxFit.contain,scale: 2,)
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 1.0),
          child: ElevatedButton(
            onPressed: () => Get.to(NewsScreen()),
            child: Icon(Icons.new_releases_sharp),
          ),
        )
      ],
    );
  }
}
