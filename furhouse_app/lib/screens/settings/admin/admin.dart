import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/widget_templates/tab_elevated_button_style.dart';

class Admin extends StatefulWidget {
  const Admin({
    super.key,
  });

  @override
  State<Admin> createState() {
    return _AdminState();
  }
}

class _AdminState extends State<Admin> {
  final ScrollController _homeScrollbar = ScrollController();

  Color addedPetsButtonColor = lightBlueColor;
  Color adoptedPetsButtonColor = darkBlueColor;

  late Widget content;

  @override
  Widget build(BuildContext context) {
    /*content = Expanded(
      child: RawScrollbar(
        thumbVisibility: true,
        thumbColor: darkerBlueColor,
        thickness: 6,
        radius: const Radius.circular(20),
        scrollbarOrientation: ScrollbarOrientation.right,
        minThumbLength: 5,
        controller: _homeScrollbar,
        child: GridView.count(
          crossAxisCount: 2,
          controller: _homeScrollbar,
          children: List.generate(
            petMap.length,
            (index) {
              return _generateListItemContainer(index);
            },
          ),
        ),
      ),
    );*/

    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabElevatedButtonStyle(
                buttonColor: addedPetsButtonColor,
                prefixIcon: const Icon(
                  Icons.add_circle_outlined,
                  size: 20,
                ),
                buttonText: AppLocalizations.of(context)?.addedPets ?? "",
                onTap: () {},
              ),
              TabElevatedButtonStyle(
                buttonColor: adoptedPetsButtonColor,
                prefixIcon: const Icon(
                  Icons.home_filled,
                  size: 20,
                ),
                buttonText: AppLocalizations.of(context)?.adoptedPets ?? "",
                onTap: () {},
              ),
            ],
          ),
          content,
        ],
      ),
    );
  }
}
