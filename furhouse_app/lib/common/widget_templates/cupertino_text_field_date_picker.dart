import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';

class CupertinoTextFieldDatePicker extends StatefulWidget {
  final TextEditingController textFieldController;

  const CupertinoTextFieldDatePicker({
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
  DateTime currentDate = DateTime(DateTime.now().year - 17);

  @override
  void initState() {
    super.initState();

    widget.textFieldController.text = '';
  }

  void _toggleDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return _popupBuilder(context);
      },
    );
  }

  Widget _popupBuilder(BuildContext context) {
    // only accept users that are at least 18 years old
    var maximumDateTime = DateTime(DateTime.now().year - 17);

    return Container(
      margin: const EdgeInsets.only(
        top: 470,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          initialDateTime: currentDate,
          maximumDate: maximumDateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (DateTime pickedDate) {
            _onDatePick(pickedDate);
          },
        ),
      ),
    );
  }

  void _onDatePick(DateTime pickedDate) {
    var formattedDate = DateFormat.yMMMd().format(pickedDate);

    setState(() {
      currentDate = pickedDate;
      widget.textFieldController.text = formattedDate.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      readOnly: true,
      placeholder: "Birthday",
      prefix: const CupertinoTextFieldPrefixIcon(
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
