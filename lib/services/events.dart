import 'package:flutter/material.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

class Event {
  final String name;
  final DateTime start;
  final DateTime? end;

  Event({required this.name, required this.start, this.end})
      : assert(end == null || end.compareTo(start) >= 0);

  bool happensOnDay(DateTime day) {
    if (sameDay(day, start)) {
      return true;
    }
    if (end != null && sameDay(day, end!)) {
      return true;
    }
    if (end != null && start.compareTo(day) <= 0 && end!.compareTo(day) >= 0) {
      return true;
    }
    return false;
  }

  String formatDate(MaterialLocalizations localization) {
    if (end == null) {
      return localization.formatTimeOfDay(TimeOfDay.fromDateTime(start)) +
          " " +
          localization.formatFullDate(start);
    } else {
      if (sameDay(start, end!)) {
        return localization.formatTimeOfDay(TimeOfDay.fromDateTime(start)) +
            " - " +
            localization.formatTimeOfDay(TimeOfDay.fromDateTime(end!)) +
            " " +
            localization.formatFullDate(start);
      } else {
        return localization.formatFullDate(start) +
            " - " +
            localization.formatFullDate(end!);
      }
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'start': start.toIso8601String(),
      'end': end != null ? end!.toIso8601String() : '',
    };
  }
}
