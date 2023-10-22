import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import 'package:furhouse_app/screens/pet/pet_page_theme.dart';
import 'package:furhouse_app/screens/pet/pet_page.dart';

import 'package:furhouse_app/common/constants/picker_values.dart';

import 'package:furhouse_app/common/functions/form_validation.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_suffix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_dropdown.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_style.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_location.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_image_picker.dart';
import 'package:furhouse_app/common/widget_templates/elevated_button_style.dart';

import 'package:furhouse_app/models/pet_VM.dart';

import 'package:furhouse_app/services/authentication.dart';
import 'package:furhouse_app/services/pets.dart';

// TO DO: clear text editing controllers when the form is submitted (when you go back, they should be empty)
class AddPetTab extends StatefulWidget {
  final PetVM? currentPet;
  final String? petPhotoURL;

  const AddPetTab({
    super.key,
    this.currentPet,
    this.petPhotoURL,
  });

  @override
  State<AddPetTab> createState() {
    return _AddPetTabState();
  }
}

class _AddPetTabState extends State<AddPetTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController ageUnitController = TextEditingController();
  TextEditingController ageValueController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photoController = TextEditingController();

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
    categoryController.addListener(() {
      setState(() {
        _computeBreedPickerValues(categoryController.text);
      });
    });

    if (widget.currentPet != null) {
      nameController = TextEditingController(
        text: widget.currentPet!.name,
      );
      genderController = TextEditingController(
        text: widget.currentPet!.gender,
      );
      categoryController = TextEditingController(
        text: widget.currentPet!.category,
      );
      breedController = TextEditingController(
        text: widget.currentPet!.breed,
      );
      ageUnitController = TextEditingController(
        text: widget.currentPet!.ageUnit,
      );
      ageValueController = TextEditingController(
        text: widget.currentPet!.ageValue.toString(),
      );
      locationController = TextEditingController(
        text: widget.currentPet!.location,
      );
      detailsController = TextEditingController(
        text: widget.currentPet!.details,
      );
      priorityController = TextEditingController(
        text: widget.currentPet!.priority,
      );
      descriptionController = TextEditingController(
        text: widget.currentPet!.description,
      );
      photoController = TextEditingController(
        text: widget.petPhotoURL,
      );
    }

    super.initState();
  }

  void _computeBreedPickerValues(String category) {
    if (breedPickerValues != catBreedValues && category == "Cat") {
      breedPickerValues = catBreedValues;
    }

    if (category == "Dog") {
      breedPickerValues = dogBreedValues;
    }

    if (category == "Rabbit") {
      breedPickerValues = rabbitBreedValues;
    }

    if (category == "Rodent") {
      breedPickerValues = rodentBreedValues;
    }

    if (category == "Bird") {
      breedPickerValues = birdBreedValues;
    }
  }

  void _onSubmitPet(BuildContext context) async {
    if (nameValidation(nameController.text, "pet", context)) {
      return;
    }

    if (nonEmptyField(genderController.text, "gender", context)) {
      return;
    }

    if (nonEmptyField(categoryController.text, "category", context)) {
      return;
    }

    if (nonEmptyField(breedController.text, "breed", context)) {
      return;
    }

    if (nonEmptyField(ageUnitController.text, "age unit", context)) {
      return;
    }

    if (nonEmptyField(ageValueController.text, "age value", context)) {
      return;
    }

    if (nonEmptyField(locationController.text, "pet location", context)) {
      return;
    }

    if (nonEmptyField(detailsController.text, "details", context)) {
      return;
    }

    if (nonEmptyField(priorityController.text, "priority", context)) {
      return;
    }

    if (nonEmptyField(photoController.text, "pet photo", context)) {
      return;
    }

    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? "";

    PetVM pet = PetVM(
      name: nameController.text,
      gender: genderController.text,
      category: categoryController.text,
      breed: breedController.text,
      ageUnit: ageUnitController.text,
      ageValue: int.parse(ageValueController.text),
      location: locationController.text,
      details: detailsController.text,
      priority: priorityController.text,
      description: descriptionController.text,
      userEmail: currentUserEmail,
      photoPath: photoController.text,
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

      final message =
          await Pets().update(pet, widget.currentPet!.name, widget.petPhotoURL);

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

      if (message == "Success") {
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
          await Pets().getPetPhotoDownloadURL(pet.userEmail, pet.name);

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
    var title = "List pet for adoption";
    var submitButtonText = "Add pet";

    if (widget.currentPet != null) {
      title = "Update pet information";
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
                title,
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
                      placeholderText: "Pet name",
                      icon: const Icon(
                        Icons.text_fields,
                      ),
                      obscureText: false,
                      textFieldController: nameController,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldDropdown(
                      dropdownHeight: 100,
                      placeholderText: "Gender",
                      textFieldController: genderController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          Icons.female_rounded,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      defaultValue: genderController.text,
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
                      placeholderText: "Category",
                      textFieldController: categoryController,
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      defaultValue: categoryController.text,
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
                      placeholderText: "Breed",
                      textFieldController: breedController,
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      defaultValue: breedController.text,
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
                      placeholderText: "Age unit",
                      textFieldController: ageUnitController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          CupertinoIcons.time_solid,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      defaultValue: ageUnitController.text,
                      pickerValues: ageUnitValues,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 175,
                    child: CupertinoTextFieldStyle(
                      placeholderText: "Age value",
                      icon: const Icon(
                        CupertinoIcons.number,
                      ),
                      obscureText: false,
                      textFieldController: ageValueController,
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
                  placeholderText: "Pet location",
                  textFieldController: locationController,
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
                      placeholderText: "Details",
                      textFieldController: detailsController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          CupertinoIcons.pencil_outline,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      defaultValue: detailsController.text,
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
                      placeholderText: "Priority",
                      textFieldController: priorityController,
                      prefixIcon: const CupertinoTextFieldPrefixIcon(
                        icon: Icon(
                          CupertinoIcons.exclamationmark_circle,
                        ),
                      ),
                      suffixIcon: suffixIcon,
                      defaultValue: priorityController.text,
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
                      "Pet description (character, house trained, special needs, good with other pets etc.)",
                  icon: const Icon(
                    CupertinoIcons.text_justify,
                  ),
                  obscureText: false,
                  textFieldController: descriptionController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: CupertinoTextFieldImagePicker(
                  placeholderText: "Pet photo",
                  photoController: photoController,
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
                    _onSubmitPet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    categoryController.dispose();
    breedController.dispose();
    ageUnitController.dispose();
    ageValueController.dispose();
    locationController.dispose();
    detailsController.dispose();
    priorityController.dispose();
    descriptionController.dispose();
    photoController.dispose();

    super.dispose();
  }
}
