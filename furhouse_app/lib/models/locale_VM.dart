import 'package:flutter/material.dart';

class LocaleVM {
  Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void set setLocale(String languageCode) {
    _locale = Locale(languageCode);
  }
}
