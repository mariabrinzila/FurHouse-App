import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/screens/home/home_tab.dart';
import 'package:furhouse_app/screens/home/add_pet_tab.dart';
import 'package:furhouse_app/screens/home/settings_tab.dart';

import 'package:furhouse_app/common/constants/others.dart';
import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/constants/picker_values.dart';

import 'package:furhouse_app/common/widget_templates/tab_style.dart';

import 'package:furhouse_app/models/pet_VM.dart';

import 'package:furhouse_app/services/web_scraper.dart';

class Home extends StatefulWidget {
  final int selectedTabIndex;
  final PetVM? currentPet;
  final String? petPhotoURL;

  const Home({
    super.key,
    required this.selectedTabIndex,
    this.currentPet,
    this.petPhotoURL,
  });

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  TabBar get _tabBarStyle {
    return TabBar(
      indicatorColor: Colors.white,
      unselectedLabelColor: unselectedLabelColor,
      tabs: const [
        TabStyle(
          iconData: CupertinoIcons.home,
        ),
        TabStyle(
          iconData: CupertinoIcons.add_circled_solid,
        ),
        /*TabStyle(
          iconData: CupertinoIcons.search_circle_fill,
        ),*/
        TabStyle(
          iconData: CupertinoIcons.settings,
        ),
      ],
    );
  }

  @override
  void initState() {
    var scraper = WebScraper();
    catBreedValues = [];
    dogBreedValues = [];
    rabbitBreedValues = [];
    rodentBreedValues = [];
    birdBreedValues = [];
    allBreedValues = [];

    scraper.scrapCatBreeds();
    scraper.scrapDogBreeds();
    scraper.scrapRabbitBreeds();
    scraper.scrapRodentBreeds();
    scraper.scrapBirdBreeds();

    allBreedValues.sort();

    genderValues = [
      "male",
      "female",
    ];

    categoryValues = [
      "cat",
      "dog",
      "rabbit",
      "rodent",
      "bird",
    ];

    ageUnitValues = [
      "days",
      "months",
      "years",
    ];

    detailsValues = [
      "vaccinated",
      "sterilized",
      "pastTrauma",
      "injured",
      "none",
    ];

    priorityValues = [
      "low",
      "medium",
      "high",
    ];

    if (notificationService != null) {
      notificationService?.initializePlatformNotifications();
    }

    super.initState();
  }

  void _computeTranslationsForPickerValues(BuildContext context) {
    List<String> translationsList = <String>[];
    String translation;

    // gender
    for (var gender in genderValues) {
      translation = _computePickerTranslation(gender, context);
      translationsList.add(translation);
    }

    genderValues.clear();
    genderValues.addAll(translationsList);

    // category
    translationsList.clear();

    for (var category in categoryValues) {
      translation = _computePickerTranslation(category, context);
      translationsList.add(translation);
    }

    categoryValues.clear();
    categoryValues.addAll(translationsList);

    // age unit
    translationsList.clear();

    for (var ageUnit in ageUnitValues) {
      translation = _computePickerTranslation(ageUnit, context);
      translationsList.add(translation);
    }

    ageUnitValues.clear();
    ageUnitValues.addAll(translationsList);

    // details
    translationsList.clear();

    for (var detail in detailsValues) {
      translation = _computePickerTranslation(detail, context);
      translationsList.add(translation);
    }

    detailsValues.clear();
    detailsValues.addAll(translationsList);

    // priority
    translationsList.clear();

    for (var priority in priorityValues) {
      translation = _computePickerTranslation(priority, context);
      translationsList.add(translation);
    }

    priorityValues.clear();
    priorityValues.addAll(translationsList);
  }

  String _computePickerTranslation(String value, BuildContext context) {
    var translation = "";

    switch (value) {
      case "male":
        {
          translation = AppLocalizations.of(context)?.male ?? "";
        }
        break;

      case "female":
        {
          translation = AppLocalizations.of(context)?.female ?? "";
        }
        break;

      case "cat":
        {
          translation = AppLocalizations.of(context)?.cat ?? "";
        }
        break;

      case "dog":
        {
          translation = AppLocalizations.of(context)?.dog ?? "";
        }
        break;

      case "rabbit":
        {
          translation = AppLocalizations.of(context)?.rabbit ?? "";
        }
        break;

      case "rodent":
        {
          translation = AppLocalizations.of(context)?.rodent ?? "";
        }
        break;

      case "bird":
        {
          translation = AppLocalizations.of(context)?.bird ?? "";
        }
        break;

      case "days":
        {
          translation = AppLocalizations.of(context)?.days ?? "";
        }
        break;

      case "months":
        {
          translation = AppLocalizations.of(context)?.months ?? "";
        }
        break;

      case "years":
        {
          translation = AppLocalizations.of(context)?.years ?? "";
        }
        break;

      case "vaccinated":
        {
          translation = AppLocalizations.of(context)?.vaccinated ?? "";
        }
        break;

      case "sterilized":
        {
          translation = AppLocalizations.of(context)?.sterilized ?? "";
        }
        break;

      case "pastTrauma":
        {
          translation = AppLocalizations.of(context)?.pastTrauma ?? "";
        }
        break;

      case "injured":
        {
          translation = AppLocalizations.of(context)?.injured ?? "";
        }
        break;

      case "none":
        {
          translation = AppLocalizations.of(context)?.none ?? "";
        }
        break;

      case "low":
        {
          translation = AppLocalizations.of(context)?.low ?? "";
        }
        break;

      case "medium":
        {
          translation = AppLocalizations.of(context)?.medium ?? "";
        }
        break;

      case "high":
        {
          translation = AppLocalizations.of(context)?.high ?? "";
        }
        break;
    }

    return translation;
  }

  void _onGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _computeTranslationsForPickerValues(context);

    var appBarWidget = AppBar(
      foregroundColor: Colors.white,
      backgroundColor: darkBlueColor,
      centerTitle: true,
      title: Image.asset(
        "assets/images/Logo.png",
        color: Colors.white,
        width: 250,
        height: 180,
      ),
    );

    if (widget.selectedTabIndex > 0) {
      appBarWidget = AppBar(
        foregroundColor: Colors.white,
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: Image.asset(
          "assets/images/Logo.png",
          color: Colors.white,
          width: 250,
          height: 180,
        ),
        leading: IconButton(
          onPressed: () {
            _onGoBack(context);
          },
          icon: const Icon(
            CupertinoIcons.arrow_left_square_fill,
          ),
        ),
      );
    }

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale.locale,
      home: DefaultTabController(
        initialIndex: widget.selectedTabIndex,
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBarWidget,
          bottomNavigationBar: PreferredSize(
            preferredSize: _tabBarStyle.preferredSize,
            child: Material(
              color: darkerBlueColor,
              child: _tabBarStyle,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lightBlueColor,
                  lighterBlueColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TabBarView(
              children: [
                const HomeTab(),
                widget.currentPet == null
                    ? const AddPetTab()
                    : AddPetTab(
                        currentPet: widget.currentPet,
                        petPhotoURL: widget.petPhotoURL,
                      ),
                //const HomeTab(),
                const SettingsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
