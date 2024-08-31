import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:special_calendar/data/services/localization_delegate.dart';
import 'package:special_calendar/presentation/view/home/screen/home_screen.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';
import 'bloc/language/language_bloc.dart';
import 'bloc/language/language_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => LanguageBloc()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, languageState) {
                  return MaterialApp(
                    localizationsDelegates: const [
                      FirstLocalizationDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('tr', 'TR'), // Turkish
                      Locale('en', 'EN'), // English
                    ],
                    locale: languageState.languageCode,
                    debugShowCheckedModeBanner: false,
                    theme: themeState.themeData,
                    home: const HomePage(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
