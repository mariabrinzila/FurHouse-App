import 'package:flutter/cupertino.dart';

class CupertinoTextFieldStyle extends StatelessWidget {
  String placeholderText;
  bool obscureText;
  TextEditingController textFieldController;

  CupertinoTextFieldStyle({
    super.key,
    required this.placeholderText,
    required this.obscureText,
    required this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholderText,
      obscureText: obscureText,
      controller: textFieldController,
      /*onEditingComplete: () {
        print(textFieldController.value);
      },*/
    );
  }
}
