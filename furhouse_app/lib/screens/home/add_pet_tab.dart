import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import 'package:furhouse_app/screens/pet/pet_page_theme.dart';
import 'package:furhouse_app/screens/pet/pet_page.dart';

import 'package:furhouse_app/common/constants/picker_values.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_suffix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_dropdown.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_style.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_location.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_image_picker.dart';
import 'package:furhouse_app/common/widget_templates/elevated_button_style.dart';

import 'package:furhouse_app/common/functions/form_validation.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/models/pet_VM.dart';

import 'package:furhouse_app/services/authentication.dart';
import 'package:furhouse_app/services/pets.dart';

// ignore: must_be_immutable
class AddPetTab extends StatefulWidget {
  final PetVM? currentPet;
  final String? petPhotoURL;

  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _categoryController;
  late TextEditingController _breedController;
  late TextEditingController _ageUnitController;
  late TextEditingController _ageValueController;
  late TextEditingController _locationController;
  late TextEditingController _detailsController;
  late TextEditingController _priorityController;
  late TextEditingController _descriptionController;
  late TextEditingController _photoController;

  AddPetTab({
    super.key,
    this.currentPet,
    this.petPhotoURL,
  }) {
    if (currentPet != null) {
      _nameController = TextEditingController(
        text: currentPet!.name,
      );
      _genderController = TextEditingController(
        text: currentPet!.gender,
      );
      _categoryController = TextEditingController(
        text: currentPet!.category,
      );
      _breedController = TextEditingController(
        text: currentPet!.breed,
      );
      _ageUnitController = TextEditingController(
        text: currentPet!.ageUnit,
      );
      _ageValueController = TextEditingController(
        text: currentPet!.ageValue.toString(),
      );
      _locationController = TextEditingController(
        text: currentPet!.location,
      );
      _detailsController = TextEditingController(
        text: currentPet!.details,
      );
      _priorityController = TextEditingController(
        text: currentPet!.priority,
      );
      _descriptionController = TextEditingController(
        text: currentPet!.description,
      );
      _photoController = TextEditingController(
        text: petPhotoURL,
      );
    } else {
      _nameController = TextEditingController();
      _genderController = TextEditingController();
      _categoryController = TextEditingController();
      _breedController = TextEditingController();
      _ageUnitController = TextEditingController();
      _ageValueController = TextEditingController();
      _locationController = TextEditingController();
      _detailsController = TextEditingController();
      _priorityController = TextEditingController();
      _descriptionController = TextEditingController();
      _photoController = TextEditingController();
    }
  }

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

    if (nonEmptyField(widget._genderController.text, 'gender', context)) {
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

    PetVM pet = PetVM(
      name: widget._nameController.text,
      gender: widget._genderController.text,
      category: widget._categoryController.text,
      breed: widget._breedController.text,
      ageUnit: widget._ageUnitController.text,
      ageValue: int.parse(widget._ageValueController.text),
      location: widget._locationController.text,
      details: widget._detailsController.text,
      priority: widget._priorityController.text,
      description: widget._descriptionController.text,
      userEmail: currentUserEmail,
      photoPath: widget._photoController.text,
      dateAdded: DateTime.now().toString(),
      adopted: false,
    );

    if (widget.currentPet != null) {
      final confirmed = await confirmActionDialog(context,
          "Are you sure you want to save the changes for ${pet.name}?");

      if (confirmed == "no") {
        return;
      }

      pet.id = widget.currentPet!.petId;

      final message = await Pets().update(pet);

      if (message == "Success") {
        if (context.mounted) {
          _navigateToPetPage(context, pet);
        }
      } else {
        if (context.mounted) {
          addPetExceptionHandler(context, message);
        }
      }
    } else {
      final message = await Pets().insert(pet);

      if (message == 'Success') {
        if (context.mounted) {
          _navigateToPetPage(context, pet);
        }
      } else {
        if (context.mounted) {
          addPetExceptionHandler(context, message);
        }
      }
    }
  }

  void _navigateToPetPage(BuildContext context, PetVM pet) async {
    try {
      var petPhotoURL =
          await Pets().getPetPhoneDownloadURL(pet.userEmail, pet.name);

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetPageTheme(
              childWidget: PetPage(
                petObject: pet,
                petPhotoURL: petPhotoURL,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      otherExceptionsHandler(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var submitButtonText = "Add pet";

    if (widget.currentPet != null) {
      submitButtonText = "Edit pet";
    }

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
                      dropdownHeight: 100,
                      placeholderText: 'Gender',
                      textFieldController: widget._genderController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          Icons.female_rounded,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      pickerValues: genderValues,
                    ),
                  ),
                ],
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
                      placeholderText: 'Category',
                      textFieldController: widget._categoryController,
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      pickerValues: categoryValues,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldDropdown(
                      dropdownHeight: 150,
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
                  placeholderText:
                      'Pet description (character, house trained, special needs, good with other pets etc.)',
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
                  photoController: widget._photoController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 170,
                child: ElevatedButtonStyle(
                  buttonText: submitButtonText,
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

  /*@override
  void dispose() {
    widget._nameController.dispose();
    widget._genderController.dispose();
    widget._categoryController.dispose();
    widget._breedController.dispose();
    widget._ageUnitController.dispose();
    widget._ageValueController.dispose();
    widget._locationController.dispose();
    widget._detailsController.dispose();
    widget._priorityController.dispose();
    widget._descriptionController.dispose();
    widget._photoController.dispose();

    super.dispose();
  }*/
}
