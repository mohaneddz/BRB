enum ChallengeType {
  none,
  pin,
  digitCode;

  String get label => switch (this) {
    ChallengeType.none => 'None',
    ChallengeType.pin => 'PIN',
    ChallengeType.digitCode => 'Digit Code',
  };

  static ChallengeType fromName(String? name) {
    return ChallengeType.values.firstWhere(
      (t) => t.name == name,
      orElse: () => ChallengeType.none,
    );
  }

  static const labels = ['None', 'PIN', 'Digit Code'];

  static ChallengeType fromLabel(String label) {
    return switch (label) {
      'PIN' => ChallengeType.pin,
      'Digit Code' => ChallengeType.digitCode,
      _ => ChallengeType.none,
    };
  }
}
