import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:special_calendar/bloc/language/language_event.dart';
import 'package:special_calendar/bloc/language/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageStateENState()) {
    on<LanguageChangeEvent>((event, emit) {
      if (event.newLocale.languageCode == 'en') {
        emit(LanguageStateENState());
      } else if (event.newLocale.languageCode == 'tr') {
        emit(LanguageStateTRState());
      }
    });
  }
}
