import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class SettingsListTile extends StatelessWidget {
  final void Function() onTap;
  final String tileTitle;
  final Icon leadingIcon;
  final Icon? trailingIcon;

  const SettingsListTile({
    super.key,
    required this.onTap,
    required this.tileTitle,
    required this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: ListTile(
        tileColor: darkBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        onTap: onTap,
        leading: leadingIcon,
        trailing: trailingIcon,
        title: Text(
          tileTitle,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
