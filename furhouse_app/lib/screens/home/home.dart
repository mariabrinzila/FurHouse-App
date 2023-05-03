import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/screens/landing/landing.dart';

class Home extends StatelessWidget {
  final String userEmail;

  const Home({
    super.key,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                darkBlueColor,
                lightBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userEmail,
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
                    FirebaseAuth.instance.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Landing(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
