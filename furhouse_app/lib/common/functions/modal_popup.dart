import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/picker_values.dart';

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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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
          child: const Text(
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

void _filterCriteriaModalPopup(BuildContext context, String option) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      if (option == "gender") {
        return _popupBuilder(context, 100, genderValues, option);
      }

      if (option == "category") {
        return _popupBuilder(context, 150, categoryValues, option);
      }

      if (option == "breed") {
        return _popupBuilder(context, 200, allBreedValues, option);
      }

      if (option == "details") {
        return _popupBuilder(context, 150, detailsValues, option);
      }

      return _popupBuilder(context, 100, priorityValues, option);
    },
  );
}

int currentItemIndex = 0;

Widget _popupBuilder(BuildContext context, double dropdownHeight,
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
              _onItemPick(context, selectedItemIndex);
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
        height: 5,
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
            "Choose criteria",
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

void _onItemPick(BuildContext context, selectedItemIndex) {
  currentItemIndex = selectedItemIndex;
}

/*List<Widget> _listToWidgetList(BuildContext context, List<String> options) {
  var length = options.length, i = 0;
  List<Widget> widgetList = [];

  for (i = 0; i < length; i++) {
    var option = CupertinoActionSheetAction(
      onPressed: () {
        Navigator.pop(context, options[i]);
      },
      child: Text(
        style: const TextStyle(
          color: darkBlueColor,
          fontWeight: FontWeight.w400,
        ),
        options[i],
      ),
    );

    widgetList.add(option);
  }

  return widgetList;
}*/
