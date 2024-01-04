import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class TabElevatedButtonStyle extends StatelessWidget {
  final Color buttonColor;
  final Icon prefixIcon;
  final String buttonText;
  final void Function() onTap;

  const TabElevatedButtonStyle({
    super.key,
    required this.buttonColor,
    required this.prefixIcon,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shadowColor: darkerBlueColor,
          textStyle: GoogleFonts.merriweather(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon,
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonText,
            ),
          ],
        ),
      ),
    );
  }
}
