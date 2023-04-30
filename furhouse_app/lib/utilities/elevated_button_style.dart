import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/utilities/constants.dart';

class ElevatedButtonStyle extends StatelessWidget {
  final String buttonText;

  const ElevatedButtonStyle({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBlueColor,
        shadowColor: darkBlueColor,
        textStyle: GoogleFonts.merriweather(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {},
      child: Text(
        buttonText,
      ),
    );
  }
}
