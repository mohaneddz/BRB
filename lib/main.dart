import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
// Components:
import 'package:brb/components/ui/content.dart';
import 'package:brb/components/ui/navigation.dart';
import 'package:flutter/rendering.dart';
import 'package:brb/utils/movement_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Dashboard Template',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: const SensorDashboardPage(),
    );
  }
}
