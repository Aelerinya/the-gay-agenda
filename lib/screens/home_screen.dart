import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/widgets/month_view.dart';

import 'package:the_gay_agenda/constants/example_events.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Gay Agenda"),
      ),
      body: MonthView(events: exampleEvents),
    );
  }
}
