/// Bundled asset paths for the built-in alarm tone dropdown (Settings and
/// AlarmController both need this mapping - Settings to preview a tone,
/// AlarmController to actually play the selected one on trigger).
const Map<String, String> builtInToneAssets = {
  'Security Alert': 'audio/tones/security_alert.wav',
  'Siren': 'audio/tones/siren.wav',
  'Loud Beep': 'audio/tones/loud_beep.wav',
  'Emergency': 'audio/tones/emergency.wav',
  'Classic Alarm': 'audio/tones/classic_alarm.wav',
};
