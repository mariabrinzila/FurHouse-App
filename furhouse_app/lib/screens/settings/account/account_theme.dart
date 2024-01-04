import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/constants/others.dart';
import 'package:furhouse_app/common/constants/colors.dart';

class AccountTheme extends StatelessWidget {
  final Widget childWidget;

  const AccountTheme({
    super.key,
    required this.childWidget,
  });

  void _onGoBack(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(
          selectedTabIndex: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
