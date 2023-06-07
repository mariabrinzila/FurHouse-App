import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/screens/pet/pet-page-theme.dart';
import 'package:furhouse_app/screens/pet/pet_page.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/models/petVM.dart';

class PetCardButton extends StatelessWidget {
  final PetVM petObject;
  final String petPhotoURL;

  const PetCardButton({
    super.key,
    required this.petObject,
    required this.petPhotoURL,
  });

  void _navigateToPetPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetPageTheme(
          childWidget: PetPage(
            petObject: petObject,
            petPhotoURL: petPhotoURL,
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
          SizedBox(
            width: 180,
            height: 100,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.network(
                petPhotoURL,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            petObject.name,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Icon(
            CupertinoIcons.circle_fill,
            size: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            petObject.breed,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
