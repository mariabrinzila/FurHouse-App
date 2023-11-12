import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/main_theme.dart';

import 'package:furhouse_app/common/constants/picker_values.dart';

import 'package:furhouse_app/screens/landing/landing.dart';
import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/services/authentication.dart';

// ignore: must_be_immutable
class MainDisplay extends StatelessWidget {
  Widget widgetToDisplay = const Landing();

  MainDisplay({
    super.key,
  });

  void _computeTranslationsForPickerValues(BuildContext context) {
    List<String> translationsList = <String>[];
    String translation;

    // gender
    for (var gender in genderValues) {
      translation = _computePickerTranslation(context, gender);
      translationsList.add(translation);
    }

    genderValues.clear();
    genderValues.addAll(translationsList);

    // category
    translationsList.clear();

    for (var category in categoryValues) {
      translation = _computePickerTranslation(context, category);
      translationsList.add(translation);
    }

    categoryValues.clear();
    categoryValues.addAll(translationsList);

    // age unit
    translationsList.clear();

    for (var ageUnit in ageUnitValues) {
      translation = _computePickerTranslation(context, ageUnit);
      translationsList.add(translation);
    }

    ageUnitValues.clear();
    ageUnitValues.addAll(translationsList);

    // details
    translationsList.clear();

    for (var detail in detailsValues) {
      translation = _computePickerTranslation(context, detail);
      translationsList.add(translation);
    }

    detailsValues.clear();
    detailsValues.addAll(translationsList);

    // priority
    translationsList.clear();

    for (var priority in priorityValues) {
      translation = _computePickerTranslation(context, priority);
      translationsList.add(translation);
    }

    priorityValues.clear();
    priorityValues.addAll(translationsList);
  }

  String _computePickerTranslation(BuildContext context, String value) {
    var translation = "";

    switch (value) {
      case "male":
        {
          print("------------------------------------");
          print(AppLocalizations.of(context));
          print("------------------------------------");
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

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, ... ); <=> for using context after the widget's state has been initialized
    Future.delayed(Duration.zero, () {
      _computeTranslationsForPickerValues(context);
    });

    var currentUser = Authentication().getCurrentUser();

    if (currentUser != null) {
      widgetToDisplay = const Home(
        selectedTabIndex: 0,
      );
    }

    return MainTheme(
      childWidget: widgetToDisplay,
    );
  }
}
