import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/register/register_content.dart';

import 'package:furhouse_app/common/constants.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
          child: RegisterContent(),
        ),
      ),
    );
  }
}
