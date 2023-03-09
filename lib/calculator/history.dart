import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Calculator'),
      ),
      body: Center(
        child: Text('History Calculator Screen'),
      ),
    );
  }
}
