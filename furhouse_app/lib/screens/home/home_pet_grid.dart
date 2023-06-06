import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/widget_templates/pet_card_button.dart';

import 'package:furhouse_app/models/petVM.dart';

class HomePetGrid extends StatelessWidget {
  final ScrollController _homeScrollbar = ScrollController();
  final Map<String, PetVM> petMap;

  HomePetGrid({
    super.key,
    required this.petMap,
  });

  Widget _generateListItemContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25,
        left: 15,
        right: 15,
      ),
      child: PetCardButton(
        petObject: petMap.entries.elementAt(index).value,
        petPhotoURL: petMap.entries.elementAt(index).key,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
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
    );
  }
}
