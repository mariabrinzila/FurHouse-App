import 'package:flutter/material.dart';

import 'package:furhouse_app/main_theme.dart';
import 'package:furhouse_app/screens/home/home_content.dart';

class Home extends StatelessWidget {
  final String userEmail;

  const Home({
    super.key,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      childWidget: HomeContent(
        userEmail: userEmail,
      ),
    );
  }
}
