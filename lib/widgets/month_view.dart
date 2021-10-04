import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MonthView extends StatefulWidget {
  const MonthView({Key? key}) : super(key: key);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  DateTime _month = DateTime.now();

  DateTime getFirstDisplayedDay() {
    final intl = MaterialLocalizations.of(context);
    final firstDayOfMonth = DateTime(_month.year, _month.month, 1);
    final daysToSubtract =
        (firstDayOfMonth.weekday - intl.firstDayOfWeekIndex) % 7;
    return DateTime(firstDayOfMonth.year, firstDayOfMonth.month,
        firstDayOfMonth.day - daysToSubtract);
  }

  DateTime getLastDisplayedDay() {
    final intl = MaterialLocalizations.of(context);
    final lastDayOfMonth = DateTime(_month.year, _month.month + 1, 0);
    final daysToAdd =
        (intl.firstDayOfWeekIndex - lastDayOfMonth.weekday - 1) % 7;
    return DateTime(lastDayOfMonth.year, lastDayOfMonth.month,
        lastDayOfMonth.day + daysToAdd);
  }

  Iterable<DateTime> getAllDisplayedDays() sync* {
    final firstDay = getFirstDisplayedDay();
    final lastDay = getLastDisplayedDay();

    for (var day = firstDay;
        day.compareTo(lastDay) <= 0;
        day = DateTime(day.year, day.month, day.day + 1)) {
      yield day;
    }
  }

  Widget dayNumber(DateTime date) => Center(
          child: Text(
        "${date.day}",
        style: TextStyle(
            color: date.month == _month.month ? Colors.black : Colors.grey),
      ));

  @override
  Widget build(BuildContext context) {
    final intl = MaterialLocalizations.of(context);
    return Column(children: [
      Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  _month = DateTime(_month.year, _month.month - 1);
                });
              },
              icon: const Icon(Icons.arrow_left)),
          Text(intl.formatMonthYear(_month)),
          IconButton(
              onPressed: () {
                setState(() {
                  _month = DateTime(_month.year, _month.month + 1);
                });
              },
              icon: const Icon(Icons.arrow_right))
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 7,
        children: getAllDisplayedDays().map((e) => dayNumber(e)).toList(),
      )
    ]);
  }
}
