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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                darkBlueColor,
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
