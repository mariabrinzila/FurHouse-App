import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_form_dialog.dart';

class CupertinoTextFieldImagePicker extends StatefulWidget {
  final String placeholderText;
  final TextEditingController textFieldController;
  XFile photo;

  CupertinoTextFieldImagePicker({
    super.key,
    required this.placeholderText,
    required this.textFieldController,
    required this.photo,
  });

  @override
  State<CupertinoTextFieldImagePicker> createState() {
    return _CupertinoTextFieldImagePickerState();
  }
}

class _CupertinoTextFieldImagePickerState
    extends State<CupertinoTextFieldImagePicker> {
  void _onTapImageField() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Pick a photo of your pet',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: darkerBlueColor,
                textStyle: GoogleFonts.merriweather(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _getImage(ImageSource.gallery);

                Navigator.of(context).pop();
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: darkerBlueColor,
                textStyle: GoogleFonts.merriweather(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _getImage(ImageSource.camera);

                Navigator.of(context).pop();
              },
              child: const Text('Camera'),
            ),
          ],
        );
      },
    );
  }

  Future _getImage(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();

    try {
      var image = await imagePicker.pickImage(
        source: imageSource,
      );

      if (image == null) {
        return;
      }

      setState(() {
        widget.photo = image;
        widget.textFieldController.text = widget.photo.name;
      });
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoFormDialog(
            title: const Text(
              'Image picker error',
            ),
            content: Text(
              e.toString(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      readOnly: true,
      placeholder: widget.placeholderText,
      prefix: const CupertinoTextFieldPrefixIcon(
        icon: Icon(
          CupertinoIcons.photo,
        ),
      ),
      controller: widget.textFieldController,
      onTap: _onTapImageField,
    );
  }
}
