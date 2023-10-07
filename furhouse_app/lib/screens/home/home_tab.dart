import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/modal_popup.dart';
import 'package:furhouse_app/common/widget_templates/header_information_with_button.dart';
import 'package:furhouse_app/common/widget_templates/pet_card_button.dart';

import 'package:furhouse_app/models/petVM.dart';

import 'package:furhouse_app/services/pets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    super.key,
  });

  @override
  State<HomeTab> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<HomeTab> {
  Map<String, PetVM> petMap = <String, PetVM>{};
  final ScrollController _homeScrollbar = ScrollController();

  int currentPage = 1;
  final int limit = 6;
  int startIndex = 1;

  String sortedBy = "";
  bool sortOrderAscending = true;
  String filterBy = "";
  String filteredCriteria = "";
  bool sortedOrFiltered = false;

  double? headerHeight = 50;

  @override
  void initState() {
    _getAllPets(startIndex, limit).then((value) {
      setState(() {
        petMap = value;
      });
    });

    super.initState();
  }

  Future<Map<String, PetVM>> _getAllPets(int index, int limit) async {
    try {
      var pets = await Pets().selectPaginatedPets(index, limit);

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  Widget _generateListItemContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: PetCardButton(
        petObject: petMap.entries.elementAt(index).value,
        petPhotoURL: petMap.entries.elementAt(index).key,
      ),
    );
  }

  void _previousPage() {
    setState(() {
      currentPage--;
      startIndex -= limit;

      petMap = <String, PetVM>{};

      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;
        });
      });
    });
  }

  void _nextPage() {
    setState(() {
      currentPage++;
      startIndex += limit;

      petMap = <String, PetVM>{};

      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;
        });
      });
    });
  }

  void _sortModal(BuildContext context) async {
    var sortModalResult = await sortOptionModalPopup(context);

    if (sortModalResult == "cancel" || sortModalResult == null) return;

    var sortOptionsArray = sortModalResult.split(", ");
    var sortOption = sortOptionsArray[0];
    var sortOrderAscending = sortOptionsArray[1] == "ascending";

    petMap = <String, PetVM>{};

    _getAllSortedPets(sortOption, sortOrderAscending).then((value) {
      setState(() {
        petMap = value;

        sortedBy = sortOption;
        this.sortOrderAscending = sortOrderAscending;
        sortedOrFiltered = true;

        startIndex = 1;
        currentPage = 1;
      });
    });
  }

  Future<Map<String, PetVM>> _getAllSortedPets(
      String sortOption, bool sortOrderAscending) async {
    try {
      var pets = await Pets().selectSortedFilteredPets(
          sortOption, sortOrderAscending, filterBy, filteredCriteria);

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  void _clearSortedOptions() {
    if (filterBy.isNotEmpty) {
      sortedBy = "";

      _getAllFilteredPets(filterBy, filteredCriteria).then((value) {
        setState(() {
          petMap = value;

          sortedBy = "";
          sortedOrFiltered = true;

          startIndex = 1;
          currentPage = 1;
        });
      });
    } else {
      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;

          sortedBy = "";
          sortedOrFiltered = false;

          headerHeight = 50;
        });
      });
    }
  }

  void _filterModal(BuildContext context) async {
    var filterModalResult = await filterOptionModalPopup(context);

    if (filterModalResult == "cancel" || filterModalResult == null) return;

    var filterOptionArray = filterModalResult.split(", ");
    var filterOption = filterOptionArray[0];
    var filterCriteria = filterOptionArray[1];

    petMap = <String, PetVM>{};

    _getAllFilteredPets(filterOption, filterCriteria).then((value) {
      setState(() {
        petMap = value;

        filterBy = filterOption;
        filteredCriteria = filterCriteria;
        sortedOrFiltered = true;

        startIndex = 1;
        currentPage = 1;
      });
    });
  }

  Future<Map<String, PetVM>> _getAllFilteredPets(
      String filterOption, String filterCriteria) async {
    try {
      var pets = await Pets().selectSortedFilteredPets(
          sortedBy, sortOrderAscending, filterOption, filterCriteria);

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  void _clearFilteredOptions() {
    if (sortedBy.isNotEmpty) {
      filterBy = "";
      filteredCriteria = "";

      _getAllSortedPets(sortedBy, sortOrderAscending).then((value) {
        setState(() {
          petMap = value;

          filterBy = "";
          filteredCriteria = "";
          sortedOrFiltered = true;

          startIndex = 1;
          currentPage = 1;
        });
      });
    } else {
      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;

          filterBy = "";
          filteredCriteria = "";
          sortedOrFiltered = false;

          headerHeight = 50;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (petMap.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(
          color: darkerBlueColor,
          radius: 30,
        ),
      );
    }

    Widget sortWidget = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: darkBlueColor,
        elevation: 5,
      ),
      onPressed: () {
        _sortModal(context);
      },
      child: const Icon(
        Icons.sort_outlined,
        color: Colors.white,
      ),
    );

    Widget filterWidget = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: darkBlueColor,
        elevation: 5,
      ),
      onPressed: () {
        _filterModal(context);
      },
      child: const Icon(
        Icons.filter_alt_rounded,
        color: Colors.white,
      ),
    );

    Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        sortWidget,
        filterWidget,
      ],
    );

    if (sortedBy.isNotEmpty) {
      var sortedOrder = sortOrderAscending ? "ascending" : "descending";

      sortWidget = HeaderInformationWithButton(
        containerHeight: 25,
        containerWidth: 250,
        text: "Sorted by $sortedBy, $sortedOrder",
        onPressed: _clearSortedOptions,
      );

      headerHeight = 100;

      headerWidget = Container(
        margin: const EdgeInsets.only(
          top: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sortWidget,
            filterWidget,
          ],
        ),
      );
    }

    if (filterBy.isNotEmpty) {
      filterWidget = HeaderInformationWithButton(
        containerHeight: 25,
        containerWidth: 350,
        text: "Filtered by $filterBy, $filteredCriteria",
        onPressed: _clearFilteredOptions,
      );

      headerHeight = 100;

      headerWidget = Container(
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sortWidget,
            filterWidget,
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: headerHeight,
          child: headerWidget,
        ),
        Expanded(
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
        ),
        if (!sortedOrFiltered) ...[
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
                if (petMap.length == limit) ...[
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
        ]
      ],
    );
  }
}
