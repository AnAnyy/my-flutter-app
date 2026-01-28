import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/SlidImagePage.dart';

import 'package:flutter/material.dart';

class FlowPage extends StatefulWidget {

  const FlowPage({Key? key})
    : super(key: key);

  @override
  _FlowPageState createState() => _FlowPageState();
}

class _FlowPageState extends State<FlowPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FlowPage")),
      body: SafeArea(
        child: 
            Flow(
              delegate: MyFlowDelegate(),
              children:[
                Container(width:100,height:100,color: Colors.red),
                Container(width:100,height:100,color: Colors.green),
                Container(width:100,height:100,color: Colors.blue),
                Container(width:100,height:100,color: Colors.orange),

              ]
            )
         
      ),
    );
  }
 
}

 class MyFlowDelegate extends FlowDelegate {
     @override
     void paintChildren(FlowPaintingContext context) {
      double dx = 0.0;
      double dy = 0.0;

      for(int i=0; i< context.childCount; i++){
        double width = context.getChildSize(i)!.width;
        double height = context.getChildSize(i)!.height;

        context.paintChild(i,transform: Matrix4.translationValues(dx, dy, 0.0));

        dx += width + 16;
        if(dx + width + 16.0 > context.size.width){
          dx = 0.0;
          dy += height + 16;
        }
      }
     }

      @override
      bool shouldRepaint(covariant FlowDelegate oldDelegate) {
        return false;
      }
  }
