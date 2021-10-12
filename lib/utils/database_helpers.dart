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
        'CREATE TABLE events(id INTEGER PRIMARY KEY, name TEXT, start TEXT, end TEXT)',
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

Future<void> insertListOfEventsToDatabase(
    Database database, List<Event> events) async {
  for (var event in events) {
    await database.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

Future<List<Event>> getEventsFromDatabase(Database database) async {
  final List<Map<String, dynamic>> queryResults =
      await database.query('events');
  return List.generate(queryResults.length, (i) {
    return Event(
      id: queryResults[i]['id'],
      name: queryResults[i]['name'],
      start: DateTime.parse(queryResults[i]['start']),
      end: DateTime.tryParse(queryResults[i]['end']),
    );
  });
}

Future<void> updateEventFromDatabase(
    Database database, int id, Event event) async {
  await database.update(
    'events',
    event.toMap(),
    where: 'id = ?',
    whereArgs: [event.id],
  );
}

Future<void> deleteEventFromDatabase(
  Database database,
  int id,
  Event event,
) async {
  await database.delete(
    'events',
    where: 'id = ?',
    whereArgs: [id],
  );
}
