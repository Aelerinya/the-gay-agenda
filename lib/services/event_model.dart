import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/services/database.dart';
import 'package:the_gay_agenda/services/events.dart';

class EventModel extends ChangeNotifier {
  final EventDatabase _database;
  List<Event>? events;

  EventModel({required database}) : _database = database {
    _updateEventsFromDb();
  }

  Future<void> _updateEventsFromDb() async {
    events = await _database.get();
    notifyListeners();
  }

  void insert(Event event) async {
    await _database.insert(event);
    await _updateEventsFromDb();
  }

  void insertList(List<Event> events) async {
    await _database.insertList(events);
    await _updateEventsFromDb();
  }

  void update(Event event) async {
    await _database.update(event);
    await _updateEventsFromDb();
  }

  void delete(int id) async {
    await _database.delete(id);
    await _updateEventsFromDb();
  }
}
