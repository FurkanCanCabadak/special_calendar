part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventListUpdated extends EventState {
  final List<EventModel> eventList;

  const EventListUpdated(this.eventList);

  @override
  List<Object> get props => [eventList];
}

class EventListEmpty extends EventState {}
