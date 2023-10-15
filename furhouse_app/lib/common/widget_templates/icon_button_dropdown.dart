import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class IconButtonDropdown extends StatefulWidget {
  final double dropdownHeight;
  final Icon icon;
  final Widget label;
  final List<String> pickerValues;
  String pickedValue;

  IconButtonDropdown({
    super.key,
    required this.dropdownHeight,
    required this.icon,
    required this.label,
    required this.pickerValues,
    required this.pickedValue,
  });

  @override
  State<IconButtonDropdown> createState() {
    return _IconButtonDropdownState();
  }
}

class _IconButtonDropdownState extends State<IconButtonDropdown> {
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
      widget.pickedValue = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _togglePicker(context);
      },
      icon: widget.icon,
      label: widget.label,
    );
  }
}
