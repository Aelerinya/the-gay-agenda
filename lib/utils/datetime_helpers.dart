DateTime getStartOfFirstWeekOfMonth(DateTime date,
    {int firstDayOfWeekIndex = 0}) {
  final firstDayOfMonth = DateTime(date.year, date.month, 1);
  final daysToSubtract = (firstDayOfMonth.weekday - firstDayOfWeekIndex) % 7;
  return DateTime(firstDayOfMonth.year, firstDayOfMonth.month,
      firstDayOfMonth.day - daysToSubtract);
}

DateTime getEndOfLastWeekOfMonth(DateTime date, {int firstDayOfWeekIndex = 0}) {
  final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
  final daysToAdd = (firstDayOfWeekIndex - lastDayOfMonth.weekday - 1) % 7;
  return DateTime(lastDayOfMonth.year, lastDayOfMonth.month,
      lastDayOfMonth.day + daysToAdd);
}

Iterable<DateTime> getAllDatesInRange(DateTime start, DateTime end) sync* {
  for (var day = start;
      day.compareTo(end) <= 0;
      day = DateTime(day.year, day.month, day.day + 1)) {
    yield day;
  }
}
