import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/constants/others.dart';
import 'package:furhouse_app/common/constants/colors.dart';

class PetPageTheme extends StatelessWidget {
  final bool fromHomeTab;
  final Widget childWidget;

  const PetPageTheme({
    super.key,
    required this.fromHomeTab,
    required this.childWidget,
  });

  void _onGoBack(BuildContext context) {
    if (fromHomeTab) {
      Navigator.of(context).pop();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(
            selectedTabIndex: 0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("es"),
        Locale("ro"),
      ],
      locale: currentLocale.locale,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: darkBlueColor,
          leading: IconButton(
            onPressed: () {
              _onGoBack(context);
            },
            icon: const Icon(
              CupertinoIcons.arrow_left_square_fill,
            ),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/Logo.png",
            color: Colors.white,
            width: 250,
            height: 180,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lightBlueColor,
                lighterBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
