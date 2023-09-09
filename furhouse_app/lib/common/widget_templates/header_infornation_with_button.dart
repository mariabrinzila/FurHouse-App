import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';

class HeaderInformationWithButton extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final String text;
  final void Function() onPressed;

  const HeaderInformationWithButton({
    required this.containerHeight,
    required this.containerWidth,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: darkBlueColor,
        height: containerHeight,
        width: containerWidth,
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(
                  top: 1,
                ),
                onPressed: onPressed,
                icon: const Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
