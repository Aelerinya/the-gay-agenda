import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_gay_agenda/constants/example_events.dart';
import 'package:the_gay_agenda/utils/database_helpers.dart';
import 'package:the_gay_agenda/widgets/month_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
        future: getEventDatabase(),
        builder: (context, AsyncSnapshot<Database> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("The Gay Agenda"),
              ),
              body: MonthView(events: exampleEvents),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
