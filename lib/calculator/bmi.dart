import 'package:flutter/material.dart';

class BMIScreen extends StatelessWidget {
  const BMIScreen({Key? key}) : super(key: key);

  static const routeName = '/bmi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Center(
        child: Text('BMI Calculator Screen'),
      ),
    );
  }
}
