import '/screens/history/controller/historyController.dart';
import '/widgets/appbarWrapper.dart';
import '/widgets/drawerWrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  static List<dynamic> HistoryItems = [];
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final historyController = Get.find<HistoryController>();
  @override
  Widget build(BuildContext coontext) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerWrapper(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBarWrapper(),
      ),
      body: Container(
        //padding: EdgeInsets.only(top: 8),
        child: ListView.builder(
            itemCount: HistoryScreen.HistoryItems.length,
            itemBuilder: (BuildContext context, int){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: HistoryScreen.HistoryItems[int],
              );
            }),
      ),
    );
  }
}

