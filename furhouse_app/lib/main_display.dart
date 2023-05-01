import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/landing/landing.dart';

import 'package:furhouse_app/common/constants.dart';

class MainDisplay extends StatelessWidget {
  const MainDisplay({super.key});

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
          child: const Landing(),
        ),
      ),
    );
  }
}
