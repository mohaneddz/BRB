class Preset {
  final String title;
  final bool vibration;
  final String challengeType;
  final bool camera;
  final bool location;
  final bool mic;
  final double volume;
  final double sound;
  final String distance;
  final String delay;
  final String mode;
  final String lastUsed;

  const Preset({
    required this.title,
    required this.vibration,
    required this.challengeType,
    required this.camera,
    required this.location,
    this.mic = false,
    required this.volume,
    required this.sound,
    required this.distance,
    required this.delay,
    required this.mode,
    required this.lastUsed,
  });

  Preset copyWith({
    String? title,
    bool? vibration,
    String? challengeType,
    bool? camera,
    bool? location,
    bool? mic,
    double? volume,
    double? sound,
    String? distance,
    String? delay,
    String? mode,
    String? lastUsed,
  }) {
    return Preset(
      title: title ?? this.title,
      vibration: vibration ?? this.vibration,
      challengeType: challengeType ?? this.challengeType,
      camera: camera ?? this.camera,
      location: location ?? this.location,
      mic: mic ?? this.mic,
      volume: volume ?? this.volume,
      sound: sound ?? this.sound,
      distance: distance ?? this.distance,
      delay: delay ?? this.delay,
      mode: mode ?? this.mode,
      lastUsed: lastUsed ?? this.lastUsed,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'vibration': vibration,
    'challengeType': challengeType,
    'camera': camera,
    'location': location,
    'mic': mic,
    'volume': volume,
    'sound': sound,
    'distance': distance,
    'delay': delay,
    'mode': mode,
    'lastUsed': lastUsed,
  };

  factory Preset.fromJson(Map<String, dynamic> json) => Preset(
    title: json['title'] as String,
    vibration: json['vibration'] as bool,
    challengeType: json['challengeType'] as String? ?? 'none',
    camera: json['camera'] as bool,
    location: json['location'] as bool,
    mic: json['mic'] as bool? ?? false,
    volume: (json['volume'] as num).toDouble(),
    sound: (json['sound'] as num).toDouble(),
    distance: json['distance'] as String,
    delay: json['delay'] as String,
    mode: json['mode'] as String,
    lastUsed: json['lastUsed'] as String,
  );
}
