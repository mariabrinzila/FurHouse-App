import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_suffix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_dropdown.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';

// TO DO: when the category changes, the previous breed selection should be deleted

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

  var breedPickerValues = catBreedValues;

  @override
  void initState() {
    // controller.addListener(() {}) <=> listen on any changes to the controller and do something whenever it does change
    widget._categoryController.addListener(() {
      setState(() {
        _computeBreedPickerValues(widget._categoryController.text);
      });
    });

    super.initState();
  }

  void _computeBreedPickerValues(String category) {
    if (breedPickerValues != catBreedValues && category == 'Cat') {
      breedPickerValues = catBreedValues;
    }

    if (category == 'Dog') {
      breedPickerValues = dogBreedValues;
    }

    if (category == 'Rabbit') {
      breedPickerValues = rabbitBreedValues;
    }

    if (category == 'Rodent') {
      breedPickerValues = rodentBreedValues;
    }

    if (category == 'Bird') {
      breedPickerValues = birdBreedValues;
    }
  }

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
                    pickerValues: breedPickerValues,
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
