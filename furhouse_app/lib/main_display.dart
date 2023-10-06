import 'package:flutter/material.dart';

import 'package:furhouse_app/main_theme.dart';
import 'package:furhouse_app/screens/landing/landing.dart';
import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/constants/picker_values.dart';

import 'package:furhouse_app/services/authentication.dart';
import 'package:furhouse_app/services/web_scraper.dart';

class MainDisplay extends StatelessWidget {
  Widget widgetToDisplay = const Landing();

  MainDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentUser = Authentication().getCurrentUser();

    if (currentUser != null) {
      widgetToDisplay = const Home();
    }

    return MainTheme(
      childWidget: widgetToDisplay,
    );
  }
}
