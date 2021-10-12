import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_gay_agenda/services/events.dart';

class CreateEvent extends StatefulWidget {
  final Event? eventToEdit;
  const CreateEvent({this.eventToEdit, Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  DateTime? _start;
  DateTime? _end;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Create event"),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.eventToEdit?.name,
                      decoration: const InputDecoration(labelText: "Name"),
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      initialValue: widget.eventToEdit?.start.toString() ??
                          DateTime.now().toString(),
                      decoration: const InputDecoration(labelText: "Start"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Start date is required";
                        }
                        try {
                          DateTime.parse(value);
                        } on FormatException {
                          return "Invalid start date";
                        }
                      },
                      onSaved: (value) {
                        _start = DateTime.parse(value!);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      initialValue: widget.eventToEdit?.end.toString() ??
                          DateTime.now().toString(),
                      decoration: const InputDecoration(labelText: "End"),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          try {
                            DateTime.parse(value);
                          } on FormatException {
                            return "Invalid end date";
                          }
                        }
                      },
                      onSaved: (value) {
                        _end = value != null && value.isNotEmpty
                            ? DateTime.parse(value)
                            : null;
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Cause every field to save its value in the state
                          _formKey.currentState!.save();
                          final events = Hive.box<Event>("events");
                          events.add(
                              Event(name: _name!, start: _start!, end: _end));

                          // If we were updating an event, remove the old one
                          final eventToEdit = widget.eventToEdit;
                          if (eventToEdit != null) {
                            eventToEdit.delete();
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ))));
  }
}
