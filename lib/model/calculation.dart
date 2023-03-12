import 'package:flutter/foundation.dart';

class Calculation {
  final String type;
  final String result;
  final String date;

  Calculation({
    required this.type,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'result': result,
      'date': date,
    };
  }
}
