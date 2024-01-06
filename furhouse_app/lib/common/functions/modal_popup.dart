import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';

Future<String?> sortOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        AppLocalizations.of(context)?.sortOption ?? "",
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            _sortOrderModalPopup(context, "name");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.petName ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _sortOrderModalPopup(context, "age");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.ageValue ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _sortOrderModalPopup(context, "date");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.date ?? "",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: Text(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppLocalizations.of(context)?.cancel ?? "",
        ),
      ),
    ),
  );
}

void _sortOrderModalPopup(BuildContext context, String option) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        AppLocalizations.of(context)?.sortOrder ?? "",
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "cancel");
            Navigator.pop(context, "$option, ascending");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.ascending ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "cancel");
            Navigator.pop(context, "$option, descending");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.descending ?? "",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
          Navigator.pop(context, "cancel");
        },
        child: Text(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppLocalizations.of(context)?.cancel ?? "",
        ),
      ),
    ),
  );
}

Future<String?> filterOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        AppLocalizations.of(context)?.filterOption ?? "",
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            _filterCriteriaModalPopup(context, "gender");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.gender ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _filterCriteriaModalPopup(context, "category");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.category ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _filterCriteriaModalPopup(context, "breed");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.breed ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _filterCriteriaModalPopup(context, "details");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.details ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _filterCriteriaModalPopup(context, "priority");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.priority ?? "",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: Text(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppLocalizations.of(context)?.cancel ?? "",
        ),
      ),
    ),
  );
}

int currentItemIndex = 0;

void _filterCriteriaModalPopup(BuildContext context, String option) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return _computePopupBuilderValues(context, option);
    },
  );
}

Widget _computePopupBuilderValues(BuildContext context, String option) {
  List<String> pickerValues = priorityValues;
  double? dropdownHeight = 100;
  currentItemIndex = 0;

  genderValues = [
    "male",
    "female",
  ];

  categoryValues = [
    "cat",
    "dog",
    "rabbit",
    "rodent",
    "bird",
  ];

  ageUnitValues = [
    "days",
    "months",
    "years",
  ];

  detailsValues = [
    "vaccinated",
    "sterilized",
    "pastTrauma",
    "injured",
    "none",
  ];

  priorityValues = [
    "low",
    "medium",
    "high",
  ];

  _computeTranslationsForPickerValues(context);

  switch (option) {
    case "gender":
      pickerValues = genderValues;
      break;

    case "category":
      pickerValues = categoryValues;
      dropdownHeight = 150;
      break;

    case "breed":
      pickerValues = allBreedValues;
      dropdownHeight = 265;
      break;

    case "details":
      pickerValues = detailsValues;
      dropdownHeight = 150;
      break;
  }

  return _filterPopupBuilder(context, dropdownHeight, pickerValues, option);
}

String _computePickerTranslation(String value, BuildContext context) {
  var translation = "";

  switch (value) {
    case "male":
      {
        translation = AppLocalizations.of(context)?.male ?? "";
      }
      break;

    case "female":
      {
        translation = AppLocalizations.of(context)?.female ?? "";
      }
      break;

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

    case "vaccinated":
      {
        translation = AppLocalizations.of(context)?.vaccinated ?? "";
      }
      break;

    case "sterilized":
      {
        translation = AppLocalizations.of(context)?.sterilized ?? "";
      }
      break;

    case "pastTrauma":
      {
        translation = AppLocalizations.of(context)?.pastTrauma ?? "";
      }
      break;

    case "injured":
      {
        translation = AppLocalizations.of(context)?.injured ?? "";
      }
      break;

    case "none":
      {
        translation = AppLocalizations.of(context)?.none ?? "";
      }
      break;

    case "low":
      {
        translation = AppLocalizations.of(context)?.low ?? "";
      }
      break;

    case "medium":
      {
        translation = AppLocalizations.of(context)?.medium ?? "";
      }
      break;

    case "high":
      {
        translation = AppLocalizations.of(context)?.high ?? "";
      }
      break;

    case "name":
      {
        translation = AppLocalizations.of(context)?.petName ?? "";
      }
      break;

    case "age":
      {
        translation = AppLocalizations.of(context)?.ageValue ?? "";
      }
      break;

    case "date":
      {
        translation = AppLocalizations.of(context)?.date ?? "";
      }
      break;

    case "ascending":
      {
        translation = AppLocalizations.of(context)?.ascending ?? "";
      }
      break;

    case "descending":
      {
        translation = AppLocalizations.of(context)?.descending ?? "";
      }
      break;

    case "location":
      {
        translation = AppLocalizations.of(context)?.petLocation ?? "";
      }
      break;

    case "description":
      {
        translation = AppLocalizations.of(context)?.description ?? "";
      }
      break;
  }

  return translation;
}

