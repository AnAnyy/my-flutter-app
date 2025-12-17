import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNotifyPage extends StatefulWidget {
  final String? title;
  final String? counter;
  final String? url;

  const WebViewNotifyPage({Key? key, this.url, this.counter, this.title})
    : super(key: key);

  @override
  _WebViewNotifyPageState createState() => _WebViewNotifyPageState();
}

class _WebViewNotifyPageState extends State<WebViewNotifyPage> {
  final String H5_URL = "http://10.152.34.8:5173/";

  WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    initWebView();
    super.initState();
  }

  initWebView() {
    _webViewController
      ..setBackgroundColor(Colors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 允许js代码
      // 加载本地HTML文件（核心！）
      // ..loadFlutterAsset('assets/html/notify.html')
      // 加载网络h5页面 (http地址)
      ..loadRequest(Uri.parse(widget.url ?? H5_URL));

    // 与H5页面进行通信的桥梁
    _webViewController.addJavaScriptChannel(
      // 会在H5的window上挂载一个FlutterBridge对象，该对象包含一个postMessage方法发送数据给flutter
      "flutterBridge",
      onMessageReceived: (JavaScriptMessage jsMsg) {
        print("JavaScriptMessage: ${jsMsg}");
        String message = jsMsg.message; // 根据 h5 传递的数据类型进行接收
        print("message: ${message}");

        // 传递初始化数据
        _sendFlutterInitMessage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WebView Page")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: WebViewWidget(controller: _webViewController)),
          ],
        ),
      ),
    );
  }

  // 从flutter 发送初始化信息
  _sendFlutterInitMessage() async {
    // 调用 h5 页面中方法
    _webViewController.runJavaScript('''
        receiveFromFlutter(${widget.counter ?? -1});
      ''');
  }
}
