import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

class MonthView extends StatefulWidget {
  const MonthView({Key? key}) : super(key: key);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  DateTime _month = DateTime.now();

  Iterable<DateTime> getAllDisplayedDays() {
    final intl = MaterialLocalizations.of(context);
    final firstDay = getStartOfFirstWeekOfMonth(_month,
        firstDayOfWeekIndex: intl.firstDayOfWeekIndex);
    final lastDay = getEndOfLastWeekOfMonth(_month,
        firstDayOfWeekIndex: intl.firstDayOfWeekIndex);

    return getAllDatesInRange(firstDay, lastDay);
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
