import 'package:flutter/material.dart';

import 'package:furhouse_app/main_display.dart';

import 'package:furhouse_app/services/authentication.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({
    super.key,
  });

  void _onLogout(BuildContext context) {
    Authentication().logout();

    _navigateToLanding(context);
  }

  void _navigateToLanding(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainDisplay(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // list tile-uri cu fiecare setare pe care o poti face (stilul cum ai la setarile din telefon / de la Instagram)
    // your account, languages, theme, admin settings, adopted pets

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              _onLogout(context);
            },
            child: const Text(
              "Logout",
            ),
          )
        ],
      ),
    );
  }
}
