import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:furhouse_app/common/cupertino_text_field_icon.dart';

class CupertinoTextFieldDatePicker extends StatefulWidget {
  TextEditingController textFieldController;

  CupertinoTextFieldDatePicker({
    super.key,
    required this.textFieldController,
  });

  @override
  State<StatefulWidget> createState() {
    return _CupertinoTextFieldDatePickerState();
  }
}

class _CupertinoTextFieldDatePickerState
    extends State<CupertinoTextFieldDatePicker> {
  @override
  void initState() {
    super.initState();

    widget.textFieldController.text = "";
  }

  void _toggleDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(
            top: 470,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              backgroundColor: Colors.white,
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime pickedDate) {
                var formattedDate = DateFormat.yMMMd().format(pickedDate);

                setState(() {
                  widget.textFieldController.text = formattedDate.toString();
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      readOnly: true,
      placeholder: "Birthday",
      prefix: const CupertinoTextFieldIcon(
        icon: Icon(
          Icons.calendar_today_rounded,
        ),
      ),
      controller: widget.textFieldController,
      onTap: () {
        _toggleDatePicker(context);
      },
    );
  }
}
