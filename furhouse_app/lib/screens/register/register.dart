import 'package:flutter/material.dart';

import 'package:furhouse_app/main_theme.dart';
import 'package:furhouse_app/screens/register/register_content.dart';

class Register extends StatelessWidget {
  const Register({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      childWidget: RegisterContent(),
    );
  }
}
