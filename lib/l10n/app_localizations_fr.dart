// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navHistory => 'Historique';

  @override
  String get navAccount => 'Compte';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get presetsTitle => 'Préréglages';

  @override
  String get settingsSectionGeneral => 'Général';

  @override
  String get settingsSectionDetection => 'Détection';

  @override
  String get settingsSectionAlarm => 'Alarme';

  @override
  String get settingsSectionSecurity => 'Sécurité';

  @override
  String get settingsSectionFunctions => 'Fonctions';

  @override
  String get settingsSectionSupport => 'Assistance';

  @override
  String get settingsSectionAbout => 'À propos';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String get settingsFloatingNotifications => 'Notifications flottantes';

  @override
  String get settingsMotionSensitivity => 'Sensibilité au mouvement';

  @override
  String get settingsDetectionDelay => 'Délai de détection';

  @override
  String get settingsStepsThreshold => 'Seuil de pas (mode Pas)';

  @override
  String get settingsMaxDistance => 'Distance maximale (mode Distant)';

  @override
  String get settingsSoundEnabled => 'Son activé';

  @override
  String get settingsVibrate => 'Vibration';

  @override
  String get settingsCustomPin => 'Code PIN personnalisé';

  @override
  String get settingsEnterPinHint => 'Entrez un code PIN à 4-6 chiffres';

  @override
  String get settingsDigitCode => 'Code numérique';

  @override
  String get settingsEnterDigitCodeHint => 'Entrez un code à 4-6 chiffres';

  @override
  String get settingsLocationService => 'Service de localisation';

  @override
  String get settingsCameraAccess => 'Accès à la caméra';

  @override
  String get settingsMicrophoneAccess => 'Accès au microphone';

  @override
  String get settingsSensorDiagnostics => 'Diagnostic des capteurs';

  @override
  String get settingsSensorDiagnosticsSubtitle =>
      'Lecture en direct de tous les capteurs utilisés par BRB';

  @override
  String get settingsStarOnGithub => 'Star sur GitHub';

  @override
  String get settingsStarOnGithubSubtitle =>
      'Aidez-nous à grandir en mettant une star au projet !';

  @override
  String get settingsReportIssue => 'Signaler un problème';

  @override
  String get settingsReportIssueSubtitle => 'Trouvé un bug ? Dites-le-nous';

  @override
  String get settingsHelpFaq => 'Aide et FAQ';

  @override
  String get settingsHelpFaqSubtitle => 'Obtenez de l\'aide pour utiliser BRB';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsBuild => 'Version de build';

  @override
  String get dialogLater => 'Plus tard';

  @override
  String get dialogStarNow => 'Mettre une star';

  @override
  String get dialogCancel => 'Annuler';

  @override
  String get dialogReport => 'Signaler';

  @override
  String get dialogViewHelp => 'Voir l\'aide';

  @override
  String get dialogReset => 'Réinitialiser';

  @override
  String get settingsGithubDialogBody =>
      'Aidez-nous à grandir en mettant une étoile au projet BRB sur GitHub ! Votre soutien compte énormément pour nous.';

  @override
  String get settingsReportDialogBody =>
      'Vous avez trouvé un bug ou une suggestion ? Nous serions ravis de vous entendre !';

  @override
  String get settingsHelpDialogBody =>
      'Besoin d\'aide pour utiliser BRB ? Consultez notre documentation et notre FAQ.';

  @override
  String get presetAddTitle => 'Ajouter un préréglage';

  @override
  String get presetEditTitle => 'Modifier le préréglage';

  @override
  String get presetTitleFieldLabel => 'Titre';

  @override
  String get fieldMode => 'Mode';

  @override
  String get fieldDelay => 'Délai';

  @override
  String get fieldGrace => 'Marge';

  @override
  String get fieldCamera => 'Caméra';

  @override
  String get fieldSound => 'Son';

  @override
  String get fieldVibration => 'Vibration';

  @override
  String get fieldLocation => 'Localisation';

  @override
  String get fieldRecordAudio => 'Enregistrer l\'audio';

  @override
  String get fieldChallenge => 'Défi';

  @override
  String get challengeNoPinWarning =>
      'Aucun code PIN défini - configurez-en un dans Paramètres > Sécurité.';

  @override
  String get challengeNoDigitCodeWarning =>
      'Aucun code numérique défini - configurez-en un dans Paramètres > Sécurité.';

  @override
  String get buttonSave => 'Enregistrer';

  @override
  String get homeCurrentConfiguration => 'Configuration actuelle';

  @override
  String get accountPersonalInfo => 'Informations personnelles';

  @override
  String get accountFullName => 'Nom complet';

  @override
  String get accountUsername => 'Nom d\'utilisateur';

  @override
  String get accountEmail => 'E-mail';

  @override
  String get accountPhoneNumber => 'Numéro de téléphone';

  @override
  String get accountBio => 'Bio';

  @override
  String get accountFirebaseKey => 'Clé Firebase';

  @override
  String get accountNotSet => 'Non défini';

  @override
  String get accountQuickActions => 'Actions rapides';

  @override
  String get accountSettingsSubtitle => 'Détection, son d\'alarme, thème';

  @override
  String get accountSecuritySubtitle =>
      'Code PIN et code numérique pour désactiver les alarmes';

  @override
  String get accountResetAppData => 'Réinitialiser les données';

  @override
  String get accountResetDialogBody =>
      'Cela efface vos préréglages, l\'historique des alarmes, les détails du profil et tous les paramètres pour revenir aux valeurs par défaut. Cette action est irréversible.';

  @override
  String get accountResetSnackbar => 'Données de l\'application réinitialisées';

  @override
  String get accountJoined => 'Inscrit';

  @override
  String get accountStatus => 'Statut';

  @override
  String get accountActive => 'Actif';

  @override
  String get historyEmptyTitle =>
      'Aucune alarme pour l\'instant.\nLes événements apparaîtront ici une fois BRB armé et déclenché.';

  @override
  String get historyClearAll => 'Tout effacer';

  @override
  String get historyClearDialogTitle => 'Effacer l\'historique';

  @override
  String get historyClearDialogBody =>
      'Cela supprime tous les événements d\'alarme enregistrés. Cette action est irréversible.';

  @override
  String get historyEventDeleted => 'Événement supprimé';

  @override
  String get historyCleared => 'Historique effacé';

  @override
  String get historyNoLocationCaptured => 'Aucune localisation capturée';

  @override
  String get historyPlayAudio => 'Lire la preuve audio';

  @override
  String get historyPlaying => 'Lecture...';

  @override
  String get alarmTitle => 'ALARME';

  @override
  String get alarmSubtitle =>
      'Mouvement détecté pendant que l\'alarme est armée.';

  @override
  String get alarmDismiss => 'DÉSACTIVER';

  @override
  String get alarmWrongPin => 'Code PIN incorrect';

  @override
  String get alarmWrongDigitCode => 'Code numérique incorrect';

  @override
  String get alarmHintPin => 'PIN';

  @override
  String get alarmHintDigitCode => 'Code numérique';

  @override
  String historyModeAlarm(String mode) {
    return 'Alarme mode $mode';
  }

  @override
  String get dialogEditPrefix => 'Modifier';

  @override
  String get dialogEnterPrefix => 'Entrez';

  @override
  String get dialogCapture => 'Capturer';

  @override
  String get profileTakePicture => 'Prendre une nouvelle photo';

  @override
  String get profileImportGallery => 'Importer depuis la galerie';
}
