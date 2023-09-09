import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class PetInformationContainer extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String text;

  const PetInformationContainer({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: darkBlueColor,
        height: containerHeight,
        width: containerWidth,
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
