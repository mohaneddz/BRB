class ConfigValues {
  final String mode;
  final double delay;
  final double grace;
  final bool camera;
  final bool location;
  final bool mic;
  final double sound;
  final bool vibration;
  final String challengeType;

  const ConfigValues({
    required this.mode,
    required this.delay,
    required this.grace,
    required this.camera,
    required this.location,
    this.mic = false,
    required this.sound,
    required this.vibration,
    required this.challengeType,
  });

  static const defaults = ConfigValues(
    mode: 'Pocket',
    delay: 1.0,
    grace: 0.5,
    camera: false,
    location: false,
    mic: false,
    sound: 0.5,
    vibration: true,
    challengeType: 'none',
  );

  ConfigValues copyWith({
    String? mode,
    double? delay,
    double? grace,
    bool? camera,
    bool? location,
    bool? mic,
    double? sound,
    bool? vibration,
    String? challengeType,
  }) {
    return ConfigValues(
      mode: mode ?? this.mode,
      delay: delay ?? this.delay,
      grace: grace ?? this.grace,
      camera: camera ?? this.camera,
      location: location ?? this.location,
      mic: mic ?? this.mic,
      sound: sound ?? this.sound,
      vibration: vibration ?? this.vibration,
      challengeType: challengeType ?? this.challengeType,
    );
  }
}
