import 'package:flutter/material.dart';

extension Helpers on DateTime {
  DateTime get date => DateTime(year, month, day);
  TimeOfDay get time => TimeOfDay.fromDateTime(this);

  DateTime getStartOfFirstWeekOfMonth({int firstDayOfWeekIndex = 0}) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysToSubtract = (firstDayOfMonth.weekday - firstDayOfWeekIndex) % 7;
    return DateTime(firstDayOfMonth.year, firstDayOfMonth.month,
        firstDayOfMonth.day - daysToSubtract);
  }

  DateTime getEndOfLastWeekOfMonth({int firstDayOfWeekIndex = 0}) {
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final daysToAdd = (firstDayOfWeekIndex - lastDayOfMonth.weekday - 1) % 7;
    return DateTime(lastDayOfMonth.year, lastDayOfMonth.month,
        lastDayOfMonth.day + daysToAdd);
  }

  Iterable<DateTime> getAllDaysUntil(DateTime end) sync* {
    for (var day = this;
        !day.isAfter(end);
        day = DateTime(day.year, day.month, day.day + 1)) {
      yield day;
    }
  }
}
