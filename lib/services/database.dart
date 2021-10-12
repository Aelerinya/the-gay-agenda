import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_gay_agenda/services/events.dart';

class EventDatabase {
  final Database _database;

  EventDatabase._create({required database}) : _database = database;

  static Future<EventDatabase> create() async {
    WidgetsFlutterBinding.ensureInitialized();
    final _database = await openDatabase(
      join(await getDatabasesPath(), 'event_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY, name TEXT, start TEXT, end TEXT)',
        );
      },
      version: 1,
    );
    return EventDatabase._create(database: _database);
  }

  Future<void> insert(Event event) async {
    await _database.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertList(List<Event> events) async {
    for (var event in events) {
      await _database.insert(
        'events',
        event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Event>> get() async {
    final List<Map<String, dynamic>> queryResults =
        await _database.query('events');
    return List.generate(queryResults.length, (i) {
      return Event(
        id: queryResults[i]['id'],
        name: queryResults[i]['name'],
        start: DateTime.parse(queryResults[i]['start']),
        end: DateTime.tryParse(queryResults[i]['end']),
      );
    });
  }

  Future<void> update(Event event) async {
    await _database.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> delete(int id) async {
    await _database.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
