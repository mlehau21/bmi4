import 'package:flutter/material.dart';
import '../appdrawer.dart';

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
      drawer: const AppDrawer(),
    );
  }
}
