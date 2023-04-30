import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/home/home_content.dart';

import 'package:furhouse_app/utilities/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [darkBlueColor, lightBlueColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const HomeContent(),
        ),
      ),
    );
  }
}
