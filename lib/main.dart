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
  if (events.isEmpty) events.addAll(exampleEvents);
  final users = await Hive.openBox<User>('users');
  if (users.isEmpty) {
    users.add(User(
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'jane@doe.de',
        imagePath: ''));
  }
  final settings = await Hive.openBox('settings');
  if (settings.isEmpty) settings.put('color', 0xff443a49);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (_, Box box, __) => MaterialApp(
            title: 'The Gay Agenda',
            theme: ThemeData(
                primarySwatch:
                    MaterialColor(Hive.box('settings').get('color'), {
              50: Color(Hive.box('settings').get('color')).withOpacity(.1),
              100: Color(Hive.box('settings').get('color')).withOpacity(.2),
              200: Color(Hive.box('settings').get('color')).withOpacity(.3),
              300: Color(Hive.box('settings').get('color')).withOpacity(.4),
              400: Color(Hive.box('settings').get('color')).withOpacity(.5),
              500: Color(Hive.box('settings').get('color')).withOpacity(.6),
              600: Color(Hive.box('settings').get('color')).withOpacity(.7),
              700: Color(Hive.box('settings').get('color')).withOpacity(.8),
              800: Color(Hive.box('settings').get('color')).withOpacity(.9),
              900: Color(Hive.box('settings').get('color')).withOpacity(1),
            })),
            home: const HomeScreen()));
  }
}
