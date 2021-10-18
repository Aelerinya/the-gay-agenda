import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_gay_agenda/services/user.dart';
import 'package:the_gay_agenda/widgets/color_picker.dart';
import 'package:the_gay_agenda/widgets/profile_drawer.dart';
import 'package:the_gay_agenda/widgets/theme_switcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<User>("users").listenable(),
        builder: (_, Box<User> box, __) => Scaffold(
            appBar: AppBar(title: const Text('The Gay Agenda')),
            drawer: ProfileDrawer(user: box.values.first),
            body: Center(
              child: Column(
                children: const [
                  ColorPicker(),
                  SizedBox(height: 25),
                  ThemeSwitcher()
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
            resizeToAvoidBottomInset: false));
  }
}
