import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_suffix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_dropdown.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';

class AddPetTab extends StatefulWidget {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _characteristicsController =
      TextEditingController();
  final TextEditingController _medicalDetailsController =
      TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _necessityController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();

  AddPetTab({
    super.key,
  });

  @override
  State<AddPetTab> createState() {
    return _AddPetTabState();
  }
}

class _AddPetTabState extends State<AddPetTab> {
  final CupertinoTextFieldPrefixIcon prefixIcon =
      const CupertinoTextFieldPrefixIcon(
    icon: Icon(
      Icons.pets,
    ),
  );

  final CupertinoTextFieldSuffixIcon suffixIcon =
      const CupertinoTextFieldSuffixIcon(
    icon: Icon(
      CupertinoIcons.arrow_down_square_fill,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoScrollbar(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'List pet for adoption',
              style: GoogleFonts.lobster(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldDropdown(
                    placeholderText: 'Category',
                    textFieldController: widget._categoryController,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    pickerValues: categoryValues,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 185,
                  child: CupertinoTextFieldDropdown(
                    placeholderText: 'Breed',
                    textFieldController: widget._breedController,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    pickerValues: catBreedValues,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
