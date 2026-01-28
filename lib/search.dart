import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchPage extends StatefulWidget {
  final String? title;
  final String? counter;
  final String? url;

  const SearchPage({Key? key, this.url, this.counter, this.title})
    : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();
  bool _isOffstage = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebView Page")),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(color: Colors.blue, height: 80),
                  Positioned(
                    left: 30,
                    right: 30,
                    bottom: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      height: 48,
                      child: TextField(
                        controller: textEditingController,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        focusNode: FocusNode(),
                        cursorColor: Colors.blue,
                        style: TextStyle(
                          // height: 1.4,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          icon: Padding(
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 24,
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          hintText: '输入关键词',
                          hintStyle: TextStyle(
                            // height: 1.4,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          // 上下居中的关键
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: -10,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          // counterText: "",
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 80,
                width: 200,
                alignment: Alignment.center,
                color: Colors.yellow,
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ..._getStackItem(3),
                      Positioned(
                        right: -10,
                        top: -8,
                        child: Container(
                          width: 28,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            '10',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _renderBox(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getStackItem(int count) {
    List<Widget> _list = [];
    for (var i = 0; i < count; i++) {
      double off = 40.0 * i;
      _list.add(
        Positioned(
          left: off,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(25),
                  // ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://img0.baidu.com/it/u=3417075657,2003823627&fm=253&app=138&f=JPEG?w=500&h=500',
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    // 背景过滤器
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _list;
  }

  _renderBox() {
    return Column(
      children: [
        // 非常用组件
        // FractionallySizedBox: 按比例来设置子组件的宽高
        Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.6,
            child: Container(color: Colors.red, child: Text('')),
          ),
        ),
        // BoxFit.contain: 子组件 (一个网络图片/文字 ) 将被缩放以适应父容器的大小,同时保持原有的宽高比
        Container(
          width: 300,
          height: 100,
          color: Colors.grey[200],
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "FittedBox 是一个很有用的布局组件,它可以帮助我们控制子组件的大小和位置,使其能够适应父容器的大小。",
            ),
          ),
        ),
        // LimitedBox: 限制子组件的最大宽高,截断子组件的文本
        LimitedBox(
          maxWidth: 200,
          maxHeight: 100,
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            child: Text('LimitedBox 限制子组件的最大宽高为 200x100'),
          ),
        ),
        // 可以平移和缩放
        InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20),
          minScale: 0.1,
          maxScale: 2,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
            child: Center(
              child: Text(
                'InteractiveViewer 可以让子组件支持缩放和平移操作',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          child: Text(
            "Gradient Text",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isOffstage = !_isOffstage;
                  });
                  print('_scrollController.position.pixels ${_scrollController.position.pixels}');
                  print('_scrollController.position.maxScrollExtent ${_scrollController.position.maxScrollExtent}');
                  if(!_isOffstage){
                    _scrollController.animateTo(
                      _scrollController.offset + 100,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut
                    );
                  }
                },
                child: const Text('Toggle Offstage'),
              ),
              Offstage(
                offstage: _isOffstage,
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      'Offstage 控制组件的显示和隐藏',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Draggableball(),
        SizedBox(height: 32),
        DragTargetWidget(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
          Baseline(
            baseline: 30.0,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              'Hello',
              style: TextStyle(fontSize: 48,backgroundColor: Colors.red),
            ),
          ),
          SizedBox(width: 8),
          Baseline(
            baseline: 30.0,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              'World',
              style: TextStyle(fontSize: 24,backgroundColor: Colors.blue),
            ),
          )

        ],)
      ],
    );
  }
  Draggableball(){
    return Draggable<String>(
      data: 'ball',
      child: Container(
        width:50,
        height: 50,
        decoration: BoxDecoration(
         shape:BoxShape.circle,
         color: Colors.orange
        )
      ),
      feedback: Container(
        width:50,
        height: 50,
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color: Colors.orange.withOpacity(0.5)
        )
      ),
    );
  }
  
  Color _color = Colors.grey;
  DragTargetWidget(){
    return DragTarget<String>(
      onAccept:(data){
        setState(() {
          _color = Colors.green;
        });
      },
      onLeave:(data){
        setState(() {
          _color = Colors.grey;
        });
      },
      builder: (context,candidateData,rejectedData){
        return Container(
          width:200,
          height:200,
          color: _color,
          child: Center(
            child: Text(
              'Drag Target',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
