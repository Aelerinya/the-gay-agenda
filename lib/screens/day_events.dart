import 'package:flutter/material.dart';
import 'package:the_gay_agenda/services/events.dart';

class DayEventsScreen extends StatelessWidget {
  final DateTime date;
  final List<Event> events;
  final MaterialLocalizations locale;

  const DayEventsScreen(
      {required this.date,
      required this.events,
      required this.locale,
      Key? key})
      : super(key: key);

  Widget eventWidget(Event event) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          child: ListTile(
            title: Text(event.name),
            subtitle: Text(event.formatDate(locale)),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final locale = MaterialLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.formatFullDate(date)),
      ),
      body: ListView(
        children: events.map((e) => eventWidget(e)).toList(),
      ),
    );
  }
}
