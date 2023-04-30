import 'package:flutter/material.dart';

class ImageAnimation extends StatefulWidget {
  const ImageAnimation({super.key});

  @override
  State<ImageAnimation> createState() {
    return _ImageAnimationState();
  }
}

class _ImageAnimationState extends State<ImageAnimation> {
  var _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // this makes sure that _changeOpacity() is executed after the widget has been rendered (change the state automatically when the widget is rendered)
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _changeOpacity());
  }

  void _changeOpacity() {
    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 5),
      child: Image.asset(
        'assets/images/Logo2.png',
        width: 400,
        color: Colors.white,
      ),
    );
  }
}
