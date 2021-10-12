import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/services/event_model.dart';
import 'package:the_gay_agenda/widgets/month_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = context.watch<EventModel>().events;
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Gay Agenda"),
      ),
      body: events != null
          ? MonthView(events: events)
          : const CircularProgressIndicator(),
    );
  }
}
