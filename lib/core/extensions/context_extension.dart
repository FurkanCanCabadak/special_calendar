import 'package:flutter/cupertino.dart';
import 'package:special_calendar/data/services/localization.dart';

extension ContextExtension on BuildContext {
  FirstLocalization get myLocalization => FirstLocalization.of(this);
}
