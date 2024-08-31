import 'package:flutter/material.dart';
import 'package:special_calendar/constants/color_constants.dart';

abstract class ThemeState {
  final ThemeData themeData;
  ThemeState(this.themeData);
}

class ThemeLightState extends ThemeState {
  ThemeLightState()
      : super(
          ThemeData(
            brightness: Brightness.light,
            iconTheme:
                const IconThemeData(color: ColorConstants.primaryLightColor),
            drawerTheme: DrawerThemeData(
                backgroundColor: Colors.white,
                surfaceTintColor: ColorConstants.primaryDarkColor),
            elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                foregroundColor:
                    WidgetStatePropertyAll(ColorConstants.primaryLightColor),
                iconColor:
                    WidgetStatePropertyAll(ColorConstants.primaryLightColor),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: ColorConstants.primaryLightColor),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.secondaryColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.primaryLightColor, width: 1),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.primaryLightColor, width: 1),
              ),
            ),
          ),
        );
}

class ThemeDarkState extends ThemeState {
  ThemeDarkState()
      : super(
          ThemeData(
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
              color: ColorConstants.primaryDarkColor,
            )),
            iconTheme: IconThemeData(color: ColorConstants.primaryDarkColor),
            drawerTheme: DrawerThemeData(
                surfaceTintColor: ColorConstants.primaryDarkColor),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                foregroundColor:
                    WidgetStatePropertyAll(ColorConstants.primaryDarkColor),
                iconColor:
                    WidgetStatePropertyAll(ColorConstants.primaryDarkColor),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: ColorConstants.primaryDarkColor),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.secondaryColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.primaryDarkColor, width: 1),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.primaryDarkColor, width: 1),
              ),
            ),
          ),
        );
}
