import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:special_calendar/bloc/theme/theme_bloc.dart';
import 'package:special_calendar/bloc/theme/theme_events.dart';
import 'package:special_calendar/bloc/theme/theme_state.dart';
import 'package:special_calendar/constants/color_constants.dart';
import 'package:special_calendar/constants/padding_constants.dart';
import 'package:special_calendar/core/enums/icon_enum.dart';
import 'package:special_calendar/core/extensions/context_extension.dart';

class HomeScreenVm {
  final Map<CustomIcon, String> appLanguagesList = <CustomIcon, String>{};
  HomeScreenVm() {
    for (var language in CustomIcon.values) {
      appLanguagesList.addAll({language: getPath(language)});
    }
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: PaddingConstants.drawerVerticalBig,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: PaddingConstants.drawerItemsPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.myLocalization.translation('themeText')),
                  Switch(
                    value: context.watch<ThemeBloc>().state is ThemeDarkState,
                    activeColor:
                        context.watch<ThemeBloc>().state is ThemeDarkState
                            ? ColorConstants.primaryDarkColor
                            : ColorConstants.primaryLightColor,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ToggleThemeEvent());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
