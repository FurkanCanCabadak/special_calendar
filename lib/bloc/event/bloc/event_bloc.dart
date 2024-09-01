import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:special_calendar/data/models/event_model.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<AddEvent>((event, emit) {
      List<EventModel> updatedList = [
        ...EventModel.eventList,
        event.event.copyWith(),
      ];

      if (EventModel.eventList.isEmpty) {
        emit(EventListEmpty());
      } else {
        emit(EventListUpdated(updatedList));
      }
    });
  }
}
