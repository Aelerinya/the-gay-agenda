import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gay_agenda/screens/home_screen.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/services/user.dart';

import 'constants/example_events.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EventAdapter());
  Hive.registerAdapter(UserAdapter());

  final events = await Hive.openBox<Event>("events");
  if (events.isEmpty) await events.addAll(exampleEvents);

  final users = await Hive.openBox<User>('users');
  if (users.isEmpty) {
    await users.add(User(
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@doe.de',
        imagePath: ''));
  }

  final settings = await Hive.openBox('settings');
  if (settings.get('color') == null) {
    await settings.put('color', 0xfff7a8b8);
  }
  if (settings.get('theme') == null) {
    await settings.put('theme', ThemeMode.system.index);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (_, Box box, __) {
          final color = Color(box.get('color'));
          return MaterialApp(
              title: 'The Gay Agenda',
              theme: ThemeData(
                primarySwatch: MaterialColor(
                    Color.alphaBlend(Colors.white38, color).value,
                    {for (var i = 0; i < 1000; i += 50) i: color}),
              ),
              darkTheme: ThemeData(
                primarySwatch: MaterialColor(
                    Color.alphaBlend(Colors.black38, color).value,
                    {for (var i = 0; i < 1000; i += 50) i: color}),
              ),
              themeMode: ThemeMode.values[box.get('theme')],
              home: const HomeScreen());
        });
  }
}
