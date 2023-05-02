import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CupertinoFormDialog extends StatelessWidget {
  final Widget title;
  final Widget content;

  const CupertinoFormDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: darkBlueColor,
            textStyle: GoogleFonts.merriweather(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            // close the dialog once the button is pressed
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
