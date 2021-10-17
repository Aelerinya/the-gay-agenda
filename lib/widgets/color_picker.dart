import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color pickerColor = Color(Hive.box('settings').get('color') ?? 0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Pick a color!',
                        style: TextStyle(
                          color: useWhiteForeground(pickerColor)
                              ? const Color(0xffffffff)
                              : const Color(0xff000000),
                        )),
                    content: SingleChildScrollView(
                      child: MaterialPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Change it!',
                            style: TextStyle(
                              color: useWhiteForeground(pickerColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            )),
                        onPressed: () {
                          Hive.box('settings').put('color', pickerColor.value);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )
            },
        child: const Text('Change App Color'));
  }
}