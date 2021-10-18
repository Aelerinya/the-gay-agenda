import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gay_agenda/screens/create_event.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/services/user.dart';
import 'package:the_gay_agenda/widgets/month_view.dart';
import 'package:the_gay_agenda/widgets/profile_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("The Gay Agenda")),
      drawer: ValueListenableBuilder(
          valueListenable: Hive.box<User>("users").listenable(),
          builder: (_, Box<User> box, __) =>
              ProfileDrawer(user: box.values.first)),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Event>("events").listenable(),
          builder: (_, Box<Event> box, __) => MonthView(events: box.values)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateEvent()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
