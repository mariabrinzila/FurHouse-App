import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_suffix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_dropdown.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_style.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_location.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_image_picker.dart';
import 'package:furhouse_app/common/widget_templates/elevated_button_style.dart';
import 'package:furhouse_app/common/functions/form_validation.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';

import 'package:furhouse_app/models/petVM.dart';

import 'package:furhouse_app/services/authentication.dart';
import 'package:furhouse_app/services/pets.dart';

class AddPetTab extends StatefulWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageUnitController = TextEditingController();
  final TextEditingController _ageValueController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final XFile _petPhoto = XFile('');

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

  void _onAddPet(BuildContext context) async {
    if (nameValidation(widget._nameController.text, 'pet', context)) {
      return;
    }

    if (nonEmptyField(widget._categoryController.text, 'category', context)) {
      return;
    }

    if (nonEmptyField(widget._breedController.text, 'breed', context)) {
      return;
    }

    if (nonEmptyField(widget._ageUnitController.text, 'age unit', context)) {
      return;
    }

    if (nonEmptyField(widget._ageValueController.text, 'age value', context)) {
      return;
    }

    if (nonEmptyField(
        widget._locationController.text, 'pet location', context)) {
      return;
    }

    if (nonEmptyField(widget._detailsController.text, 'details', context)) {
      return;
    }

    if (nonEmptyField(widget._priorityController.text, 'priority', context)) {
      return;
    }

    if (nonEmptyField(widget._photoController.text, 'pet photo', context)) {
      return;
    }

    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? '';
    var photoName = widget._nameController.text + currentUserEmail;

    PetVM pet = PetVM(
      name: widget._nameController.text,
      category: widget._categoryController.text,
      breed: widget._breedController.text,
      ageUnit: widget._ageUnitController.text,
      ageValue: int.parse(widget._ageValueController.text),
      location: widget._locationController.text,
      details: widget._detailsController.text,
      priority: widget._priorityController.text,
      description: widget._descriptionController.text,
      photoName: photoName,
      photo: widget._petPhoto,
      userEmail: currentUserEmail,
    );

    final message = await Pets().add(pet);
    print(message);

    if (message == 'Success') {
      if (context.mounted) {
        _navigateToHome(context);
      }
    } else {
      if (context.mounted) {
        addPetExceptionHandler(context, message);
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 5,
        ),
        child: ConstrainedBox(
          // ConstrainedBox with these constraints makes the space that appears on the top because of SingleChildScrollView disappear
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldStyle(
                      placeholderText: 'Pet name',
                      icon: const Icon(
                        Icons.text_fields,
                      ),
                      obscureText: false,
                      textFieldController: widget._nameController,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldDropdown(
                      dropdownHeight: 150,
                      placeholderText: 'Category',
                      textFieldController: widget._categoryController,
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      pickerValues: categoryValues,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 360,
                child: CupertinoTextFieldDropdown(
                  dropdownHeight: 200,
                  placeholderText: 'Breed',
                  textFieldController: widget._breedController,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  pickerValues: breedPickerValues,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldDropdown(
                      dropdownHeight: 100,
                      placeholderText: 'Age unit',
                      textFieldController: widget._ageUnitController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          CupertinoIcons.time_solid,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      pickerValues: ageUnitValues,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldStyle(
                      placeholderText: 'Age value',
                      icon: const Icon(
                        CupertinoIcons.number,
                      ),
                      obscureText: false,
                      textFieldController: widget._ageValueController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 360,
                child: CupertinoTextFieldLocation(
                  placeholderText: 'Pet location',
                  textFieldController: widget._locationController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldDropdown(
                      dropdownHeight: 150,
                      placeholderText: 'Details',
                      textFieldController: widget._detailsController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          CupertinoIcons.pencil_outline,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      pickerValues: detailsValues,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldDropdown(
                      dropdownHeight: 100,
                      placeholderText: 'Priority',
                      textFieldController: widget._priorityController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          CupertinoIcons.exclamationmark_circle,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      pickerValues: priorityValues,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 330,
                height: 50,
                child: CupertinoTextFieldStyle(
                  placeholderText: 'Pet description',
                  icon: const Icon(
                    CupertinoIcons.text_justify,
                  ),
                  obscureText: false,
                  textFieldController: widget._descriptionController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: CupertinoTextFieldImagePicker(
                  placeholderText: 'Pet photo',
                  textFieldController: widget._photoController,
                  photo: widget._petPhoto,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 170,
                child: ElevatedButtonStyle(
                  buttonText: 'Add Pet',
                  onTap: () {
                    _onAddPet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
