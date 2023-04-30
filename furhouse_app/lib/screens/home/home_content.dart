import 'package:flutter/material.dart';

import 'package:furhouse_app/utilities/constants.dart';

import 'package:furhouse_app/utilities/elevated_button_style.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/Logo2.png',
            width: 350,
            color: lightBlueColor,
          ),
          const SizedBox(
            height: 30,
          ),
          const ElevatedButtonStyle(buttonText: 'Sign into account'),
          const SizedBox(
            height: 30,
          ),
          const ElevatedButtonStyle(buttonText: 'Create account'),
        ],
      ),
    );
  }
}
