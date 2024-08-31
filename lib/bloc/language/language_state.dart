import 'package:flutter/material.dart';

abstract class LanguageState {
  final Locale languageCode;
  LanguageState(this.languageCode);
}

class LanguageStateTRState extends LanguageState {
  LanguageStateTRState() : super(const Locale('tr'));
}

class LanguageStateENState extends LanguageState {
  LanguageStateENState() : super(const Locale('en'));
}
