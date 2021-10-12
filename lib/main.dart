import 'package:flutter/material.dart';
import 'package:the_gay_agenda/screens/home_screen.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/utils/database_helpers.dart';

import 'constants/example_events.dart';

void main() async {
  final database = await getEventDatabase();
  final events = await getEventsFromDatabase(database);
  if (events.isEmpty) {
    await insertListOfEventsToDatabase(database, exampleEvents);
  }
  await deleteEventFromDatabase(database, 10);
  await updateEventFromDatabase(
      database,
      1,
      Event(
          id: 1,
          name: "wørk",
          start: DateTime(2021, 10, 5),
          end: DateTime(2021, 10, 7)));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'The Gay Agenda',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen());
  }
}
