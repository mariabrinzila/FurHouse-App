import 'package:flutter/material.dart';

class TabStyle extends StatelessWidget {
  final IconData iconData;
  final String tabLabel;

  const TabStyle({
    super.key,
    required this.iconData,
    required this.tabLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        iconData,
      ),
      text: tabLabel,
    );
  }
}
