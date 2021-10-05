import 'package:flutter_test/flutter_test.dart';
import 'package:the_gay_agenda/services/events.dart';

void main() {
  test("happensOnDay", () {
    expect(Event(name: "", start: DateTime.now()).happensOnDay(DateTime.now()),
        true);
    expect(
        Event(name: "", start: DateTime(2021, 01, 01, 0))
            .happensOnDay(DateTime(2021, 01, 01, 1)),
        true);
    expect(
        Event(name: "", start: DateTime(2021, 01, 01, 2))
            .happensOnDay(DateTime(2021, 01, 01, 1)),
        true);
    expect(
        Event(name: "", start: DateTime(2021, 01, 02, 0))
            .happensOnDay(DateTime(2021, 01, 01, 1)),
        false);
    expect(
        Event(
                name: "",
                start: DateTime(2021, 01, 02, 0),
                end: DateTime(2021, 01, 04, 0))
            .happensOnDay(DateTime(2021, 01, 05, 1)),
        false);
    expect(
        Event(
                name: "",
                start: DateTime(2021, 01, 02, 0),
                end: DateTime(2021, 01, 04, 0))
            .happensOnDay(DateTime(2021, 01, 04, 1)),
        true);
    expect(
        Event(
                name: "",
                start: DateTime(2021, 01, 02, 0),
                end: DateTime(2021, 01, 04, 0))
            .happensOnDay(DateTime(2021, 01, 03, 1)),
        true);
  });
}
