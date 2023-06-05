import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/models/petVM.dart';

class PetCardButton extends StatelessWidget {
  //final PetVM petObject;
  //final String petPhotoURL;

  const PetCardButton({
    super.key,
    //required this.petObject,
    //required this.petPhotoURL,
  });

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
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 100,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset('assets/images/cat.jpg'),
              /*Image.network(
                petPhotoURL,
              ),*/
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Pet name',
            style: TextStyle(
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
          const Text(
            'Alaskan Klee Kai',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
