import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class ElevatedButtonStyle extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;

  const ElevatedButtonStyle({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkerBlueColor,
        shadowColor: darkerBlueColor,
        textStyle: GoogleFonts.merriweather(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
      ),
    );
  }
}
