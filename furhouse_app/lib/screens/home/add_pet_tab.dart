import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPetTab extends StatelessWidget {
  const AddPetTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoScrollbar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'List pet for adoption',
              style: GoogleFonts.lobster(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
