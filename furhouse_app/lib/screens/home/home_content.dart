import 'package:flutter/material.dart';

import 'package:furhouse_app/main_display.dart';

import 'package:furhouse_app/services/authentication.dart';

class HomeContent extends StatefulWidget {
  final String userEmail;

  const HomeContent({
    super.key,
    required this.userEmail,
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
          Text(
            widget.userEmail,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
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
