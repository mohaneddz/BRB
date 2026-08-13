class Preset {
  final String title;
  final bool vibration;
  final bool lock;
  final bool camera;
  final bool location;
  final double volume;
  final double sound;
  final String distance;
  final String delay;
  final String mode;
  final String lastUsed;

  const Preset({
    required this.title,
    required this.vibration,
    required this.lock,
    required this.camera,
    required this.location,
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
    bool? lock,
    bool? camera,
    bool? location,
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
      lock: lock ?? this.lock,
      camera: camera ?? this.camera,
      location: location ?? this.location,
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
    'lock': lock,
    'camera': camera,
    'location': location,
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
    lock: json['lock'] as bool,
    camera: json['camera'] as bool,
    location: json['location'] as bool,
    volume: (json['volume'] as num).toDouble(),
    sound: (json['sound'] as num).toDouble(),
    distance: json['distance'] as String,
    delay: json['delay'] as String,
    mode: json['mode'] as String,
    lastUsed: json['lastUsed'] as String,
  );
}
