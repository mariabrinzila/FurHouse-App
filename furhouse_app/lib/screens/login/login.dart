import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/login/login_content.dart';

import 'package:furhouse_app/utilities/constants.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
          child: LoginContent(),
        ),
      ),
    );
  }
}
