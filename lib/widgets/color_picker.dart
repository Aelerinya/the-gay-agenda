import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final _settings = Hive.box('settings');
  late var _color = Color(_settings.get('color'));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Change app color'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Pick a color!'),
                  content: MaterialPicker(
                      pickerColor: _color,
                      onColorChanged: (value) {
                        _color = value;
                      }),
                  actions: [
                    TextButton(
                        child: const Text('Done',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          _settings.put('color', _color.value);
                          Navigator.pop(context);
                        })
                  ]);
            },
          );
        });
  }
}
