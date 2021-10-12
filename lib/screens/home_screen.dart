import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/constants/example_events.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/utils/database_helpers.dart';
import 'package:the_gay_agenda/widgets/month_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
        future: getEventDatabase()
            .then((database) => getEventsFromDatabase(database)),
        builder: (context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("The Gay Agenda"),
              ),
              body: MonthView(events: snapshot.data ?? exampleEvents),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
