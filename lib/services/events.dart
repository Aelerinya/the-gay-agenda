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
}
