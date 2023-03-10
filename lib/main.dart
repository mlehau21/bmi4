import 'package:flutter/material.dart';
import 'calculator/bmi.dart';
import 'calculator/bmr.dart';
import 'calculator/tdee.dart';
import 'calculator/history.dart';
import 'routes.dart';
import 'appdrawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMIScreen(),
    );
  }
}
