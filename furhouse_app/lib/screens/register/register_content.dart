import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/screens/login/login.dart';

import 'package:furhouse_app/utilities/cupertino_text_field_style.dart';
import 'package:furhouse_app/utilities/outlined_button_style.dart';
import 'package:furhouse_app/utilities/elevated_button_style.dart';

class RegisterContent extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterContent({super.key});

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
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
                  width: 170,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'First name',
                    obscureText: false,
                    textFieldController: _firstNameController,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 170,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Last Name',
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
                  width: 170,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Username',
                    obscureText: false,
                    textFieldController: _usernameController,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 170,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Birthday',
                    obscureText: false,
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
                  width: 170,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Password',
                    obscureText: true,
                    textFieldController: _passwordController,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 170,
                  child: CupertinoTextFieldStyle(
                    placeholderText: 'Confirm password',
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
                    navigateToLogin(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 170,
              child: ElevatedButtonStyle(
                buttonText: 'Sign Up',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
