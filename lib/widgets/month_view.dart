import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/screens/day_events.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';

class MonthView extends StatefulWidget {
  final List<Event> events;

  const MonthView({required this.events, Key? key}) : super(key: key);

  @override
  _MonthViewState createState() => _MonthViewState();
}

class DateAndEvents {
  final DateTime date;
  final List<Event> events;

  DateAndEvents({required this.date, required this.events});
}

class _MonthViewState extends State<MonthView> {
  DateTime _month = DateTime.now();

  Iterable<DateAndEvents> getAllDisplayedDaysAndEvents() {
    final intl = MaterialLocalizations.of(context);
    final firstDay = _month.getStartOfFirstWeekOfMonth(
        firstDayOfWeekIndex: intl.firstDayOfWeekIndex);
    final lastDay = _month.getEndOfLastWeekOfMonth(
        firstDayOfWeekIndex: intl.firstDayOfWeekIndex);

    return firstDay.getAllDaysUntil(lastDay).map((day) => DateAndEvents(
        date: day,
        events:
            widget.events.where((event) => event.happensOnDay(day)).toList()));
  }

  Widget dayNumber({required DateTime date, required List<Event> events}) {
    final color = date.month == _month.month ? Colors.black : Colors.grey;
    final eventBullet = Padding(
        padding: const EdgeInsets.all(1),
        child: Icon(
          Icons.circle,
          size: 5,
          color: color,
        ));
    return OpenContainer(
        // onTap: () => Navigator.of(context)
        //     .push(DayEventsScreen(date: date, events: events)),
        closedElevation: 0,
        openBuilder: (_, __) => DayEventsScreen(
              date: date,
              events: events,
              locale: MaterialLocalizations.of(context),
            ),
        closedBuilder: (_, __) => Column(children: [
              const Spacer(),
              Text(
                "${date.day}",
                style: TextStyle(color: color),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          events.length.clamp(0, 3), (index) => eventBullet)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate((events.length - 3).clamp(0, 3),
                          (index) => eventBullet))
                ],
              ))
            ]));
  }

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
        children: getAllDisplayedDaysAndEvents()
            .map((v) => dayNumber(date: v.date, events: v.events))
            .toList(),
      )
    ]);
  }
}
