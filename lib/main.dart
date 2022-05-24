import 'dart:developer' as develop;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() {
  runApp(MaterialApp(
    home: ProductDetails(),
  ));
}

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late AnimationController _ColorAnimationController2;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween;
  late Animation<Offset> _transTween;
  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _ColorAnimationController2 =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Color(0xFFee4c4f))
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(0, 40), end: Offset(0, 0))
        .animate(_TextAnimationController);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      y = position.dy;
    });
    super.initState();
  }

  double y = 0;

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      develop.log(
          "PIXEL ${scrollInfo.metrics.pixels},    $y       , ${(scrollInfo.metrics.pixels / (y))}");
      _ColorAnimationController.animateTo(
          (scrollInfo.metrics.pixels / (y-80)));
      _ColorAnimationController2.animateTo(
          (scrollInfo.metrics.pixels / (y)));

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - (y - 90)) / 50);
      develop.log("LOG ${_transTween.value}");

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 24,
                      color: Colors.black,
                      width: 250,
                    ),
                    Container(
                      height: 250,
                      color:
                          Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                              .withOpacity(1),
                      width: 250,
                    ),
                    Text(
                      'THIS IS TITLE EXPAN',
                      key: globalKey,
                    ),
                    Container(
                      height: 250,
                      color: Colors.pink,
                      width: 250,
                    ),
                    Container(
                      height: 250,
                      color: Colors.deepOrange,
                      width: 250,
                    ),
                    Container(
                      height: 250,
                      color: Colors.red,
                      width: 250,
                    ),
                    Container(
                      height: 250,
                      color: Colors.white70,
                      width: 250,
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                child: AnimatedBuilder(
                  animation: _ColorAnimationController,
                  builder: (context, child) => AppBar(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    foregroundColor: Colors.red,
                    systemOverlayStyle: SystemUiOverlayStyle.dark,
                    titleSpacing: 0.0,
                    centerTitle: true,
                    title: Transform.translate(
                      offset: _transTween.value,
                      child: Transform.scale(
                        scale:  _ColorAnimationController2.value,
                        child: Opacity(
                          opacity: _ColorAnimationController2.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: const Text(
                              "THIS IS TITLE EXPAN1 THIS IS TITLE EXPAN 2 THIS IS TITLE EXPAN 3 THIS IS TITLE EXPAN 2 THIS IS TITLE EXPAN 3",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                    iconTheme: IconThemeData(
                      color: _iconColorTween.value,
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
}
