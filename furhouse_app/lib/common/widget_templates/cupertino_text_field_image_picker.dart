import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_form_dialog.dart';

class CupertinoTextFieldImagePicker extends StatefulWidget {
  final String placeholderText;
  final TextEditingController photoController;

  const CupertinoTextFieldImagePicker({
    super.key,
    required this.placeholderText,
    required this.photoController,
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
          title: Text(
            AppLocalizations.of(context)?.imagePickerTitle ?? "",
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
              child: Text(
                AppLocalizations.of(context)?.gallery ?? "",
              ),
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
              child: Text(
                AppLocalizations.of(context)?.camera ?? "",
              ),
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
        widget.photoController.text = image.path;
      });
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoFormDialog(
            title: Text(
              AppLocalizations.of(context)?.imagePickerError ?? "",
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
      controller: widget.photoController,
      onTap: _onTapImageField,
    );
  }
}
