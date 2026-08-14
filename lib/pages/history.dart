import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/history/event_card.dart';
import 'package:brb/models/history_event.dart';
import 'package:brb/utils/tools/history_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
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
                              'No alarms yet.\nEvents show up here once BRB '
                              'is armed and triggers.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.secondaryText(context)),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: _events
                          .map(
                            (event) => EventCard(
                              coordinates: event.latitude != null &&
                                      event.longitude != null
                                  ? '${event.latitude!.toStringAsFixed(5)} - ${event.longitude!.toStringAsFixed(5)}'
                                  : 'No location captured',
                              location: event.placeName ??
                                  '${event.mode} mode alarm',
                              dateTime: event.timestamp,
                              audioPath: event.audioPath,
                            ),
                          )
                          .toList(),
                    ),
            ),
    );
  }
}
