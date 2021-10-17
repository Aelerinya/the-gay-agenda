import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/utils/datetime_helpers.dart';
import 'package:the_gay_agenda/screens/create_event.dart';
import 'package:the_gay_agenda/services/events.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({required this.event, Key? key}) : super(key: key);

  Widget getFormattedDate(
          MaterialLocalizations localizations, String prefix, DateTime date) =>
      Text(
        prefix +
            " " +
            localizations.formatTimeOfDay(event.start.time) +
            " " +
            localizations.formatFullDate(event.start),
        style: const TextStyle(fontSize: 16),
      );

  @override
  Widget build(BuildContext context) {
    final localization = MaterialLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event details"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateEvent(eventToEdit: event)));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                event.delete();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Event: " + event.name,
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              getFormattedDate(
                  localization, event.end != null ? "From" : "On", event.start),
              if (event.end != null) ...{
                const SizedBox(height: 10),
                getFormattedDate(localization, "To", event.end!),
              }
            ],
          )),
    );
  }
}
