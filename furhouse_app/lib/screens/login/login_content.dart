import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/screens/register/register.dart';
import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/functions/modal_popup.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_style.dart';
import 'package:furhouse_app/common/widget_templates/outlined_button_style.dart';
import 'package:furhouse_app/common/widget_templates/elevated_button_style.dart';

import 'package:furhouse_app/services/users.dart';

class LoginContent extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginContent({
    super.key,
  });

  void _onForgottenPassword(BuildContext context) async {
    var userEmail = await submitEmailModalPopup(context, _emailController);

    _emailController.clear();

    if (userEmail == null || userEmail == "cancel") return;

    var resetPasswordMessage = await Users().resetPassword(userEmail);

    if (resetPasswordMessage != "Success") {
      if (context.mounted) {
        otherExceptionsHandler(context, resetPasswordMessage);
      }
    } else {
      if (context.mounted) {
        actionDoneDialog(
            context, "An email for resetting your password has been sent!");
      }
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );
  }

  void _onLogin(BuildContext context) async {
    final message = await Users().login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (message == "Success") {
      if (context.mounted) {
        _navigateToHome(context);
      }
    } else {
      if (context.mounted) {
        loginExceptionHandler(context, message);
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(
          selectedTabIndex: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          // MediaQuery.of(context).viewInsets.bottom <=> the height of the keyboard
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
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
                placeholderText: "Email",
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
                placeholderText: "Password",
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
              onPressed: () {
                _onForgottenPassword(context);
              },
              child: Text(
                "Forgot password?",
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
                  buttonText: "Register",
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
                buttonText: "Sign In",
                onTap: () {
                  _onLogin(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
