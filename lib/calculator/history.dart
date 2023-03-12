import 'package:flutter/material.dart';
import '../appdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> _results = [];

  @override
  void initState() {
    _loadResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử tính toán'),
      ),
      body: ListView.builder(
        itemCount: _results.length,
        itemBuilder: (BuildContext context, int index) {
          final parts = _results[index].split('|');
          final type = parts[0];
          final result = parts[1];
          final date = DateFormat("dd/MM/yyyy").format(DateTime.now());
          return ListTile(
            title: Text('$type: $result'),
            subtitle: Text(date),
          );
        },
      ),
    );
  }

  Future<void> _loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _results = prefs.getStringList('results') ?? [];
      _results.sort((a, b) => b.split('|')[2].compareTo(a.split('|')[2]));
    });
  }
}
