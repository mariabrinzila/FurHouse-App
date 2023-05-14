import 'package:flutter/material.dart';

class CupertinoTextFieldSuffixIcon extends StatelessWidget {
  final Icon icon;

  const CupertinoTextFieldSuffixIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: icon,
    );
  }
}
