import 'package:the_gay_agenda/services/events.dart';

final exampleEvents = [
  Event(
      name: "piscine",
      start: DateTime(2021, 10, 05, 10),
      end: DateTime(2021, 10, 05, 11)),
  Event(name: "work", start: DateTime(2021, 10, 5), end: DateTime(2021, 10, 7)),
  ...List.generate(
      5, (index) => Event(name: "study $index", start: DateTime(2021, 10, 3))),
  ...List.generate(
      10, (index) => Event(name: "party $index", start: DateTime(2021, 09, 30)))
];
