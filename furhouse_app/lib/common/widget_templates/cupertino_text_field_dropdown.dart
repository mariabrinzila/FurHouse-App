import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/widget_templates/cupertino_text_field_suffix_icon.dart';

class CupertinoTextFieldDropdown extends StatefulWidget {
  final double dropdownHeight;
  final String placeholderText;
  final TextEditingController textFieldController;
  final CupertinoTextFieldPrefixIcon prefixIcon;
  final CupertinoTextFieldSuffixIcon suffixIcon;
  final String defaultValue;
  final List<String> pickerValues;

  const CupertinoTextFieldDropdown({
    super.key,
    required this.dropdownHeight,
    required this.placeholderText,
    required this.textFieldController,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.defaultValue,
    required this.pickerValues,
  });

  @override
  State<CupertinoTextFieldDropdown> createState() {
    return _CupertinoTextFieldDropdownState();
  }
}

class _CupertinoTextFieldDropdownState
    extends State<CupertinoTextFieldDropdown> {
  int currentItemIndex = 0;

  void _togglePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return _popupBuilder(context);
      },
    );
  }

  Widget _popupBuilder(BuildContext context) {
    return Container(
      height: widget.dropdownHeight,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: CupertinoPicker(
          itemExtent: 32,
          scrollController: FixedExtentScrollController(
            initialItem: currentItemIndex,
          ),
          onSelectedItemChanged: (selectedItemIndex) {
            _onItemPick(selectedItemIndex);
          },
          children: widget.pickerValues.map((element) {
            return Center(
              child: Text(
                element,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onItemPick(int selectedItemIndex) {
    var selectedItem = widget.pickerValues[selectedItemIndex];

    setState(() {
      currentItemIndex = selectedItemIndex;
      widget.textFieldController.text = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.defaultValue.isNotEmpty) {
      var index = widget.pickerValues.indexOf(widget.defaultValue);

      currentItemIndex = index != -1 ? index : 0;
    }

    return CupertinoTextField(
      readOnly: true,
      placeholder: widget.placeholderText,
      prefix: widget.prefixIcon,
      suffix: widget.suffixIcon,
      controller: widget.textFieldController,
      onTap: () {
        _togglePicker(context);
      },
    );
  }
}
