import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

part 'events.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime start;
  @HiveField(2)
  final DateTime? end;

  Event({required this.name, required this.start, this.end})
      : assert(end == null || !end.isBefore(start));

  bool happensOnDay(DateTime day) {
    return start.date == day.date ||
        end != null && start.isBefore(day) && !end!.isBefore(day.date);
  }

  String formatDate(MaterialLocalizations localizations) {
    if (end == null) {
      return localizations.formatTimeOfDay(start.time) +
          " " +
          localizations.formatFullDate(start);
    } else if (start.date == end!.date) {
      return localizations.formatTimeOfDay(start.time) +
          " - " +
          localizations.formatTimeOfDay(end!.time) +
          " " +
          localizations.formatFullDate(end!);
    } else {
      return localizations.formatTimeOfDay(start.time) +
          " " +
          localizations.formatFullDate(start) +
          " - " +
          localizations.formatTimeOfDay(end!.time) +
          " " +
          localizations.formatFullDate(end!);
    }
  }
}
