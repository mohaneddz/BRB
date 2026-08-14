class HistoryEvent {
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;
  final String mode;
  final String? photoPath;
  final String? placeName;

  const HistoryEvent({
    required this.timestamp,
    required this.mode,
    this.latitude,
    this.longitude,
    this.photoPath,
    this.placeName,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'latitude': latitude,
    'longitude': longitude,
    'mode': mode,
    'photoPath': photoPath,
    'placeName': placeName,
  };

  factory HistoryEvent.fromJson(Map<String, dynamic> json) => HistoryEvent(
    timestamp: DateTime.parse(json['timestamp'] as String),
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    mode: json['mode'] as String,
    photoPath: json['photoPath'] as String?,
    placeName: json['placeName'] as String?,
  );
}
