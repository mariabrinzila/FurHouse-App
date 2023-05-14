import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class MainTheme extends StatelessWidget {
  final Widget childWidget;

  const MainTheme({
    super.key,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                darkerBlueColor,
                lightBlueColor,
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
