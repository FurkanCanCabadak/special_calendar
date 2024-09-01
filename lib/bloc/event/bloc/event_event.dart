part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends EventEvent {
  final EventModel event;

  const AddEvent(this.event);

  @override
  List<Object> get props => [event];
}
