import 'package:flutter/material.dart';
import '../appdrawer.dart';

class BMRScreen extends StatelessWidget {
  const BMRScreen({Key? key}) : super(key: key);

  static const routeName = '/bmr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMR Calculator'),
      ),
      body: Center(
        child: Text('BMR Calculator Screen'),
      ),
      drawer: const AppDrawer(),
    );
  }
}
