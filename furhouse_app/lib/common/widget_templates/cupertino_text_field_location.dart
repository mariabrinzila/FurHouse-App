import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_text_field_prefix_icon.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';

import 'package:furhouse_app/services/location.dart';

class CupertinoTextFieldLocation extends StatefulWidget {
  final String placeholderText;
  final TextEditingController textFieldController;

  const CupertinoTextFieldLocation({
    super.key,
    required this.placeholderText,
    required this.textFieldController,
  });

  @override
  State<CupertinoTextFieldLocation> createState() {
    return _CupertinoTextFieldLocationState();
  }
}

class _CupertinoTextFieldLocationState
    extends State<CupertinoTextFieldLocation> {
  void _onTapLocationField() async {
    var locationPermission = await Location().toggleLocationPermission();

    if (locationPermission == 'permitted') {
      var location = await Location().getLocation();
      print(location);

      if (location.contains('error:')) {
        if (context.mounted) {
          locationServicesExceptionHandler(context, location.substring(6));
        }
      } else {
        setState(() {
          widget.textFieldController.text = location;
        });
      }
    } else {
      if (context.mounted) {
        locationServicesExceptionHandler(context, locationPermission);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      readOnly: true,
      placeholder: widget.placeholderText,
      prefix: const CupertinoTextFieldPrefixIcon(
        icon: Icon(
          CupertinoIcons.placemark_fill,
        ),
      ),
      controller: widget.textFieldController,
      onTap: _onTapLocationField,
    );
  }
}
