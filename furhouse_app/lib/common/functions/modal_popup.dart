import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

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
            _sortOrderModalPopup(context, "priority");
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

List<Widget> _listToWidgetList(BuildContext context, List<String> options) {
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
}
