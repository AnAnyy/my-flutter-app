import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/SlidImagePage.dart';

import 'package:flutter/material.dart';

class RecordListPage extends StatefulWidget {
  const RecordListPage({Key? key}) : super(key: key);

  @override
  _FlowPageState createState() => _FlowPageState();
}

class _FlowPageState extends State<RecordListPage> {
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlowPage"),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: _addItem)],
      ),
      body: SafeArea(child: _mainView()),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ListTile(key: ValueKey(_items[index]), title: Text(_items[index]));
  }

  void _addItem() {
    setState(() {
      _items.add('Item ${_items.length + 1}');
    });
  }

  _mainView() {
    return ReorderableListView.builder(
      itemCount: _items.length,
      itemBuilder: _buildItem,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          String item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
       // 可选：自定义拖拽反馈
        proxyDecorator: (child, index, animation) {
          return Material(
            elevation: 8,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
    );
  }
  // List<String> _items = [
  //   '项目 1 - 苹果',
  //   '项目 2 - 香蕉',
  //   '项目 3 - 橙子',
  //   '项目 4 - 葡萄',
  //   '项目 5 - 西瓜',
  //   '项目 6 - 草莓',
  //   '项目 7 - 芒果',
  // ];

  // // 构建每个列表项（必须包含Key！）
  // Widget _buildItem(BuildContext context, int index) {
  //   return Card(
  //     key: Key(_items[index]), // 必须：为每个item设置唯一的Key
  //     elevation: 2,
  //     margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  //     child: ListTile(
  //       leading: ReorderableDragStartListener(
  //         index: index,
  //         child: Icon(Icons.drag_handle, color: Colors.grey),
  //       ),
  //       title: Text(_items[index]),
  //       trailing: Icon(Icons.menu, color: Colors.grey[400]),
  //       tileColor: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('拖拽排序列表'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.add),
  //           onPressed: () {
  //             setState(() {
  //               _items.add('新项目 ${_items.length + 1}');
  //             });
  //           },
  //         ),
  //       ],
  //     ),
  //     body: ReorderableListView.builder(
  //       padding: EdgeInsets.all(8),
  //       itemCount: _items.length,
  //       itemBuilder: _buildItem,
  //       onReorder: (int oldIndex, int newIndex) {
  //         setState(() {
  //           // 处理拖拽逻辑
  //           if (oldIndex < newIndex) {
  //             newIndex -= 1;
  //           }
  //           final item = _items.removeAt(oldIndex);
  //           _items.insert(newIndex, item);
  //         });
  //       },
  //       // 可选：自定义拖拽反馈
  //       proxyDecorator: (child, index, animation) {
  //         return Material(
  //           elevation: 8,
  //           color: Colors.transparent,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2),
  //                   blurRadius: 8,
  //                   spreadRadius: 2,
  //                 ),
  //               ],
  //             ),
  //             child: child,
  //           ),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.refresh),
  //       onPressed: () {
  //         setState(() {
  //           // 重置列表
  //           _items = List.generate(7, (i) => '项目 ${i + 1}');
  //         });
  //       },
  //     ),
  //   );
  // }
}
