import 'package:flutter_test/flutter_test.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

void main() {
  test("getStartOfFirstWeekOfMonth", () {
    expect(DateTime(2021, 10, 5).getStartOfFirstWeekOfMonth(),
        equals(DateTime(2021, 09, 26)));
    expect(
        DateTime(2021, 10, 5)
            .getStartOfFirstWeekOfMonth(firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 09, 27)));
    expect(
        DateTime(2021, 11, 1)
            .getStartOfFirstWeekOfMonth(firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 11, 1)));
  });

  test("getEndOfLastWeekOfMonth", () {
    expect(DateTime(2021, 10, 5).getEndOfLastWeekOfMonth(),
        equals(DateTime(2021, 11, 06)));
    expect(
        DateTime(2021, 11, 30).getEndOfLastWeekOfMonth(firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 12, 5)));
    expect(
        DateTime(2021, 10, 5).getEndOfLastWeekOfMonth(firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 10, 31)));
  });

  test("getAllDaysUntil", () {
    expect(
        DateTime(2021, 01, 01).getAllDaysUntil(DateTime(2021, 01, 04)),
        equals([
          DateTime(2021, 01, 01),
          DateTime(2021, 01, 02),
          DateTime(2021, 01, 03),
          DateTime(2021, 01, 04),
        ]));
  });
}
