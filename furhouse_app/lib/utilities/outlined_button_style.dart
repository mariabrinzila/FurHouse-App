import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/utilities/constants.dart';

class OutlinedButtonStyle extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;

  const OutlinedButtonStyle({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: lightBlueColor,
        ),
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: GoogleFonts.merriweather(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
