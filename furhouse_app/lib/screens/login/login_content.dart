import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

import 'package:furhouse_app/screens/register/register.dart';

import 'package:furhouse_app/common/cupertino_text_field_style.dart';
import 'package:furhouse_app/common/outlined_button_style.dart';
import 'package:furhouse_app/common/elevated_button_style.dart';
import 'package:furhouse_app/common/cupertino_form_dialog.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginContent({super.key});

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );
  }

  void _formFieldValidation(BuildContext context) {
    if (_emailController.text.isEmpty) {
      _toggleValidationAlert(
        context,
        const Text(
          'Empty email',
        ),
        const Text(
          'The email must not be empty!',
        ),
      );
    } else if (!EmailValidator.validate(_emailController.text)) {
      _toggleValidationAlert(
        context,
        const Text(
          'Incorrect email',
        ),
        const Text(
          'The email must have the correct format, for example johnDoe@gmail.com!',
        ),
      );
    } else if (_passwordController.text.isEmpty) {
      _toggleValidationAlert(
        context,
        const Text(
          'Empty password',
        ),
        const Text(
          'The password must not be empty!',
        ),
      );
    } else if (_passwordController.text.length < 8) {
      _toggleValidationAlert(
        context,
        const Text(
          'Short password',
        ),
        const Text(
          'The password must be at least 8 characters in length!',
        ),
      );
    } else if (RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])$')
        .hasMatch(_emailController.text)) {
      _toggleValidationAlert(
        context,
        const Text(
          'Password not secure enough',
        ),
        const Text(
          'The password must contain at least one lower case character, one upper case character, one digit, one special character!',
        ),
      );
    }
  }

  void _toggleValidationAlert(
      BuildContext context, Widget title, Widget content) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoFormDialog(
          title: title,
          content: content,
        );
      },
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
              placeholderText: 'Email',
              icon: const Icon(
                Icons.email,
              ),
              obscureText: false,
              textFieldController: _emailController,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 270,
            child: CupertinoTextFieldStyle(
              placeholderText: 'Password',
              icon: const Icon(
                Icons.password,
              ),
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
                  _navigateToRegister(context);
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
              onTap: () {
                _formFieldValidation(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
