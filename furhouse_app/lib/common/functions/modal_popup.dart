import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';

Future<String?> sortOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        "Choose sort option",
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
            "Name",
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
            "Age",
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
            "Date",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

void _sortOrderModalPopup(BuildContext context, String option) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        "Choose sort order",
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
            "Ascending",
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
            "Descending",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
          Navigator.pop(context, "cancel");
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Future<String?> filterOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        "Choose filter option",
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
            "Gender",
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
            "Category",
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
            "Breed",
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
            "Details",
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
            "Priority",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
          child: const Text(
            "Filter",
            style: TextStyle(
              color: Colors.black,
            ),
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
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
            ),
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
      title: const Text(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        "Choose search option",
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
            "Location",
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
            "Description",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
                child: const Text(
                  "Search Criteria",
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
          child: const Text(
            "Search",
            style: TextStyle(
              color: Colors.black,
            ),
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
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
            ),
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
      title: const Text(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        "Choose language",
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
            "English",
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
            "Romanian",
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
            "Spanish",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Future<String?> themeOptionModalPopup(BuildContext context) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        "Choose theme",
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
            "Dark",
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
            "Purple",
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
            "Blue",
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, "cancel");
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
