import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

Future<String?> confirmActionDialog(BuildContext context, String title) async {
  return await showCupertinoDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: darkerBlueColor,
              textStyle: GoogleFonts.merriweather(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop("yes");
            },
            child: const Text("Yes"),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: darkerBlueColor,
              textStyle: GoogleFonts.merriweather(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop("no");
            },
            child: const Text("Nevermind"),
          ),
        ],
      );
    },
  );
}
