import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:special_calendar/bloc/event/bloc/event_bloc.dart';
import 'package:special_calendar/bloc/theme/theme_bloc.dart';
import 'package:special_calendar/bloc/theme/theme_state.dart';
import 'package:special_calendar/constants/color_constants.dart';
import 'package:special_calendar/constants/text_constants.dart';
import 'package:special_calendar/constants/text_style_constants.dart';
import 'package:special_calendar/core/enums/icon_enum.dart';
import 'package:special_calendar/bloc/language/language_bloc.dart';
import 'package:special_calendar/bloc/language/language_event.dart';
import 'package:special_calendar/core/extensions/context_extension.dart';
import 'package:special_calendar/core/extensions/padding_extension.dart';
import 'package:special_calendar/presentation/view/events/screen/event_screen.dart';
import 'package:special_calendar/presentation/view/home/widget/home_screen_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomIcon? _selectedIcon;
  late HomeScreenVm homeScreenVm;

  @override
  void initState() {
    super.initState();
    homeScreenVm =
        HomeScreenVm(); // Cihazın mevcut dilini alın ve _selectedIcon'u ayarlayın
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String deviceLanguage =
          Localizations.localeOf(context).languageCode;
      setState(() {
        if (deviceLanguage == TextConstants.turkishShortText) {
          _selectedIcon = CustomIcon.flagIconTR;
        } else if (deviceLanguage == TextConstants.englishShortText) {
          _selectedIcon = CustomIcon.flagIconEN;
        } else {
          _selectedIcon = CustomIcon.flagIconEN; // Default olarak İngilizce
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: DropdownButton<CustomIcon>(
                iconSize: 0,
                value: _selectedIcon,
                items: homeScreenVm.appLanguagesList.entries.map((entry) {
                  return DropdownMenuItem<CustomIcon>(
                    value: entry.key,
                    child: Row(
                      children: [
                        Image.asset(entry.value, width: 8.w),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (CustomIcon? newValue) {
                  setState(() {
                    _selectedIcon = newValue;
                  });
                  if (newValue != null) {
                    if (newValue == CustomIcon.flagIconTR) {
                      context
                          .read<LanguageBloc>()
                          .add(LanguageChangeEvent(const Locale('tr')));
                    } else if (newValue == CustomIcon.flagIconEN) {
                      context
                          .read<LanguageBloc>()
                          .add(LanguageChangeEvent(const Locale('en')));
                    }
                  }
                },
              ),
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventListUpdated) {
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: state.eventList.length,
                      itemBuilder: (context, index) {
                        String formattedHour = DateFormat('kk:mm')
                            .format(state.eventList[index].dateTime);
                        String formattedDay = DateFormat('MMMd',
                                Localizations.localeOf(context).languageCode)
                            .format(state.eventList[index].dateTime);
                        return Container(
                          width: 100.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: context.watch<ThemeBloc>().state
                                    is ThemeDarkState
                                ? ColorConstants.cardColorListForDark[index % 6]
                                : ColorConstants
                                    .cardColorListForLight[index % 6],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedDay,
                                    style: appCardTextStyle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    formattedHour,
                                    style:
                                        appCardTextStyle.copyWith(fontSize: 16),
                                  ),
                                ],
                              ).symetricalPadding(horizontal: 4.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      state.eventList[index].header,
                                      style: appCardTextStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ).symetricalPadding(horizontal: 4.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_outline_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).symetricalPadding(vertical: 2.h);
                      },
                    ),
                  ),
                );
              } else if (state is EventListEmpty) {
                return Center(
                    child:
                        Text(context.myLocalization.translation('neEvents')));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ).symetricalPadding(horizontal: 5.w),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventScreen(),
                ));
          },
          child: const Icon(Icons.edit_calendar_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