void _computeTranslationsForPickerValues(BuildContext context) {
  List<String> translationsList = <String>[];
  String translation;

  // gender
  for (var gender in genderValues) {
    translation = _computePickerTranslation(gender, context);
    translationsList.add(translation);
  }

  genderValues.clear();
  genderValues.addAll(translationsList);

  // category
  translationsList.clear();

  for (var category in categoryValues) {
    translation = _computePickerTranslation(category, context);
    translationsList.add(translation);
  }

  categoryValues.clear();
  categoryValues.addAll(translationsList);

  // age unit
  translationsList.clear();

  for (var ageUnit in ageUnitValues) {
    translation = _computePickerTranslation(ageUnit, context);
    translationsList.add(translation);
  }

  ageUnitValues.clear();
  ageUnitValues.addAll(translationsList);

  // details
  translationsList.clear();

  for (var detail in detailsValues) {
    translation = _computePickerTranslation(detail, context);
    translationsList.add(translation);
  }

  detailsValues.clear();
  detailsValues.addAll(translationsList);

  // priority
  translationsList.clear();

  for (var priority in priorityValues) {
    translation = _computePickerTranslation(priority, context);
    translationsList.add(translation);
  }

  priorityValues.clear();
  priorityValues.addAll(translationsList);
}

Widget _filterPopupBuilder(BuildContext context, double dropdownHeight,
    List<String> pickerValues, String option) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        height: dropdownHeight,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            itemExtent: 32,
            scrollController: FixedExtentScrollController(
              initialItem: currentItemIndex,
            ),
            onSelectedItemChanged: (selectedItemIndex) {
              currentItemIndex = selectedItemIndex;
            },
            children: pickerValues.map((element) {
              return Center(
                child: Text(
                  element,
                ),
              );
            }).toList(),
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            var selectedItem = pickerValues[currentItemIndex];

            Navigator.pop(context, "cancel");
            Navigator.pop(context, "$option, $selectedItem");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.filter ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}

Future<String?> searchOptionModalPopup(
    BuildContext context, TextEditingController textEditingController) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        AppLocalizations.of(context)?.searchOption ?? "",
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            _searchCriteriaModalPopup(
                context, "Location", textEditingController);
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.petLocation ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            _searchCriteriaModalPopup(
                context, "Description", textEditingController);
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.description ?? "",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: Text(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppLocalizations.of(context)?.cancel ?? "",
        ),
      ),
    ),
  );
}

void _searchCriteriaModalPopup(BuildContext context, String option,
    TextEditingController textEditingController) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return _searchPopupBuilder(context, option, textEditingController);
    },
  );
}

Widget _searchPopupBuilder(BuildContext context, String option,
    TextEditingController textEditingController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 135,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  AppLocalizations.of(context)?.searchCriteria ?? "",
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: SizedBox(
                  height: 45,
                  child: CupertinoTextField(
                    placeholder: option,
                    controller: textEditingController,
                    prefix: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 5,
                      ),
                      child: Icon(
                        CupertinoIcons.search_circle_fill,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
            Navigator.pop(context,
                "${option.toLowerCase()}, ${textEditingController.text}");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.search ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}

Future<String?> languageOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        AppLocalizations.of(context)?.chooseLanguage ?? "",
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "en");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.en ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "ro");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.ro ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "es");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.es ?? "",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: Text(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppLocalizations.of(context)?.cancel ?? "",
        ),
      ),
    ),
  );
}

Future<String?> themeOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        AppLocalizations.of(context)?.theme ?? "",
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "dark");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.dark ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "purple");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.purple ?? "",
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, "blue");
          },
          child: Text(
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w400,
            ),
            AppLocalizations.of(context)?.blue ?? "",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: Text(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          AppLocalizations.of(context)?.cancel ?? "",
        ),
      ),
    ),
  );
}

Future<String?> changeEmailModalPopup(BuildContext context, String currentEmail,
    TextEditingController textEditingController) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (context) {
      return _changeEmailPopupBuilder(
          context, currentEmail, textEditingController);
    },
  );
}

