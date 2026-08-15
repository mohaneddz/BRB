import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/models/challenge_type.dart';
import 'package:brb/utils/tools/challenge_service.dart';
import 'package:brb/l10n/app_localizations.dart';

/// Full-screen alarm shown when [DetectionService] fires. Blocks the back
/// gesture so a thief can't just navigate away, and requires the triggering
/// preset's challenge (PIN, Digit Code, or none - set in Settings > Security,
/// picked per-preset) to dismiss.
class AlarmScreen extends StatefulWidget {
  final String challengeType;

  const AlarmScreen({super.key, required this.challengeType});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final ChallengeService _challengeService = ChallengeService();
  final TextEditingController _codeController = TextEditingController();
  late final ChallengeType _challenge;
  bool _challengeRequired = false;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _challenge = ChallengeType.fromName(widget.challengeType);
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    bool required;
    switch (_challenge) {
      case ChallengeType.pin:
        required = _challengeService.isPinEnabled(prefs) &&
            (_challengeService.getPin(prefs)?.isNotEmpty ?? false);
        break;
      case ChallengeType.digitCode:
        required = _challengeService.isDigitCodeEnabled(prefs) &&
            (_challengeService.getDigitCode(prefs)?.isNotEmpty ?? false);
        break;
      case ChallengeType.none:
        required = false;
        break;
    }
    if (!mounted) return;
    setState(() {
      _challengeRequired = required;
      _loading = false;
    });
  }

  String get _hintText {
    final l10n = AppLocalizations.of(context)!;
    return _challenge == ChallengeType.digitCode ? l10n.alarmHintDigitCode : l10n.alarmHintPin;
  }

  String get _wrongMessage {
    final l10n = AppLocalizations.of(context)!;
    return _challenge == ChallengeType.digitCode ? l10n.alarmWrongDigitCode : l10n.alarmWrongPin;
  }

  Future<void> _dismiss() async {
    if (_challengeRequired) {
      final prefs = await SharedPreferences.getInstance();
      final candidate = _codeController.text.trim();
      final correct = _challenge == ChallengeType.digitCode
          ? _challengeService.verifyDigitCode(prefs, candidate)
          : _challengeService.verifyPin(prefs, candidate);
      if (!correct) {
        setState(() => _error = _wrongMessage);
        return;
      }
    }
    await Vibration.cancel();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Center(
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                          size: 96,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.alarmTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.alarmSubtitle,
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        if (_challengeRequired) ...[
                          TextField(
                            controller: _codeController,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              letterSpacing: 8,
                            ),
                            decoration: InputDecoration(
                              hintText: _hintText,
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.black26,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                              errorText: _error,
                              errorStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _dismiss,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              l10n.alarmDismiss,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
