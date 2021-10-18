import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:the_gay_agenda/screens/day_events.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

class MonthView extends StatefulWidget {
  final Iterable<Event> events;

  const MonthView({required this.events, Key? key}) : super(key: key);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class DateAndEvents {
  final DateTime date;
  final Iterable<Event> events;

  DateAndEvents({required this.date, required this.events});
}

class _MonthViewState extends State<MonthView> {
  DateTime _month = DateTime.now();

  Iterable<DateAndEvents> getAllDisplayedDaysAndEvents() {
    final intl = MaterialLocalizations.of(context);
    final firstDay = _month.getStartOfFirstWeekOfMonth(
        firstDayOfWeekIndex: intl.firstDayOfWeekIndex);

    return Iterable.generate(7 * 6, (index) {
      final day = DateTime(firstDay.year, firstDay.month, firstDay.day + index);
      return DateAndEvents(
          date: day,
          events: widget.events.where((event) => event.happensOnDay(day)));
    });
  }

  Widget dayNumber({required DateTime date, required Iterable<Event> events}) {
    final color = date.month != _month.month ? Colors.grey : null;

    return MaterialButton(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(0),
      child: Column(children: [
        const Spacer(),
        Text("${date.day}", style: TextStyle(color: color)),
        Flexible(
            child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: LayoutBuilder(builder: (_, constraints) {
                  final itemsNbMax = (constraints.maxWidth / 7).floor() *
                      (constraints.maxHeight / 7).floor();
                  final itemsNb = events.length.clamp(0, itemsNbMax);
                  final itemsRatio = constraints.biggest.aspectRatio * 2;

                  return SizedBox(
                      width: sqrt(itemsNb / itemsRatio) * itemsRatio * 7,
                      child: WrapSuper(
                        spacing: 2,
                        lineSpacing: 2,
                        alignment: WrapSuperAlignment.center,
                        children: List.generate(itemsNb,
                            (_) => Icon(Icons.circle, size: 5, color: color)),
                      ));
                })))
      ]),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DayEventsScreen(
                    date: date,
                    events: events,
                    locale: MaterialLocalizations.of(context))));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final intl = MaterialLocalizations.of(context);

    return AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            ColoredBox(
                color: Theme.of(context).primaryColor,
                child: Row(
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
                )),
            AspectRatio(
                aspectRatio: 7 / 6,
                child: GridView.count(
                    crossAxisCount: 7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: getAllDisplayedDaysAndEvents()
                        .map((v) => dayNumber(date: v.date, events: v.events))
                        .toList()))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ));
  }
}
