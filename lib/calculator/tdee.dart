import 'package:flutter/material.dart';

class TDEEScreen extends StatelessWidget {
  const TDEEScreen({Key? key}) : super(key: key);

  static const routeName = '/tdee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TDEE Calculator'),
      ),
      body: Center(
        child: Text('TDEE Calculator Screen'),
      ),
    );
  }
}
