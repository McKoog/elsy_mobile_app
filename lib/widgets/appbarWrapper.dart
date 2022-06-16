import '/screens/news/newsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
