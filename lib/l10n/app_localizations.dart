import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get navAccount;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @presetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get presetsTitle;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsSectionDetection.
  ///
  /// In en, this message translates to:
  /// **'Detection'**
  String get settingsSectionDetection;

  /// No description provided for @settingsSectionAlarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get settingsSectionAlarm;

  /// No description provided for @settingsSectionSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSectionSecurity;

  /// No description provided for @settingsSectionFunctions.
  ///
  /// In en, this message translates to:
  /// **'Functions'**
  String get settingsSectionFunctions;

  /// No description provided for @settingsSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSectionSupport;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsSectionAbout;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsFloatingNotifications.
  ///
  /// In en, this message translates to:
  /// **'Floating Notifications'**
  String get settingsFloatingNotifications;

  /// No description provided for @settingsMotionSensitivity.
  ///
  /// In en, this message translates to:
  /// **'Motion Sensitivity'**
  String get settingsMotionSensitivity;

  /// No description provided for @settingsDetectionDelay.
  ///
  /// In en, this message translates to:
  /// **'Detection Delay'**
  String get settingsDetectionDelay;

  /// No description provided for @settingsStepsThreshold.
  ///
  /// In en, this message translates to:
  /// **'Steps Threshold (Steps mode)'**
  String get settingsStepsThreshold;

  /// No description provided for @settingsMaxDistance.
  ///
  /// In en, this message translates to:
  /// **'Max Distance (Distant mode)'**
  String get settingsMaxDistance;

  /// No description provided for @settingsSoundEnabled.
  ///
  /// In en, this message translates to:
  /// **'Sound Enabled'**
  String get settingsSoundEnabled;

  /// No description provided for @settingsVibrate.
  ///
  /// In en, this message translates to:
  /// **'Vibrate'**
  String get settingsVibrate;

  /// No description provided for @settingsCustomPin.
  ///
  /// In en, this message translates to:
  /// **'Custom PIN'**
  String get settingsCustomPin;

  /// No description provided for @settingsEnterPinHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 4-6 digit PIN'**
  String get settingsEnterPinHint;

  /// No description provided for @settingsDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Digit Code'**
  String get settingsDigitCode;

  /// No description provided for @settingsEnterDigitCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 4-6 digit code'**
  String get settingsEnterDigitCodeHint;

  /// No description provided for @settingsLocationService.
  ///
  /// In en, this message translates to:
  /// **'Location Service'**
  String get settingsLocationService;

  /// No description provided for @settingsCameraAccess.
  ///
  /// In en, this message translates to:
  /// **'Camera Access'**
  String get settingsCameraAccess;

  /// No description provided for @settingsMicrophoneAccess.
  ///
  /// In en, this message translates to:
  /// **'Microphone Access'**
  String get settingsMicrophoneAccess;

  /// No description provided for @settingsSensorDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Sensor Diagnostics'**
  String get settingsSensorDiagnostics;

  /// No description provided for @settingsSensorDiagnosticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Live readout of every sensor BRB uses'**
  String get settingsSensorDiagnosticsSubtitle;

  /// No description provided for @settingsStarOnGithub.
  ///
  /// In en, this message translates to:
  /// **'Star on GitHub'**
  String get settingsStarOnGithub;

  /// No description provided for @settingsStarOnGithubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us grow by starring the project!'**
  String get settingsStarOnGithubSubtitle;

  /// No description provided for @settingsReportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get settingsReportIssue;

  /// No description provided for @settingsReportIssueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Found a bug? Let us know'**
  String get settingsReportIssueSubtitle;

  /// No description provided for @settingsHelpFaq.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get settingsHelpFaq;

  /// No description provided for @settingsHelpFaqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help using BRB'**
  String get settingsHelpFaqSubtitle;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsBuild.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get settingsBuild;

  /// No description provided for @dialogLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get dialogLater;

  /// No description provided for @dialogStarNow.
  ///
  /// In en, this message translates to:
  /// **'Star Now'**
  String get dialogStarNow;

  /// No description provided for @dialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogCancel;

  /// No description provided for @dialogReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get dialogReport;

  /// No description provided for @dialogViewHelp.
  ///
  /// In en, this message translates to:
  /// **'View Help'**
  String get dialogViewHelp;

  /// No description provided for @dialogReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get dialogReset;

  /// No description provided for @settingsGithubDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Help us grow by starring the BRB project on GitHub! Your support means everything to us.'**
  String get settingsGithubDialogBody;

  /// No description provided for @settingsReportDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Found a bug or have a suggestion? We\'d love to hear from you!'**
  String get settingsReportDialogBody;

  /// No description provided for @settingsHelpDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Need help using BRB? Check out our documentation and frequently asked questions.'**
  String get settingsHelpDialogBody;

  /// No description provided for @presetAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Preset'**
  String get presetAddTitle;

  /// No description provided for @presetEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Preset'**
  String get presetEditTitle;

  /// No description provided for @presetTitleFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get presetTitleFieldLabel;

  /// No description provided for @fieldMode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get fieldMode;

  /// No description provided for @fieldDelay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get fieldDelay;

  /// No description provided for @fieldGrace.
  ///
  /// In en, this message translates to:
  /// **'Grace'**
  String get fieldGrace;

  /// No description provided for @fieldCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get fieldCamera;

  /// No description provided for @fieldSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get fieldSound;

  /// No description provided for @fieldVibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get fieldVibration;

  /// No description provided for @fieldLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get fieldLocation;

  /// No description provided for @fieldRecordAudio.
  ///
  /// In en, this message translates to:
  /// **'Record Audio'**
  String get fieldRecordAudio;

  /// No description provided for @fieldChallenge.
  ///
  /// In en, this message translates to:
  /// **'Challenge'**
  String get fieldChallenge;

  /// No description provided for @challengeNoPinWarning.
  ///
  /// In en, this message translates to:
  /// **'No PIN set yet - set one in Settings > Security.'**
  String get challengeNoPinWarning;

  /// No description provided for @challengeNoDigitCodeWarning.
  ///
  /// In en, this message translates to:
  /// **'No Digit Code set yet - set one in Settings > Security.'**
  String get challengeNoDigitCodeWarning;

  /// No description provided for @buttonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// No description provided for @homeCurrentConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Current Configuration'**
  String get homeCurrentConfiguration;

  /// No description provided for @accountPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get accountPersonalInfo;

  /// No description provided for @accountFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get accountFullName;

  /// No description provided for @accountUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get accountUsername;

  /// No description provided for @accountEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountEmail;

  /// No description provided for @accountPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get accountPhoneNumber;

  /// No description provided for @accountBio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get accountBio;

  /// No description provided for @accountFirebaseKey.
  ///
  /// In en, this message translates to:
  /// **'Firebase Key'**
  String get accountFirebaseKey;

  /// No description provided for @accountNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get accountNotSet;

  /// No description provided for @accountQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get accountQuickActions;

  /// No description provided for @accountSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Detection, alarm sound, theme'**
  String get accountSettingsSubtitle;

  /// No description provided for @accountSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'PIN and Digit Code for dismissing alarms'**
  String get accountSecuritySubtitle;

  /// No description provided for @accountResetAppData.
  ///
  /// In en, this message translates to:
  /// **'Reset App Data'**
  String get accountResetAppData;

  /// No description provided for @accountResetDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This clears your presets, alarm history, profile details and all settings back to defaults. It cannot be undone.'**
  String get accountResetDialogBody;

  /// No description provided for @accountResetSnackbar.
  ///
  /// In en, this message translates to:
  /// **'App data reset'**
  String get accountResetSnackbar;

  /// No description provided for @accountJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get accountJoined;

  /// No description provided for @accountStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get accountStatus;

  /// No description provided for @accountActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get accountActive;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No alarms yet.\nEvents show up here once BRB is armed and triggers.'**
  String get historyEmptyTitle;

  /// No description provided for @historyClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get historyClearAll;

  /// No description provided for @historyClearDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get historyClearDialogTitle;

  /// No description provided for @historyClearDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This deletes every logged alarm event. It cannot be undone.'**
  String get historyClearDialogBody;

  /// No description provided for @historyEventDeleted.
  ///
  /// In en, this message translates to:
  /// **'Event deleted'**
  String get historyEventDeleted;

  /// No description provided for @historyCleared.
  ///
  /// In en, this message translates to:
  /// **'History cleared'**
  String get historyCleared;

  /// No description provided for @historyNoLocationCaptured.
  ///
  /// In en, this message translates to:
  /// **'No location captured'**
  String get historyNoLocationCaptured;

  /// No description provided for @historyPlayAudio.
  ///
  /// In en, this message translates to:
  /// **'Play audio evidence'**
  String get historyPlayAudio;

  /// No description provided for @historyPlaying.
  ///
  /// In en, this message translates to:
  /// **'Playing...'**
  String get historyPlaying;

  /// No description provided for @alarmTitle.
  ///
  /// In en, this message translates to:
  /// **'ALARM'**
  String get alarmTitle;

  /// No description provided for @alarmSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Motion detected while armed.'**
  String get alarmSubtitle;

  /// No description provided for @alarmDismiss.
  ///
  /// In en, this message translates to:
  /// **'DISMISS'**
  String get alarmDismiss;

  /// No description provided for @alarmWrongPin.
  ///
  /// In en, this message translates to:
  /// **'Wrong PIN'**
  String get alarmWrongPin;

  /// No description provided for @alarmWrongDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Wrong Digit Code'**
  String get alarmWrongDigitCode;

  /// No description provided for @alarmHintPin.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get alarmHintPin;

  /// No description provided for @alarmHintDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Digit Code'**
  String get alarmHintDigitCode;

  /// No description provided for @historyModeAlarm.
  ///
  /// In en, this message translates to:
  /// **'{mode} mode alarm'**
  String historyModeAlarm(String mode);

  /// No description provided for @dialogEditPrefix.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get dialogEditPrefix;

  /// No description provided for @dialogEnterPrefix.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get dialogEnterPrefix;

  /// No description provided for @dialogCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get dialogCapture;

  /// No description provided for @profileTakePicture.
  ///
  /// In en, this message translates to:
  /// **'Take a new picture'**
  String get profileTakePicture;

  /// No description provided for @profileImportGallery.
  ///
  /// In en, this message translates to:
  /// **'Import from gallery'**
  String get profileImportGallery;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
