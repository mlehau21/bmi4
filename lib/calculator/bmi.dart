import 'package:flutter/material.dart';
import '../appdrawer.dart';
import '../utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  static const routeName = '/bmi';

  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Chiều cao (cm)',
            ),
          ),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Cân nặng (kg)',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                double height = double.parse(_heightController.text) / 100;
                double weight = double.parse(_weightController.text);
                _bmiResult = weight / (height * height);
              });
            },
            child: Text('Tính BMI'),
          ),
          Text(
            'Chỉ số BMI của bạn là: ${_bmiResult.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              _saveResult('BMI', _bmiResult.toStringAsFixed(2).toString());
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }

  void _saveResult(String type, String result) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'results';
    final value = '$type|$result|${DateTime.now()}';
    prefs.setStringList(key, [...prefs.getStringList(key) ?? [], value]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã lưu'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
