import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/SlidImagePage.dart';

import 'package:flutter/material.dart';

class ExtendedImagePage extends StatefulWidget {

  const ExtendedImagePage({Key? key})
    : super(key: key);

  @override
  _ExtendedImagePageState createState() => _ExtendedImagePageState();
}

class _ExtendedImagePageState extends State<ExtendedImagePage> {
  bool isFromNetWork = true;
  String imgUrl = "https://photo.tuchong.com/14649482/f/601672690.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ExtendedImagePage")),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        // 点击图片跳转到一个有遮罩背景层的页面
                        return SlideImagePage(
                          url: imgUrl,
                          isNetWork: isFromNetWork,
                        );
                      },
                    ),
                  ),
                  // 图片要包裹在Hero组件中
              child: Hero(
                tag: imgUrl,
                child:
                    isFromNetWork
                        ? ExtendedImage.network(
                          imgUrl,
                          width: 100,
                          height: 100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2.0),
                          fit: BoxFit.fill,
                          // headers: headers,
                        )
                        : ExtendedImage.file(
                          File(imgUrl),
                          width: 100,
                          height: 100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2.0),
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            _renderAddPhoto(),
          ],
        ),
      ),
    );
  }

// 渲染添加图片按钮
  _renderAddPhoto() {
    return InkWell(
      onTap: _handleTakePhoto,
      child: Container(
        width: 64,
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.0),
          border: Border.all(
            color: Color.fromRGBO(162, 162, 164, 1.0),
            width: 0.5,
          ),
        ),
        child: Icon(
          Icons.camera_alt,
          color: Color.fromRGBO(162, 162, 164, 1.0),
        ),
      ),
    );
  }

  // 打开相册
  _handleTakePhoto() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          imgUrl = file.path;
          isFromNetWork = false;
        });
      } else {
        // EasyLoadingUtil.showToast("No image selected.");
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error selecting image: $e')));
    }
  }

}
