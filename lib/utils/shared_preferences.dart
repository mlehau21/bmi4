import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/calculation.dart';

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
}
