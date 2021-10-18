import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final _settings = Hive.box('settings');
  late int _theme = _settings.get('theme');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Switch theme"),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: _theme,
          isDense: true,
          items: ThemeMode.values
              .map((mode) => DropdownMenuItem(
                  value: mode.index,
                  child: Text(mode.toString().split('.').last)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _settings.put('theme', _theme = value!);
            });
          },
        )
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }
}
