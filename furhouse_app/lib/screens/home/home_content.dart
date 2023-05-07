import 'package:flutter/material.dart';

import 'package:furhouse_app/main_display.dart';

import 'package:furhouse_app/services/authentication.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    super.key,
  });

  @override
  State<HomeContent> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<HomeContent> {
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            child: const Text(
              'Logout',
            ),
            onPressed: () {
              _onLogout(context);
            },
          )
        ],
      ),
    );
  }
}
