import '/widgets/appbarWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NewsScreen extends GetWidget {
  int index = 0;
  final items = List.generate(40, (counter) => '$counter');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBarWrapper(),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                height: 150,
                width: MediaQuery.of(context).size.width - 30,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: EdgeInsets.only(right: 5),
                        color: Colors.green,
                        child: Center(
                            child: SizedBox(
                                height: 150,
                                width: 140,
                                child: Center(
                                    child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                )))),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  height: 469,
                  width: MediaQuery.of(context).size.width - 30,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          color: Colors.green,
                          child: Center(
                              child: SizedBox(
                                  height: 250,
                                  width: 140,
                                  child: Center(
                                      child: Text(
                                    item,
                                    textAlign: TextAlign.center,
                                  )))),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.transparent,
                          ),
                      itemCount: 40),
                ),
              ),
            ],
          ),
        ));
  }
}