Widget _changeEmailPopupBuilder(BuildContext context, String currentEmail,
    TextEditingController textEditingController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 135,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  AppLocalizations.of(context)?.changeYourEmail ?? "",
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: SizedBox(
                  height: 45,
                  child: CupertinoTextField(
                    placeholder: currentEmail,
                    controller: textEditingController,
                    prefix: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 5,
                      ),
                      child: Icon(
                        CupertinoIcons.envelope_fill,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.submitChange ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}

Future<String?> changePasswordModalPopup(BuildContext context,
    TextEditingController textEditingController, bool newPassword) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (context) {
      return _changePasswordPopupBuilder(
          context, textEditingController, newPassword);
    },
  );
}

Widget _changePasswordPopupBuilder(BuildContext context,
    TextEditingController textEditingController, bool newPassword) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 135,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  newPassword
                      ? AppLocalizations.of(context)?.changeYourPassword ?? ""
                      : AppLocalizations.of(context)
                              ?.reauthenticateWithPassword ??
                          "",
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: SizedBox(
                  height: 45,
                  child: CupertinoTextField(
                    obscureText: true,
                    placeholder: newPassword
                        ? AppLocalizations.of(context)?.newPassword ?? ""
                        : AppLocalizations.of(context)?.oldPassword ?? "",
                    controller: textEditingController,
                    prefix: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 5,
                      ),
                      child: Icon(
                        CupertinoIcons.padlock_solid,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.submitChange ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}

DateTime currentDate = DateTime(DateTime.now().year - 17);

Future<String?> changeBirthdayModalPopup(BuildContext context,
    TextEditingController textEditingController, String currentBirthday) async {
  var currentBirthdayDateTime = DateFormat.yMMMd().parse(currentBirthday);

  currentDate = currentBirthdayDateTime;

  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (context) {
      return _changeBirthdayModalPopupBuilder(context, textEditingController);
    },
  );
}

Widget _changeBirthdayModalPopupBuilder(
    BuildContext context, TextEditingController textEditingController) {
  // only accept users that are at least 18 years old
  var maximumDateTime = DateTime(DateTime.now().year - 17);

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        height: 170,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            backgroundColor: Colors.white,
            initialDateTime: currentDate,
            maximumDate: maximumDateTime,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime pickedDate) {
              _onDatePick(pickedDate, currentDate, textEditingController);
            },
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.submitChange ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}

void _onDatePick(DateTime pickedDate, DateTime currentDate,
    TextEditingController textEditingController) {
  var formattedDate = DateFormat.yMMMd().format(pickedDate);

  currentDate = pickedDate;
  textEditingController.text = formattedDate.toString();
}

Future<String?> changeFirstNameModalPopup(
    BuildContext context,
    TextEditingController textEditingController,
    String currentFirstName) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (context) {
      return _changeFirstNamePopupBuilder(
          context, textEditingController, currentFirstName);
    },
  );
}

Widget _changeFirstNamePopupBuilder(BuildContext context,
    TextEditingController textEditingController, String currentFirstName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 135,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  AppLocalizations.of(context)?.changeYourFirstName ?? "",
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: SizedBox(
                  height: 45,
                  child: CupertinoTextField(
                    placeholder: currentFirstName,
                    controller: textEditingController,
                    prefix: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 5,
                      ),
                      child: Icon(
                        CupertinoIcons.person_alt_circle_fill,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.submitChange ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}

Future<String?> changeLastNameModalPopup(BuildContext context,
    TextEditingController textEditingController, String currentLastName) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (context) {
      return _changeLastNamePopupBuilder(
          context, textEditingController, currentLastName);
    },
  );
}

Widget _changeLastNamePopupBuilder(BuildContext context,
    TextEditingController textEditingController, String currentLastName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 135,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 238, 241).withOpacity(
            0.9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(
                  AppLocalizations.of(context)?.changeYourLastName ?? "",
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              CupertinoActionSheetAction(
                onPressed: () {},
                child: SizedBox(
                  height: 45,
                  child: CupertinoTextField(
                    placeholder: currentLastName,
                    controller: textEditingController,
                    prefix: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 5,
                      ),
                      child: Icon(
                        CupertinoIcons.person_alt_circle,
                        color: darkBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.submitChange ?? "",
          ),
        ),
      ),
      const SizedBox(
        height: 7,
      ),
      Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(
              60,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            textStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, "cancel");
          },
          child: Text(
            style: const TextStyle(
              color: Colors.black,
            ),
            AppLocalizations.of(context)?.cancel ?? "",
          ),
        ),
      ),
    ],
  );
}
