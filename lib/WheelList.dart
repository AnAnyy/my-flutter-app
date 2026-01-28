import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class WheelList extends StatefulWidget {
  final bool isNetWork;

  const WheelList({Key? key, this.isNetWork = false}) : super(key: key);

  @override
  _WheelListState createState() => _WheelListState();
}

class _WheelListState extends State<WheelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WheelPage"),
      ),
      body: SafeArea(child: _mainView()),
    );
  }

  _mainView() {
    return Material(
      child: ListWheelScrollView(
        itemExtent: 100, // 每个项目的高度
        diameterRatio: 2,  // 滚轮直径与项目高度的比率
        offAxisFraction: 1, // 滚轮的倾斜角度
        children: List.generate(
          20,
          (index) => Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(child: Text('Item $index')),
          ),
        ),
        onSelectedItemChanged: (index) {
          print('Selected item index: $index');
        },
      ),
    );
  }
}
