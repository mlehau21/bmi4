import 'package:flutter/material.dart';

class TDEEScreen extends StatefulWidget {
  @override
  _TDEEScreenState createState() => _TDEEScreenState();
}

class _TDEEScreenState extends State<TDEEScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TDEE Calculator'),
      ),
      body: Center(
        child: Text('TDEE Screen'),
      ),
    );
  }
}
