import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_gay_agenda/screens/create_event.dart';
import 'package:the_gay_agenda/services/events.dart';
import 'package:the_gay_agenda/widgets/month_view.dart';
import 'package:the_gay_agenda/widgets/profile_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("The Gay Agenda")),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Event>("events").listenable(),
          builder: (_, Box<Event> box, __) => MonthView(events: box.values)),
      drawer: const ProfileDrawer(),
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
