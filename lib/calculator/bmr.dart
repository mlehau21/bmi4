import 'package:flutter/material.dart';

class BMRScreen extends StatefulWidget {
  @override
  _BMRScreenState createState() => _BMRScreenState();
}

class _BMRScreenState extends State<BMRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMR Calculator'),
      ),
      body: Center(
        child: Text('BMR Screen'),
      ),
    );
  }
}
