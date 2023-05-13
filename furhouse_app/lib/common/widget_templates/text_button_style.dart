import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class TextButtonStyle extends StatelessWidget {
  final String buttonText;

  const TextButtonStyle({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        buttonText,
        style: GoogleFonts.merriweather(
          color: darkerBlueColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
