import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstLocalization {
  final Locale locale;

  FirstLocalization({required this.locale});

  static FirstLocalization of(BuildContext context) {
    return Localizations.of<FirstLocalization>(context, FirstLocalization)!;
  }

  late Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> result = json.decode(data);

    _sentences = result.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return true;
  }

  String translation(String key) {
    return _sentences[key] ?? 'null value';
  }
}
