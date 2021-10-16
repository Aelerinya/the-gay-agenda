import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/widgets/profile_drawer.dart';
import 'package:the_gay_agenda/widgets/profile_form.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Gay Agenda'),
      ),
      drawer: const ProfileDrawer(),
      body: const ProfileForm(),
    );
  }
}
