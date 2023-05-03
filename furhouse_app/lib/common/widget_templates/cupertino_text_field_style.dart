import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_icon.dart';

class CupertinoTextFieldStyle extends StatelessWidget {
  String placeholderText;
  bool obscureText;
  TextEditingController textFieldController;
  Icon icon;

  CupertinoTextFieldStyle({
    super.key,
    required this.placeholderText,
    required this.icon,
    required this.obscureText,
    required this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholderText,
      prefix: CupertinoTextFieldIcon(
        icon: icon,
      ),
      obscureText: obscureText,
      controller: textFieldController,
    );
  }
}
