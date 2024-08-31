import 'package:special_calendar/core/enums/icon_enum.dart';

class HomeScreenVm {
  final Map<CustomIcon, String> appLanguagesList = <CustomIcon, String>{};
  HomeScreenVm() {
    for (var language in CustomIcon.values) {
      appLanguagesList.addAll({language: getPath(language)});
    }
  }
}
