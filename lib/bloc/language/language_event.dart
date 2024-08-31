import 'package:flutter/material.dart';

abstract class LanguageEvent {}

class LanguageChangeEvent extends LanguageEvent {
  final Locale newLocale;

  LanguageChangeEvent(this.newLocale);
}
