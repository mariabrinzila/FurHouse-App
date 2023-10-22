import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class PetPageTheme extends StatelessWidget {
  final Widget childWidget;

  const PetPageTheme({
    super.key,
    required this.childWidget,
  });

  void _onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: darkBlueColor,
          leading: IconButton(
            onPressed: () {
              _onGoBack(context);
            },
            icon: const Icon(
              CupertinoIcons.arrow_left_square_fill,
            ),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/Logo.png",
            color: Colors.white,
            width: 250,
            height: 180,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lightBlueColor,
                lighterBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
