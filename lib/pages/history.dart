import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/history/event_card.dart';
import 'package:brb/models/history_event.dart';
import 'package:brb/utils/tools/history_service.dart';
import 'package:brb/l10n/app_localizations.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryService _historyService = HistoryService();
  List<HistoryEvent> _events = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _events = _historyService.load(prefs);
      _loading = false;
    });
  }

  Future<void> _deleteAt(int index) async {
    final l10n = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();
    await _historyService.removeAt(prefs, index);
    await _load();
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.historyEventDeleted)));
  }

  Future<void> _confirmClearAll() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.historyClearDialogTitle),
        content: Text(l10n.historyClearDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              l10n.dialogCancel,
              style: TextStyle(color: AppColors.secondaryText(dialogContext)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              l10n.historyClearAll,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final prefs = await SharedPreferences.getInstance();
    await _historyService.clear(prefs);
    await _load();
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.historyCleared)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navHistory),
        actions: [
          if (_events.isNotEmpty)
            IconButton(
              icon: const Icon(LucideIcons.trash2),
              tooltip: l10n.historyClearAll,
              onPressed: _confirmClearAll,
            ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            )
          : RefreshIndicator(
              onRefresh: _load,
              child: _events.isEmpty
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Center(
                            child: Text(
                              l10n.historyEmptyTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.secondaryText(context)),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: List.generate(_events.length, (i) {
                        final event = _events[i];
                        return Dismissible(
                          key: ValueKey(
                            '${event.timestamp.toIso8601String()}_$i',
                          ),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 32),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              LucideIcons.trash2,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) => _deleteAt(i),
                          child: EventCard(
                            coordinates: event.latitude != null &&
                                    event.longitude != null
                                ? '${event.latitude!.toStringAsFixed(5)} - ${event.longitude!.toStringAsFixed(5)}'
                                : l10n.historyNoLocationCaptured,
                            location: event.placeName ??
                                l10n.historyModeAlarm(event.mode),
                            dateTime: event.timestamp,
                            audioPath: event.audioPath,
                          ),
                        );
                      }),
                    ),
            ),
    );
  }
}
