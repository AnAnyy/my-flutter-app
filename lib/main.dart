import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/ExtendedImagePage.dart';
import 'package:my_flutter_app/FlowPage.dart';
import 'package:my_flutter_app/ListViewPage.dart';
import 'package:my_flutter_app/MultiChildLayoutPage.dart';
import 'package:my_flutter_app/RecordListPage.dart';
import 'package:my_flutter_app/WheelList.dart';
import 'package:my_flutter_app/photoBrowsePage.dart';
import 'package:my_flutter_app/search.dart';
import 'package:my_flutter_app/webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final PageController _pageController = PageController();

  TabController? _tabController;

  final List<String> tab = ["动态", "趋势", "我的"];

  @override
  void initState() {
    super.initState();

    ///初始化时创建控制器
    ///通过 with SingleTickerProviderStateMixin 实现动画效果。
    _tabController = new TabController(vsync: this, length: tab.length);

     // 添加监听器，当TabBar点击时跳转PageView
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        _pageController.jumpToPage(_tabController!.index);
      }
    });
  }

    @override
    void dispose() {
      ///页面销毁时，销毁控制器
      _tabController?.dispose();
      super.dispose();
    }


  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      // appBar: AppBar(
      //   title: Text("TabBar & PageView"),
      //   bottom: TabBar(
      //     // 可以横向滑动
      //     // isScrollable: true,
      //     controller: _tabController,
      //     tabs: tab.map((e) => Tab(text: e)).toList(),
      //   ),
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          ///页面切换时，改变底部 Tabbar 选中状态
          _tabController?.animateTo(index);
        },
        children: <Widget>[
         ListViewPage(),
          Center(child: Text("趋势")),
          Center(child: Text("我的")),
        ],
      ),
      bottomNavigationBar:TabBar(
          controller: _tabController,
          tabs: tab.map((e) => Tab(text: e)).toList(),
        ),
    ));
    
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const Text('You have pushed the button this many times:'),
  //           Text(
  //             '$_counter',
  //             style: Theme.of(context).textTheme.headlineMedium,
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder:
  //                       (context) => WebViewNotifyPage(counter: '$_counter'),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open WebView Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => SearchPage()),
  //               );
  //             },
  //             child: const Text(
  //               'Open search Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => PhotoBrowsePage(initIndex: 2),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open photo Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //          InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => ExtendedImagePage(),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open extended Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => FlowPage(),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open Flow Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => MultiChildLayoutPage(),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open MultiChildLayoutPage Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //            InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => RecordListPage(),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open List Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //            InkWell(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => WheelList(),
  //                 ),
  //               );
  //             },
  //             child: const Text(
  //               'Open Wheel Page',
  //               style: TextStyle(
  //                 color: Colors.blue,
  //                 decoration: TextDecoration.underline,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _incrementCounter,
  //       tooltip: 'Increment',
  //       child: const Icon(Icons.add),
  //     ),
  //   );
  // }
}
