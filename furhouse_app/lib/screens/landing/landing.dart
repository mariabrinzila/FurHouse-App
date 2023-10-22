import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/landing/image_animation.dart';
import 'package:furhouse_app/screens/login/login.dart';
import 'package:furhouse_app/screens/register/register.dart';

import 'package:furhouse_app/common/widget_templates/elevated_button_style.dart';

class Landing extends StatelessWidget {
  const Landing({
    super.key,
  });

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ImageAnimation(),
          SizedBox(
            width: 200,
            child: ElevatedButtonStyle(
              buttonText: "Sign into account",
              onTap: () {
                _navigateToLogin(context);
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButtonStyle(
              buttonText: "Create account",
              onTap: () {
                _navigateToRegister(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
