import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/models/history_event.dart';

class HistoryService {
  static const _key = 'history_events_v1';
  static const _maxEvents = 100;

  List<HistoryEvent> load(SharedPreferences prefs) {
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    final events = decoded
        .map((e) => HistoryEvent.fromJson(e as Map<String, dynamic>))
        .toList();
    return events.reversed.toList();
  }

  Future<void> addEvent(SharedPreferences prefs, HistoryEvent event) async {
    final existing = load(prefs).reversed.toList();
    existing.add(event);
    final trimmed = existing.length > _maxEvents
        ? existing.sublist(existing.length - _maxEvents)
        : existing;
    final encoded = jsonEncode(trimmed.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  /// [index] is into the newest-first list [load] returns.
  Future<void> removeAt(SharedPreferences prefs, int index) async {
    final events = load(prefs);
    if (index < 0 || index >= events.length) return;
    events.removeAt(index);
    final encoded = jsonEncode(
      events.reversed.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_key, encoded);
  }

  Future<void> clear(SharedPreferences prefs) async {
    await prefs.remove(_key);
  }
}
