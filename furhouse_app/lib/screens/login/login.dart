import 'package:flutter/material.dart';

import 'package:furhouse_app/main_theme.dart';
import 'package:furhouse_app/screens/login/login_content.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      childWidget: LoginContent(),
    );
  }
}
