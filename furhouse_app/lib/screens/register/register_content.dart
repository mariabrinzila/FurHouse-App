import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/screens/login/login.dart';
import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/models/userVM.dart';

import 'package:furhouse_app/services/authentication.dart';

import 'package:furhouse_app/common/functions/form_validation.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_style.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_date_picker.dart';
import 'package:furhouse_app/common/widget_templates/outlined_button_style.dart';
import 'package:furhouse_app/common/widget_templates/elevated_button_style.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';

class RegisterContent extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterContent({super.key});

  void _onRegister(BuildContext context) async {
    if (nameValidation(_firstNameController.text, 'first', context)) {
      return;
    }

    if (nameValidation(_lastNameController.text, 'last', context)) {
      return;
    }

    if (emailValidation(_emailController.text, context)) {
      return;
    }

    if (nonEmptyField(_birthdayController.text, 'birthday', context)) {
      return;
    }

    if (passwordValidation(_passwordController.text, context)) {
      return;
    }

    if (confirmPasswordValidation(
        _passwordController.text, _confirmPasswordController.text, context)) {
      return;
    }

    UserVM user = UserVM(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      birthday: _birthdayController.text,
      password: _passwordController.text,
    );

    final message = await Authentication().register(user);

    if (message == 'Success') {
      if (context.mounted) {
        _navigateToHome(context);
      }
    } else {
      if (context.mounted) {
        registerExceptionHandler(context, message);
      }
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: GoogleFonts.lobster(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'First name',
                    icon: const Icon(
                      Icons.person,
                    ),
                    obscureText: false,
                    textFieldController: _firstNameController,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Last Name',
                    icon: const Icon(
                      Icons.person_outline,
                    ),
                    obscureText: false,
                    textFieldController: _lastNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Email',
                    icon: const Icon(
                      Icons.email_outlined,
                    ),
                    obscureText: false,
                    textFieldController: _emailController,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldDatePicker(
                    textFieldController: _birthdayController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Password',
                    icon: const Icon(
                      Icons.password_rounded,
                    ),
                    obscureText: true,
                    textFieldController: _passwordController,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Confirm password',
                    icon: const Icon(
                      Icons.password_rounded,
                    ),
                    obscureText: true,
                    textFieldController: _confirmPasswordController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                OutlinedButtonStyle(
                  buttonText: 'Login',
                  onTap: () {
                    _navigateToLogin(context);
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
                buttonText: 'Sign Up',
                onTap: () {
                  _onRegister(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
