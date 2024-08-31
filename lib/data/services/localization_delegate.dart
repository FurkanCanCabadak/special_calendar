import 'package:flutter/material.dart';
import 'package:special_calendar/data/services/localization.dart';

class FirstLocalizationDelegate
    extends LocalizationsDelegate<FirstLocalization> {
  const FirstLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<FirstLocalization> load(Locale locale) async {
    FirstLocalization localizations = FirstLocalization(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<FirstLocalization> old) {
    return false;
  }
}
