import 'package:flutter/material.dart';

import 'package:furhouse_app/main_theme.dart';
import 'package:furhouse_app/screens/landing/landing.dart';
import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/services/authentication.dart';

// ignore: must_be_immutable
class MainDisplay extends StatelessWidget {
  Widget widgetToDisplay = const Landing();

  MainDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentUser = Authentication().getCurrentUser();

    if (currentUser != null) {
      widgetToDisplay = const Home(
        selectedTabIndex: 0,
      );
    }

    return MainTheme(
      childWidget: widgetToDisplay,
    );
  }
}
