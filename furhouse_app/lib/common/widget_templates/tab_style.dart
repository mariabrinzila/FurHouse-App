import 'package:flutter/material.dart';

class TabStyle extends StatelessWidget {
  final IconData iconData;

  const TabStyle({
    super.key,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        iconData,
      ),
    );
  }
}
