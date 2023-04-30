import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/utilities/cupertino_text_field_style.dart';
import 'package:furhouse_app/utilities/elevated_button_style.dart';

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({super.key});

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
            height: 20,
          ),
          const SizedBox(
            width: 170,
            child: ElevatedButtonStyle(
              buttonText: 'Sign In',
            ),
          ),
        ],
      ),
    );
  }
}
