import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:special_calendar/bloc/event/bloc/event_bloc.dart';
import 'package:special_calendar/constants/color_constants.dart';
import 'package:special_calendar/constants/padding_constants.dart';
import 'package:special_calendar/core/enums/event_type_enum.dart';
import 'package:special_calendar/core/extensions/context_extension.dart';
import 'package:special_calendar/core/extensions/padding_extension.dart';
import 'package:special_calendar/data/models/event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

TextEditingController _controllerHeader = TextEditingController();
TextEditingController _controllerDesc = TextEditingController();

EventType selectedEventType = EventType.none;
DateTime eventTime = DateTime.now();

@override
class _EventScreenState extends State<EventScreen> {
  void selectEventButton(EventType event) {
    setState(() {
      selectedEventType = event;
    });
  }

  void clearAndPop() {
    selectedEventType = EventType.none;
    eventTime = DateTime.now();
    _controllerDesc.clear();
    _controllerHeader.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Padding(
          padding: PaddingConstants.appPadding,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => clearAndPop(),
                  ),
                ),
              ),
              SizedBox(
                width: 100.w,
                height: 30.h,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (value) {
                    eventTime = value;
                  },
                ),
              ).symetricalPadding(vertical: 2.h),
              TextField(
                controller: _controllerHeader,
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    _controllerHeader.text = value;
                  });
                },
                decoration: InputDecoration(
                    label: Text(context.myLocalization.translation('header')),
                    hintText:
                        context.myLocalization.translation('enterHeader')),
              ).symetricalPadding(vertical: 2.h),
              TextField(
                controller: _controllerDesc,
                maxLines: 4,
                onChanged: (value) {
                  setState(() {
                    _controllerDesc.text = value;
                  });
                },
                decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    label:
                        Text(context.myLocalization.translation('description')),
                    hintText:
                        context.myLocalization.translation('enterDescription')),
              ).symetricalPadding(vertical: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: selectedEventType == EventType.big
                            ? WidgetStatePropertyAll(
                                ColorConstants.buttonTappedDarkColor)
                            : null),
                    onPressed: () {
                      //big event button
                      selectEventButton(EventType.big);
                    },
                    child: Text(context.myLocalization.translation('bigEvent')),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: selectedEventType == EventType.casual
                            ? WidgetStatePropertyAll(
                                ColorConstants.buttonTappedDarkColor)
                            : null),
                    onPressed: () {
                      //Casual event button
                      selectEventButton(EventType.casual);
                    },
                    child:
                        Text(context.myLocalization.translation('casualEvent')),
                  ),
                ],
              ).symetricalPadding(vertical: 2.h)
            ],
          ),
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => EventBloc(),
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                if (selectedEventType != EventType.none &&
                    eventTime != DateTime.now() &&
                    _controllerDesc.text.isNotEmpty &&
                    _controllerHeader.text.isNotEmpty) {
                  final event = EventModel(
                    header: _controllerHeader.text,
                    dateTime: eventTime,
                    description: _controllerDesc.text,
                    eventType: selectedEventType,
                    isDeleted: false,
                  );
                  EventModel.eventList.add(event);
                  context.read<EventBloc>().add(AddEvent(event));
                  clearAndPop();
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        context.myLocalization.translation("fillAreaError"),
                      ),
                      duration: const Duration(seconds: 4),
                    ),
                  );
                }
              },
              child: Text(context.myLocalization.translation('createButton')),
            );
          },
        ),
      ),
    );
  }
}
