import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SlideImagePage extends StatefulWidget {
  final String url;
  final bool isNetWork;

  const SlideImagePage({Key? key, required this.url, this.isNetWork = false})
      : super(key: key);

  @override
  _SlideImagePageState createState() => _SlideImagePageState();
}

class _SlideImagePageState extends State<SlideImagePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ExtendedImageSlidePage(
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            child: widget.isNetWork ? _renderNetWork() : _renderNativeFile(),
          ),
        ),
      ),
    );
  }

  _renderNativeFile() {
    return ExtendedImage.file(
      File(widget.url),
      enableSlideOutPage: true,
      fit: BoxFit.contain,

      ///make hero better when slide out
      heroBuilderForSlidingPage: (Widget result) {
        return Hero(
          tag: widget.url,
          child: result,
          flightShuttleBuilder: (BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext) {
            final Hero hero = (flightDirection == HeroFlightDirection.pop
                ? fromHeroContext.widget
                : toHeroContext.widget) as Hero;
            return hero.child;
          },
        );
      },
      mode: ExtendedImageMode.gesture,
      // extendedImageGestureKey: gestureKey,
      initGestureConfigHandler: (ExtendedImageState state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 4.0,
          animationMaxScale: 4.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
          initialAlignment: InitialAlignment.center,
          // gestureDetailsIsChanged: (GestureDetails details) {
          //   print(details.totalScale);
          // },
        );
      },
    );
  }

  _renderNetWork() {
    return ExtendedImage.network(
      widget.url,
      enableSlideOutPage: true,
      fit: BoxFit.contain,

      ///make hero better when slide out
      heroBuilderForSlidingPage: (Widget result) {
        return Hero(
          tag: widget.url,
          child: result,
          flightShuttleBuilder: (BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext) {
            final Hero hero = (flightDirection == HeroFlightDirection.pop
                ? fromHeroContext.widget
                : toHeroContext.widget) as Hero;
            return hero.child;
          },
        );
      },
      mode: ExtendedImageMode.gesture,
      // extendedImageGestureKey: gestureKey,
      initGestureConfigHandler: (ExtendedImageState state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 4.0,
          animationMaxScale: 4.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
          initialAlignment: InitialAlignment.center,
          // gestureDetailsIsChanged: (GestureDetails details) {
          //   print(details.totalScale);
          // },
        );
      },
    );
  }
}
