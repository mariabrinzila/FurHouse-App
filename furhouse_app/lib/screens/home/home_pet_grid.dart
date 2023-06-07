import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/widget_templates/pet_card_button.dart';

import 'package:furhouse_app/models/petVM.dart';

class HomePetGrid extends StatefulWidget {
  final Map<String, PetVM> petMap;

  const HomePetGrid({
    super.key,
    required this.petMap,
  });

  @override
  State<HomePetGrid> createState() {
    return _HomePetGridState();
  }
}

class _HomePetGridState extends State<HomePetGrid> {
  final ScrollController _homeScrollbar = ScrollController();

  int currentPage = 1;
  late int petMapSize;
  final int limit = 10;

  int startPosition = 0;
  int endPosition = 10;

  late Map<String, PetVM> currentPetMap;

  @override
  void initState() {
    petMapSize = widget.petMap.length;

    _generateCurrentMap(startPosition, endPosition);

    super.initState();
  }

  void _generateCurrentMap(int start, int end) {
    int i;
    String currentPhotoURL;
    PetVM currentPet;
    currentPetMap = <String, PetVM>{};

    for (i = start; i < end; i++) {
      currentPet = widget.petMap.entries.elementAt(i).value;
      currentPhotoURL = widget.petMap.entries.elementAt(i).key;

      currentPetMap
          .addEntries(<String, PetVM>{currentPhotoURL: currentPet}.entries);
    }
  }

  Widget _generateListItemContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25,
        left: 15,
        right: 15,
      ),
      child: PetCardButton(
        petObject: currentPetMap.entries.elementAt(index).value,
        petPhotoURL: currentPetMap.entries.elementAt(index).key,
      ),
    );
  }

  void _previousPage() {
    setState(() {
      currentPage--;
      startPosition -= limit;
      endPosition -= limit;

      _generateCurrentMap(startPosition, endPosition);
    });
  }

  void _nextPage() {
    setState(() {
      currentPage++;
      startPosition += limit;
      endPosition += limit;

      if (endPosition <= petMapSize) {
        _generateCurrentMap(startPosition, endPosition);
      } else {
        _generateCurrentMap(startPosition, petMapSize);
      }
    });
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              controller: _homeScrollbar,
              children: List.generate(
                currentPetMap.length,
                (index) {
                  return _generateListItemContainer(index);
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (currentPage > 1) ...[
                  IconButton(
                    color: darkerBlueColor,
                    onPressed: _previousPage,
                    icon: const Icon(
                      CupertinoIcons.arrow_left_circle_fill,
                    ),
                  ),
                ],
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: null,
                  child: Text(
                    currentPage.toString(),
                    style: const TextStyle(
                      color: darkerBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (endPosition < petMapSize) ...[
                  IconButton(
                    color: darkerBlueColor,
                    onPressed: _nextPage,
                    icon: const Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
