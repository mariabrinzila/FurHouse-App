import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/modal_popup.dart';
import 'package:furhouse_app/common/widget_templates/header_information_with_button.dart';
import 'package:furhouse_app/common/widget_templates/pet_card_button.dart';

import 'package:furhouse_app/models/pet_VM.dart';

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

  String sortBy = "";
  bool sortOrderAscending = true;
  String filterBy = "";
  String filterByCriteria = "";
  String searchFor = "";
  String searchForCriteria = "";
  bool sortFilterSearch = false;

  double? headerHeight = 50;

  final TextEditingController _searchController = TextEditingController();

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
      var pets = await Pets().readPaginatedPets(index, limit);

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

    _getAllSortFilterSearchPets(sortOption, sortOrderAscending, filterBy,
            filterByCriteria, searchFor, searchForCriteria)
        .then((value) {
      setState(() {
        petMap = value;

        sortBy = sortOption;
        this.sortOrderAscending = sortOrderAscending;
        sortFilterSearch = true;

        startIndex = 1;
        currentPage = 1;
      });
    });
  }

  Future<Map<String, PetVM>> _getAllSortFilterSearchPets(
      String sortOption,
      bool sortOrderAscending,
      String filterOption,
      String filterCriteria,
      String searchOption,
      String searchCriteria) async {
    try {
      var pets = await Pets().readSortFilterSearchPets(
          sortOption,
          sortOrderAscending,
          filterOption,
          filterCriteria,
          searchOption,
          searchCriteria);

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  void _clearSortOptions() {
    if (filterBy.isNotEmpty || searchFor.isNotEmpty) {
      sortBy = "";

      _getAllSortFilterSearchPets(sortBy, sortOrderAscending, filterBy,
              filterByCriteria, searchFor, searchForCriteria)
          .then((value) {
        setState(() {
          petMap = value;

          sortBy = "";
          sortFilterSearch = true;

          startIndex = 1;
          currentPage = 1;
        });
      });
    } else {
      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;

          sortBy = "";
          sortFilterSearch = false;

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

    _getAllSortFilterSearchPets(sortBy, sortOrderAscending, filterOption,
            filterCriteria, searchFor, searchForCriteria)
        .then((value) {
      setState(() {
        petMap = value;

        filterBy = filterOption;
        filterByCriteria = filterCriteria;
        sortFilterSearch = true;

        startIndex = 1;
        currentPage = 1;
      });
    });
  }

  void _clearFilterOptions() {
    if (sortBy.isNotEmpty || searchFor.isNotEmpty) {
      filterBy = "";
      filterByCriteria = "";

      _getAllSortFilterSearchPets(sortBy, sortOrderAscending, filterBy,
              filterByCriteria, searchFor, searchForCriteria)
          .then((value) {
        setState(() {
          petMap = value;

          filterBy = "";
          filterByCriteria = "";
          sortFilterSearch = true;

          startIndex = 1;
          currentPage = 1;
        });
      });
    } else {
      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;

          filterBy = "";
          filterByCriteria = "";
          sortFilterSearch = false;

          headerHeight = 50;
        });
      });
    }
  }

  void _searchModal(BuildContext context) async {
    var searchModalResult =
        await searchOptionModalPopup(context, _searchController);

    if (searchModalResult == "cancel" || searchModalResult == null) return;

    var searchOptionArray = searchModalResult.split(", ");
    var searchOption = searchOptionArray[0];
    var searchCriteria = searchOptionArray[1];

    petMap = <String, PetVM>{};

    _getAllSortFilterSearchPets(sortBy, sortOrderAscending, filterBy,
            filterByCriteria, searchOption, searchCriteria)
        .then((value) {
      setState(() {
        petMap = value;

        searchFor = searchOption;
        searchForCriteria = searchCriteria;
        sortFilterSearch = true;

        startIndex = 1;
        currentPage = 1;
      });
    });

    _searchController.clear();
  }

  void _clearSearchOptions() {
    if (sortBy.isNotEmpty || filterBy.isNotEmpty) {
      searchFor = "";
      searchForCriteria = "";

      _getAllSortFilterSearchPets(sortBy, sortOrderAscending, filterBy,
              filterByCriteria, searchFor, searchForCriteria)
          .then((value) {
        setState(() {
          petMap = value;

          searchFor = "";
          searchForCriteria = "";
          sortFilterSearch = true;

          startIndex = 1;
          currentPage = 1;
        });
      });
    } else {
      _getAllPets(startIndex, limit).then((value) {
        setState(() {
          petMap = value;

          searchFor = "";
          searchForCriteria = "";
          sortFilterSearch = false;

          headerHeight = 50;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        CupertinoIcons.sort_up,
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

    Widget searchWidget = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: darkBlueColor,
        elevation: 5,
      ),
      onPressed: () {
        _searchModal(context);
      },
      child: const Icon(
        CupertinoIcons.search,
        color: Colors.white,
      ),
    );

    Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        sortWidget,
        searchWidget,
        filterWidget,
      ],
    );

    if (sortBy.isNotEmpty) {
      var sortedOrder = sortOrderAscending ? "ascending" : "descending";

      sortWidget = HeaderInformationWithButton(
        containerHeight: 25,
        containerWidth: 250,
        text: "Sorted by $sortBy, $sortedOrder",
        onPressed: _clearSortOptions,
      );

      headerHeight = 150;

      headerWidget = Container(
        margin: const EdgeInsets.only(
          top: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sortWidget,
            searchWidget,
            filterWidget,
          ],
        ),
      );
    }

    if (filterBy.isNotEmpty) {
      var criteria = filterByCriteria;
      double containerWidth = 340;

      if (filterByCriteria.length > 20) {
        criteria = "${filterByCriteria.substring(0, 19)}...";

        containerWidth = 380;
      }

      filterWidget = HeaderInformationWithButton(
        containerHeight: 25,
        containerWidth: containerWidth,
        text: "Filtered by $filterBy, $criteria",
        onPressed: _clearFilterOptions,
      );

      headerHeight = 140;

      headerWidget = Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sortWidget,
            searchWidget,
            filterWidget,
          ],
        ),
      );
    }

    if (searchFor.isNotEmpty) {
      var criteria = searchForCriteria;
      double containerWidth = 340;

      if (searchForCriteria.length > 20) {
        criteria = "${searchForCriteria.substring(0, 19)}...";

        containerWidth = 380;
      }

      searchWidget = HeaderInformationWithButton(
        containerHeight: 25,
        containerWidth: containerWidth,
        text: "Search for $searchFor, $criteria",
        onPressed: _clearSearchOptions,
      );

      headerHeight = 150;

      headerWidget = Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            sortWidget,
            searchWidget,
            filterWidget,
          ],
        ),
      );
    }

    if (petMap.isEmpty && sortFilterSearch) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: headerHeight,
            child: headerWidget,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 100,
            ),
            child: const CupertinoActivityIndicator(
              color: darkerBlueColor,
              radius: 30,
            ),
          ),
        ],
      );
    }

    if (petMap.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(
          color: darkerBlueColor,
          radius: 30,
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
        if (!sortFilterSearch) ...[
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
