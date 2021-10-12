import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gay_agenda/screens/home_screen.dart';
import 'package:the_gay_agenda/services/database.dart';
import 'package:the_gay_agenda/services/event_model.dart';

import 'constants/example_events.dart';

void main() async {
  // TODO: remove this later
  final database = await EventDatabase.create();
  final events = await database.get();
  if (events.isEmpty) {
    await database.insertList(exampleEvents);
  }

  runApp(ChangeNotifierProvider.value(
    value: EventModel(database: database),
    child: const MyApp(),
  ));
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
