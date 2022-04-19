import '/widgets/appbarWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardScreen extends GetWidget {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    final items = List.generate(40, (counter) => '$counter');
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBarWrapper(),
        ),
        body: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width - 30,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: Center(
                          child: SizedBox(
                              height: 70,
                              width: 140,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 70,
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          item,
                                          textAlign: TextAlign.center,
                                        )
                                      ])))),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.transparent,
                      ),
                  itemCount: 40),
            )));
  }
}
