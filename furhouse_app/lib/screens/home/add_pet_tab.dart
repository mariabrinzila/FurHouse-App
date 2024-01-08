import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import 'package:furhouse_app/screens/pet/pet_page_theme.dart';
import 'package:furhouse_app/screens/pet/pet_page.dart';

import 'package:furhouse_app/common/constants/picker_values.dart';
import 'package:furhouse_app/common/constants/others.dart';

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

    // controller.addListener(() {}) <=> listen on any changes to the controller and do something whenever it does change
    categoryController.addListener(() {
      setState(() {
        _computeBreedPickerValues(categoryController.text, context);
      });
    });

    super.initState();
  }

  void _computeBreedPickerValues(String category, BuildContext context) {
    var translatedCat = _computePickerTranslation("cat", context);
    var translatedDog = _computePickerTranslation("dog", context);
    var translatedRabbit = _computePickerTranslation("rabbit", context);
    var translatedRodent = _computePickerTranslation("rodent", context);
    var translatedBird = _computePickerTranslation("bird", context);

    if (breedPickerValues != catBreedValues && category == translatedCat) {
      breedPickerValues = catBreedValues;
    }

    if (category == translatedDog) {
      breedPickerValues = dogBreedValues;
    }

    if (category == translatedRabbit) {
      breedPickerValues = rabbitBreedValues;
    }

    if (category == translatedRodent) {
      breedPickerValues = rodentBreedValues;
    }

    if (category == translatedBird) {
      breedPickerValues = birdBreedValues;
    }
  }

  String _computePickerTranslation(String value, BuildContext context) {
    var translation = "";

    switch (value) {
      case "cat":
        {
          translation = AppLocalizations.of(context)?.cat ?? "";
        }
        break;

      case "dog":
        {
          translation = AppLocalizations.of(context)?.dog ?? "";
        }
        break;

      case "rabbit":
        {
          translation = AppLocalizations.of(context)?.rabbit ?? "";
        }
        break;

      case "rodent":
        {
          translation = AppLocalizations.of(context)?.rodent ?? "";
        }
        break;

      case "bird":
        {
          translation = AppLocalizations.of(context)?.bird ?? "";
        }
        break;
    }

    return translation;
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
    var isEmailVerified = currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      actionDoneDialog(context,
          "Your email must be verified to add a pet! Go to Settings -> Account to verify your email.");

      return;
    }

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
      adoptedBy: null,
    );

    if (widget.currentPet != null) {
      final confirmed = await confirmActionDialog(context,
          "Are you sure you want to save the changes for ${pet.name}?");

      if (confirmed == "no") {
        return;
      }

      pet.id = widget.currentPet!.petId;
      pet.dateAdded = widget.currentPet!.dateAdded;

      final message =
          await Pets().update(pet, widget.currentPet!.name, widget.petPhotoURL);

      if (message == "Success") {
        if (notificationService != null) {
          await notificationService?.showLocalNotification(
            id: currentNotificationID,
            title: "Updated pet",
            body: "You have just updated ${pet.name}!",
            payload: "A pet has been updated",
          );

          currentNotificationID++;
        }

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
        if (notificationService != null) {
          await notificationService?.showLocalNotification(
            id: currentNotificationID,
            title: "Added pet",
            body: "You have just added ${pet.name}!",
            payload: "A new pet has been added",
          );

          currentNotificationID++;
        }

        nameController.clear();
        genderController.clear();
        categoryController.clear();
        breedController.clear();
        ageUnitController.clear();
        ageValueController.clear();
        locationController.clear();
        detailsController.clear();
        priorityController.clear();
        descriptionController.clear();
        photoController.clear();

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
              fromHomeTab: false,
              childWidget: PetPage(
                petObject: pet,
                petPhotoURL: petPhotoURL,
                fromSettings: false,
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
    var title = AppLocalizations.of(context)?.listPetForAdoption ?? "";
    var submitButtonText = AppLocalizations.of(context)?.addPet ?? "";

    if (widget.currentPet != null) {
      title = AppLocalizations.of(context)?.updatePetInformation ?? "";
      submitButtonText = AppLocalizations.of(context)?.editPet ?? "";
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
                      placeholderText:
                          AppLocalizations.of(context)?.petName ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.gender ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.category ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.breed ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.ageUnit ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.ageValue ?? "",
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
                  placeholderText:
                      AppLocalizations.of(context)?.petLocation ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.details ?? "",
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
                      placeholderText:
                          AppLocalizations.of(context)?.priority ?? "",
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
                      AppLocalizations.of(context)?.petDescription ?? "",
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
                  placeholderText: AppLocalizations.of(context)?.petPhoto ?? "",
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
