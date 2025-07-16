import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:brb/components/home/main_button.dart';
import 'package:brb/components/home/configuration_card.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bool enabled = true;
  String text = 'ON!';

  void onClick() {
    if (enabled) {
      setState(() {
        text = text == 'ON!' ? 'OFF!' : 'ON!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBgLight,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            children: [
              LooperButton(text: text, onClick: onClick),
              // const SizedBox(height: 24), // Add spacing
              const ConfigurationCard(),
            ],
          ),
        ),
      ),
    );
  }
}
