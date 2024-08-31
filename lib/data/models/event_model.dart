import 'package:hive/hive.dart';
import 'package:special_calendar/core/enums/event_type_enum.dart';
part 'event_model.g.dart';

@HiveType(typeId: 1)
class EventModel extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;
  @HiveField(1)
  final String header;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final EventType eventType;
  @HiveField(4)
  final bool isDeleted;

  EventModel({
    required this.dateTime,
    required this.header,
    required this.description,
    required this.eventType,
    required this.isDeleted,
  });

  static List<EventModel> eventList = [];
}
