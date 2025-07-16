import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/history/event_card.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.darkBgLight, title: const Text('History')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              EventCard(coordinates: '38.45651 - 8.1548', location: 'Sidi Abdellah - Algiers', dateTime: DateTime.parse('2023-10-01')),
              EventCard(coordinates: '38.45651 - 8.1548', location: 'Sidi Abdellah - Algiers', dateTime: DateTime.parse('2023-10-01')),
              EventCard(coordinates: '38.45651 - 8.1548', location: 'Sidi Abdellah - Algiers', dateTime: DateTime.parse('2023-10-01')),
              EventCard(coordinates: '38.45651 - 8.1548', location: 'Sidi Abdellah - Algiers', dateTime: DateTime.parse('2023-10-01')),
            ],
          ),
        ),
      ),
    );
  }
}
