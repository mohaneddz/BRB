import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
// Components:
import 'package:brb/components/ui/content.dart';
import 'package:brb/components/ui/navigation.dart';
// import 'package:brb/utils/movement_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme, // Use your custom theme here
      home: Scaffold(
        body: Content(index: _currentIndex),
        bottomNavigationBar: MyNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}
