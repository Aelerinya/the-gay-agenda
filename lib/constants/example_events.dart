import 'package:the_gay_agenda/services/events.dart';

final exampleEvents = [
  Event(
      id: 0,
      name: "piscine",
      start: DateTime(2021, 10, 05, 10),
      end: DateTime(2021, 10, 05, 11)),
  Event(
      id: 1,
      name: "work",
      start: DateTime(2021, 10, 5),
      end: DateTime(2021, 10, 7)),
  ...List.generate(
      5,
      (index) => Event(
          id: index + 3, name: "study $index", start: DateTime(2021, 10, 3))),
  ...List.generate(
      10,
      (index) => Event(
          id: index + 8, name: "party $index", start: DateTime(2021, 09, 30)))
];
