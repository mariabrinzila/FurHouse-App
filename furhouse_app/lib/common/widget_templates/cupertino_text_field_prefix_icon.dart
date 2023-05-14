import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoTextFieldPrefixIcon extends StatelessWidget {
  final Icon icon;

  const CupertinoTextFieldPrefixIcon({
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
