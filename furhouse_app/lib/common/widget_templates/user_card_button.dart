import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furhouse_app/screens/settings/user_page/user_page.dart';
import 'package:furhouse_app/screens/settings/user_page/user_page_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/models/user_VM.dart';

class UserCardButton extends StatelessWidget {
  final UserVM user;

  const UserCardButton({
    super.key,
    required this.user,
  });

  void _navigateToPetPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserPageTheme(
          childWidget: UserPage(
            currentUser: user,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBlueColor,
        shadowColor: Colors.black,
        elevation: 10,
        textStyle: GoogleFonts.merriweather(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        _navigateToPetPage(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${user.lastName} ${user.firstName}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Icon(
            CupertinoIcons.circle_fill,
            size: 10,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
