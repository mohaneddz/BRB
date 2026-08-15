// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navHistory => 'History';

  @override
  String get navAccount => 'Account';

  @override
  String get navSettings => 'Settings';

  @override
  String get presetsTitle => 'Presets';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsSectionDetection => 'Detection';

  @override
  String get settingsSectionAlarm => 'Alarm';

  @override
  String get settingsSectionSecurity => 'Security';

  @override
  String get settingsSectionFunctions => 'Functions';

  @override
  String get settingsSectionSupport => 'Support';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsFloatingNotifications => 'Floating Notifications';

  @override
  String get settingsMotionSensitivity => 'Motion Sensitivity';

  @override
  String get settingsDetectionDelay => 'Detection Delay';

  @override
  String get settingsStepsThreshold => 'Steps Threshold (Steps mode)';

  @override
  String get settingsMaxDistance => 'Max Distance (Distant mode)';

  @override
  String get settingsSoundEnabled => 'Sound Enabled';

  @override
  String get settingsVibrate => 'Vibrate';

  @override
  String get settingsCustomPin => 'Custom PIN';

  @override
  String get settingsEnterPinHint => 'Enter 4-6 digit PIN';

  @override
  String get settingsDigitCode => 'Digit Code';

  @override
  String get settingsEnterDigitCodeHint => 'Enter 4-6 digit code';

  @override
  String get settingsLocationService => 'Location Service';

  @override
  String get settingsCameraAccess => 'Camera Access';

  @override
  String get settingsMicrophoneAccess => 'Microphone Access';

  @override
  String get settingsSensorDiagnostics => 'Sensor Diagnostics';

  @override
  String get settingsSensorDiagnosticsSubtitle =>
      'Live readout of every sensor BRB uses';

  @override
  String get settingsStarOnGithub => 'Star on GitHub';

  @override
  String get settingsStarOnGithubSubtitle =>
      'Help us grow by starring the project!';

  @override
  String get settingsReportIssue => 'Report Issue';

  @override
  String get settingsReportIssueSubtitle => 'Found a bug? Let us know';

  @override
  String get settingsHelpFaq => 'Help & FAQ';

  @override
  String get settingsHelpFaqSubtitle => 'Get help using BRB';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsBuild => 'Build';

  @override
  String get dialogLater => 'Later';

  @override
  String get dialogStarNow => 'Star Now';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get dialogReport => 'Report';

  @override
  String get dialogViewHelp => 'View Help';

  @override
  String get dialogReset => 'Reset';

  @override
  String get settingsGithubDialogBody =>
      'Help us grow by starring the BRB project on GitHub! Your support means everything to us.';

  @override
  String get settingsReportDialogBody =>
      'Found a bug or have a suggestion? We\'d love to hear from you!';

  @override
  String get settingsHelpDialogBody =>
      'Need help using BRB? Check out our documentation and frequently asked questions.';

  @override
  String get presetAddTitle => 'Add Preset';

  @override
  String get presetEditTitle => 'Edit Preset';

  @override
  String get presetTitleFieldLabel => 'Title';

  @override
  String get fieldMode => 'Mode';

  @override
  String get fieldDelay => 'Delay';

  @override
  String get fieldGrace => 'Grace';

  @override
  String get fieldCamera => 'Camera';

  @override
  String get fieldSound => 'Sound';

  @override
  String get fieldVibration => 'Vibration';

  @override
  String get fieldLocation => 'Location';

  @override
  String get fieldRecordAudio => 'Record Audio';

  @override
  String get fieldChallenge => 'Challenge';

  @override
  String get challengeNoPinWarning =>
      'No PIN set yet - set one in Settings > Security.';

  @override
  String get challengeNoDigitCodeWarning =>
      'No Digit Code set yet - set one in Settings > Security.';

  @override
  String get buttonSave => 'Save';

  @override
  String get homeCurrentConfiguration => 'Current Configuration';

  @override
  String get accountPersonalInfo => 'Personal Information';

  @override
  String get accountFullName => 'Full Name';

  @override
  String get accountUsername => 'Username';

  @override
  String get accountEmail => 'Email';

  @override
  String get accountPhoneNumber => 'Phone Number';

  @override
  String get accountBio => 'Bio';

  @override
  String get accountFirebaseKey => 'Firebase Key';

  @override
  String get accountNotSet => 'Not set';

  @override
  String get accountQuickActions => 'Quick Actions';

  @override
  String get accountSettingsSubtitle => 'Detection, alarm sound, theme';

  @override
  String get accountSecuritySubtitle =>
      'PIN and Digit Code for dismissing alarms';

  @override
  String get accountResetAppData => 'Reset App Data';

  @override
  String get accountResetDialogBody =>
      'This clears your presets, alarm history, profile details and all settings back to defaults. It cannot be undone.';

  @override
  String get accountResetSnackbar => 'App data reset';

  @override
  String get accountJoined => 'Joined';

  @override
  String get accountStatus => 'Status';

  @override
  String get accountActive => 'Active';

  @override
  String get historyEmptyTitle =>
      'No alarms yet.\nEvents show up here once BRB is armed and triggers.';

  @override
  String get historyClearAll => 'Clear All';

  @override
  String get historyClearDialogTitle => 'Clear History';

  @override
  String get historyClearDialogBody =>
      'This deletes every logged alarm event. It cannot be undone.';

  @override
  String get historyEventDeleted => 'Event deleted';

  @override
  String get historyCleared => 'History cleared';

  @override
  String get historyNoLocationCaptured => 'No location captured';

  @override
  String get historyPlayAudio => 'Play audio evidence';

  @override
  String get historyPlaying => 'Playing...';

  @override
  String get alarmTitle => 'ALARM';

  @override
  String get alarmSubtitle => 'Motion detected while armed.';

  @override
  String get alarmDismiss => 'DISMISS';

  @override
  String get alarmWrongPin => 'Wrong PIN';

  @override
  String get alarmWrongDigitCode => 'Wrong Digit Code';

  @override
  String get alarmHintPin => 'PIN';

  @override
  String get alarmHintDigitCode => 'Digit Code';

  @override
  String historyModeAlarm(String mode) {
    return '$mode mode alarm';
  }

  @override
  String get dialogEditPrefix => 'Edit';

  @override
  String get dialogEnterPrefix => 'Enter';

  @override
  String get dialogCapture => 'Capture';

  @override
  String get profileTakePicture => 'Take a new picture';

  @override
  String get profileImportGallery => 'Import from gallery';
}
