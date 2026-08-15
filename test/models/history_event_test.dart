import 'package:flutter_test/flutter_test.dart';
import 'package:brb/models/history_event.dart';

void main() {
  group('HistoryEvent JSON round-trip', () {
    test('preserves every field, including audioPath', () {
      final event = HistoryEvent(
        timestamp: DateTime.utc(2026, 8, 14, 15, 24),
        mode: 'Sensitive',
        latitude: 37.422,
        longitude: -122.084,
        photoPath: '/data/alarm_1.jpg',
        audioPath: '/data/alarm_1.m4a',
        placeName: '1600 Amphitheatre Pkwy',
      );

      final restored = HistoryEvent.fromJson(event.toJson());

      expect(restored.timestamp, event.timestamp);
      expect(restored.mode, event.mode);
      expect(restored.latitude, event.latitude);
      expect(restored.longitude, event.longitude);
      expect(restored.photoPath, event.photoPath);
      expect(restored.audioPath, event.audioPath);
      expect(restored.placeName, event.placeName);
    });

    test('nullable fields (including audioPath) survive being absent', () {
      final event = HistoryEvent(
        timestamp: DateTime.utc(2026, 8, 13, 23, 39),
        mode: 'Pocket',
      );
      final restored = HistoryEvent.fromJson(event.toJson());

      expect(restored.latitude, isNull);
      expect(restored.longitude, isNull);
      expect(restored.photoPath, isNull);
      expect(restored.audioPath, isNull);
      expect(restored.placeName, isNull);
    });

    test('fromJson defaults audioPath to null for pre-microphone data', () {
      final legacyJson = HistoryEvent(
        timestamp: DateTime.utc(2026, 8, 13, 23, 39),
        mode: 'Pocket',
      ).toJson()..remove('audioPath');

      final restored = HistoryEvent.fromJson(legacyJson);
      expect(restored.audioPath, isNull);
    });
  });
}
