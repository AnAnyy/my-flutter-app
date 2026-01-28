import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {

  const ListViewPage({Key? key, }) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage>
    with AutomaticKeepAliveClientMixin<ListViewPage> {
  @override
  bool get wantKeepAlive => false;

  final ScrollController _scrollController = new ScrollController();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  ///控制器，比如数据和一些配置
  final GSYPullLoadWidgetControl control = new GSYPullLoadWidgetControl();
  
  bool isLoading = false;

  @override
  void initState() {
    // 增加滑动监听
    _scrollController.addListener((){
       // 判断当前滑动位置是不是达到底部，触发加载更多回调
       if(_scrollController.position.pixels ==
           _scrollController.position.maxScrollExtent && control.needLoadMore.value) {
        onLoadMore();
       }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return new RefreshIndicator(
      ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: refreshIndicatorKey,

      ///下拉刷新触发，返回的是一个Future
      onRefresh: onRefresh,
      child: new ListView.builder(
        ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
        physics: const AlwaysScrollableScrollPhysics(),

        ///根据状态返回子控件
        itemBuilder: (context, index) {
          return _getItem(index);
        },

        ///根据状态返回数量
        itemCount: _getListCount(),

        ///滑动监听
        controller: _scrollController,
      ),
    );
  }

 onLoadMore() {
  // 防止在5秒之内多次触发加载更多
  if(isLoading) {
      return;
    }
    isLoading = true;
    //模拟网络请求，延时两秒
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        control.dataList.addAll([21,22,23,24,25,26,27,28,29,30]);
        if(control.dataList.length >= 40) {
          control.needLoadMore.value = false;
        }
      });
      isLoading = false;
    });
  }

  ///下拉刷新数据
   Future<void> onRefresh() async {
    control.needLoadMore.value = true;
    //模拟网络请求，延时两秒
    return await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        control.dataList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
      });
    });

  }


   ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!control!.needHeader && index == control!.dataList.length && control!.dataList.length != 0) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (control.needHeader && index == _getListCount() - 1 && control!.dataList.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!control.needHeader && control.dataList.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return itemBuilder(context, index);
    }
  }

    ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount() {
    ///是否需要头部
    if (control.needHeader) {
      ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
      ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (control.dataList.length > 0) ? control.dataList.length + 2 : control.dataList.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (control.dataList.length == 0) {
        return 1;
      }

      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return (control.dataList.length > 0) ? control.dataList.length + 1 : control.dataList.length;
    }
  }

   ///上拉加载更多
  Widget _buildProgressIndicator() {
     return control.needLoadMore.value ? Text('加载更多') : Text('没有更多数据了');
  }

 Widget _buildEmpty() {
    return Center(
      child: Text("空页面"),
    );
  }

itemBuilder(BuildContext context, int index) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text("Item $index"),
    );
  }
  
}



class GSYPullLoadWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = [];

  ///是否需要加载更多
  ValueNotifier<bool> needLoadMore = ValueNotifier(true);

  ///是否需要头部
  bool needHeader = false;
}