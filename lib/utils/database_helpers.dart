import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_gay_agenda/services/events.dart';

Future<Database> getEventDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  return openDatabase(
    join(await getDatabasesPath(), 'event_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE events(name TEXT, start TEXT, end TEXT)',
      );
    },
    version: 1,
  );
}

Future<void> insertEventToDatabase(Database database, Event event) async {
  await database.insert(
    'events',
    event.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Event>> getEventsFromDatabase(Database database) async {
  final List<Map<String, dynamic>> queryResults =
      await database.query('events');
  return List.generate(queryResults.length, (i) {
    return Event(
      name: queryResults[i]['name'],
      start: queryResults[i]['start'],
      end: queryResults[i]['end'],
    );
  });
}

Future<void> updateEventFromDatabase(
    Database database, String name, Event event) async {
  await database.update(
    'events',
    event.toMap(),
    where: 'name = ?',
    whereArgs: [event.name],
  );
}

Future<void> deleteEventFromDatabase(
  Database database,
  String name,
  Event event,
) async {
  await database.delete(
    'events',
    where: 'name = ?',
    whereArgs: [name],
  );
}
