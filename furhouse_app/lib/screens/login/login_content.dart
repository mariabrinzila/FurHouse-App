import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/screens/register/register.dart';

import 'package:furhouse_app/utilities/cupertino_text_field_style.dart';
import 'package:furhouse_app/utilities/outlined_button_style.dart';
import 'package:furhouse_app/utilities/elevated_button_style.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginContent({super.key});

  void navigateToRegister(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: GoogleFonts.lobster(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 270,
            child: CupertinoTextFieldStyle(
              placeholderText: 'Username',
              obscureText: false,
              textFieldController: _usernameController,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 270,
            child: CupertinoTextFieldStyle(
              placeholderText: 'Password',
              obscureText: true,
              textFieldController: _passwordController,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot password?',
              style: GoogleFonts.merriweather(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: GoogleFonts.merriweather(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              OutlinedButtonStyle(
                buttonText: 'Register',
                onTap: () {
                  navigateToRegister(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 170,
            child: ElevatedButtonStyle(
              buttonText: 'Sign In',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}