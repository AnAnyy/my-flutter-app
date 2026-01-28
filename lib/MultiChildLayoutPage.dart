import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/SlidImagePage.dart';

import 'package:flutter/material.dart';

class MultiChildLayoutPage extends StatefulWidget {
  const MultiChildLayoutPage({Key? key}) : super(key: key);

  @override
  _MultiChildLayoutPageState createState() => _MultiChildLayoutPageState();
}

class _MultiChildLayoutPageState extends State<MultiChildLayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MultiChildLayoutPage")),
      body: SafeArea(
        child: CustomMultiChildLayout(
          delegate: ColorBlockLayoutDelegate(),
          children: [
            LayoutId(id: 'red_block', child: ColorBlock(color: Colors.red)),
            LayoutId(id: 'green_block', child: ColorBlock(color: Colors.green)),
            LayoutId(id: 'blue_block', child: ColorBlock(color: Colors.blue)),
            LayoutId(
              id: 'yellow_block',
              child: ColorBlock(color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorBlockLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final double blockSize = 100;
    final double padding = 16;

    layoutChild('red_block', BoxConstraints.tight(Size(blockSize, blockSize)));
    positionChild('red_block', Offset(padding, padding));

    layoutChild(
      'green_block',
      BoxConstraints.tight(Size(blockSize, blockSize)),
    );
    positionChild('green_block', Offset(size.width - blockSize - 16, padding));

    layoutChild('blue_block', BoxConstraints.tight(Size(blockSize, blockSize)));
    positionChild('blue_block', Offset(padding, size.height - blockSize - padding));

    layoutChild(
      'yellow_block',
      BoxConstraints.tight(Size(blockSize, blockSize)),
    );
    positionChild('yellow_block', Offset(size.width - blockSize - padding, size.height - blockSize - padding));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

class ColorBlock extends StatelessWidget {
  final Color color;

  ColorBlock({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(color: color);
  }
}
