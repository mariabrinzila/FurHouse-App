import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/home/image_animation.dart';

import 'package:furhouse_app/utilities/elevated_button_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ImageAnimation(),
          SizedBox(
            width: 200,
            child: ElevatedButtonStyle(
              buttonText: 'Sign into account',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButtonStyle(
              buttonText: 'Create account',
            ),
          ),
        ],
      ),
    );
  }
}
