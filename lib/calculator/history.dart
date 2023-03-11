import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _calcHistory = [];

  @override
  void initState() {
    super.initState();
    _loadCalculationHistory();
  }

  Future<void> _loadCalculationHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> historyStringList =
        prefs.getStringList('calcHistory') ?? [];
    setState(() {
      _calcHistory = historyStringList
          .map((historyString) =>
              jsonDecode(historyString) as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử tính toán'),
      ),
      body: ListView.builder(
        itemCount: _calcHistory.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> calcItem = _calcHistory[index];
          String calcDate =
              DateTime.fromMillisecondsSinceEpoch(calcItem['timestamp'])
                  .toString();
          String calcResult = calcItem['result'];

          return ListTile(
            title: Text(calcResult),
            subtitle: Text(calcDate),
          );
        },
      ),
    );
  }
}
