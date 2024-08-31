import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:special_calendar/bloc/theme/theme_events.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeDarkState()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state is ThemeLightState) {
        emit(ThemeDarkState());
      } else {
        emit(ThemeLightState());
      }
    });
  }
}
