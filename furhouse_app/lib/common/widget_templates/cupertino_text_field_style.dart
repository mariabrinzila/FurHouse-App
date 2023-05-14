import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';

class CupertinoTextFieldStyle extends StatelessWidget {
  final String placeholderText;
  final bool obscureText;
  final TextEditingController textFieldController;
  final Icon icon;

  const CupertinoTextFieldStyle({
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
      prefix: CupertinoTextFieldPrefixIcon(
        icon: icon,
      ),
      obscureText: obscureText,
      controller: textFieldController,
    );
  }
}
