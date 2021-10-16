import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/screens/home_screen.dart';

import 'constants/example_events.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  final events = await Hive.openBox<Event>("events");
  if (events.isEmpty) events.addAll(exampleEvents);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'The Gay Agenda',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen());
  }
}
