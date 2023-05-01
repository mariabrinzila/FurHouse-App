import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTextFieldIcon extends StatelessWidget {
  final Icon icon;

  const CupertinoTextFieldIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: icon,
    );
  }
}
