import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/calculation.dart';
import 'package:intl/intl.dart';

class SharedPreferencesUtils {
  static Future<List<Calculation>> getCalculations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String storedCalculations = prefs.getString('calculations')!;
    if (storedCalculations != null) {
      List<dynamic> decoded = jsonDecode(storedCalculations);
      List<Calculation> calculations = decoded
          .map((e) => Calculation(
                type: e['type'],
                result: e['result'],
                date: e['date'],
              ))
          .toList();
      return calculations;
    } else {
      return [];
    }
  }

  static Future<void> addCalculation(Calculation calculation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Calculation> calculations = await getCalculations();
    calculations.add(calculation);
    final String encodedCalculations =
        jsonEncode(calculations.map((e) => e.toMap()).toList());
    prefs.setString('calculations', encodedCalculations);
  }

  void _saveResult(String type, String result) async {
    final prefs = await SharedPreferences.getInstance();
    final date = DateTime.now();
    final dateString = '${date.day}/${date.month}/${date.year}';
    final results = prefs.getStringList('results') ?? [];

    results.add('$type|$result|$dateString');
    prefs.setStringList('results', results);
  }
}
