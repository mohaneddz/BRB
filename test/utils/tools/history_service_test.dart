import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/models/history_event.dart';
import 'package:brb/utils/tools/history_service.dart';

void main() {
  late HistoryService service;
  late SharedPreferences prefs;

  HistoryEvent eventAt(int hour) => HistoryEvent(
    timestamp: DateTime.utc(2026, 8, 14, hour),
    mode: 'Pocket',
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    service = HistoryService();
  });

  test('load() on a fresh install returns an empty list', () {
    expect(service.load(prefs), isEmpty);
  });

  test('addEvent() persists and load() returns newest-first', () async {
    await service.addEvent(prefs, eventAt(10));
    await service.addEvent(prefs, eventAt(11));
    await service.addEvent(prefs, eventAt(12));

    final events = service.load(prefs);
    expect(events.map((e) => e.timestamp.hour), [12, 11, 10]);
  });

  test('removeAt() removes by newest-first index and persists', () async {
    await service.addEvent(prefs, eventAt(10));
    await service.addEvent(prefs, eventAt(11));
    await service.addEvent(prefs, eventAt(12));

    // Newest-first: index 0 is hour 12.
    await service.removeAt(prefs, 0);

    final events = service.load(prefs);
    expect(events.map((e) => e.timestamp.hour), [11, 10]);
  });

  test('removeAt() with an out-of-range index is a no-op', () async {
    await service.addEvent(prefs, eventAt(10));
    await service.removeAt(prefs, 5);
    await service.removeAt(prefs, -1);

    expect(service.load(prefs).length, 1);
  });

  test('clear() empties the log', () async {
    await service.addEvent(prefs, eventAt(10));
    await service.addEvent(prefs, eventAt(11));
    await service.clear(prefs);

    expect(service.load(prefs), isEmpty);
  });

  test('addEvent() caps the log at 100 events, dropping the oldest', () async {
    for (var i = 0; i < 105; i++) {
      await service.addEvent(
        prefs,
        HistoryEvent(timestamp: DateTime.utc(2026, 1, 1).add(Duration(minutes: i)), mode: 'Pocket'),
      );
    }
    final events = service.load(prefs);
    expect(events.length, 100);
    // Newest-first: the very last one added should be first.
    expect(events.first.timestamp, DateTime.utc(2026, 1, 1).add(const Duration(minutes: 104)));
  });
}
