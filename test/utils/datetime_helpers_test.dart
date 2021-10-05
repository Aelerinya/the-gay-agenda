import 'package:flutter_test/flutter_test.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

void main() {
  test("getStartOfFirstWeekOfMonth", () {
    expect(getStartOfFirstWeekOfMonth(DateTime(2021, 10, 5)),
        equals(DateTime(2021, 09, 26)));
    expect(
        getStartOfFirstWeekOfMonth(DateTime(2021, 10, 5),
            firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 09, 27)));
    expect(
        getStartOfFirstWeekOfMonth(DateTime(2021, 11, 1),
            firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 11, 1)));
  });

  test("getEndOfLastWeekOfMonth", () {
    expect(getEndOfLastWeekOfMonth(DateTime(2021, 10, 5)),
        equals(DateTime(2021, 11, 06)));
    expect(
        getEndOfLastWeekOfMonth(DateTime(2021, 11, 30), firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 12, 5)));
    expect(
        getEndOfLastWeekOfMonth(DateTime(2021, 10, 5), firstDayOfWeekIndex: 1),
        equals(DateTime(2021, 10, 31)));
  });

  test("getAllDatesInRange", () {
    expect(
        getAllDatesInRange(DateTime(2021, 01, 01), DateTime(2021, 01, 04)),
        equals([
          DateTime(2021, 01, 01),
          DateTime(2021, 01, 02),
          DateTime(2021, 01, 03),
          DateTime(2021, 01, 04),
        ]));
  });
}
