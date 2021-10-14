import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

part 'events.g.dart';

@HiveType(typeId: 0)
class Event {
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

  String formatDate(MaterialLocalizations l10n) {
    return l10n.formatTimeOfDay(start.time) +
        (start.date != end?.date ? " " + l10n.formatFullDate(start) : "") +
        (end != null
            ? " - " +
                l10n.formatTimeOfDay(end!.time) +
                " " +
                l10n.formatFullDate(end!)
            : "");
  }
}
