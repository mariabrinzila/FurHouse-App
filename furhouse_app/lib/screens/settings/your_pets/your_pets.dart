import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/functions/exception_code_handler.dart';

import 'package:furhouse_app/common/widget_templates/tab_elevated_button_style.dart';
import 'package:furhouse_app/common/widget_templates/pet_card_button.dart';

import 'package:furhouse_app/models/pet_VM.dart';

import 'package:furhouse_app/services/pets.dart';
import 'package:furhouse_app/services/users.dart';

class YourPets extends StatefulWidget {
  final String userEmail;

  const YourPets({
    super.key,
    required this.userEmail,
  });

  @override
  State<YourPets> createState() {
    return _YourPetsState();
  }
}

class _YourPetsState extends State<YourPets> {
  Color addedPetsButtonColor = lightBlueColor;
  Color adoptedPetsButtonColor = darkBlueColor;

  Map<String, PetVM> petMap = <String, PetVM>{};

  final ScrollController _homeScrollbar = ScrollController();

  late Widget content;

  @override
  void initState() {
    _getAddedPets().then((value) {
      setState(() {
        petMap = value;
      });
    });

    super.initState();
  }

  Future<Map<String, PetVM>> _getAddedPets() async {
    try {
      var pets = await Pets().readAddedPets(widget.userEmail);

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  Widget _generateListItemContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: PetCardButton(
        petObject: petMap.entries.elementAt(index).value,
        petPhotoURL: petMap.entries.elementAt(index).key,
        fromSettings: true,
      ),
    );
  }

  Future<Map<String, PetVM>> _getAdoptedPets() async {
    try {
      var pets = await Pets().readAdoptedPets(widget.userEmail);

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  void _adoptedPets() {
    _getAdoptedPets().then((value) {
      setState(() {
        petMap = value;
      });
    });

    setState(() {
      addedPetsButtonColor = darkBlueColor;
      adoptedPetsButtonColor = lightBlueColor;
    });
  }

  void _addedPets() {
    _getAddedPets().then((value) {
      setState(() {
        petMap = value;
      });
    });

    setState(() {
      addedPetsButtonColor = lightBlueColor;
      adoptedPetsButtonColor = darkBlueColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    content = Expanded(
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
    );

    if (petMap.isEmpty) {
      content = Center(
        child: CupertinoActivityIndicator(
          color: darkerBlueColor,
          radius: 30,
        ),
      );
    }

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
                onTap: () {
                  _addedPets();
                },
              ),
              TabElevatedButtonStyle(
                buttonColor: adoptedPetsButtonColor,
                prefixIcon: const Icon(
                  Icons.home_filled,
                  size: 20,
                ),
                buttonText: AppLocalizations.of(context)?.adoptedPets ?? "",
                onTap: () {
                  _adoptedPets();
                },
              ),
            ],
          ),
          content,
        ],
      ),
    );
  }
}
