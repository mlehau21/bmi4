import 'package:flutter/material.dart';
import '../appdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMRScreen extends StatefulWidget {
  const BMRScreen({Key? key}) : super(key: key);

  static const routeName = '/bmr';

  @override
  _BMRScreenState createState() => _BMRScreenState();
}

class _BMRScreenState extends State<BMRScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int _gender = 1;
  double _bmrResult = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMR Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value as int;
                  });
                },
              ),
              Text('Nam'),
              Radio(
                value: 2,
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value as int;
                  });
                },
              ),
              Text('Nữ'),
            ],
          ),
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
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tuổi',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                double height = double.parse(_heightController.text);
                double weight = double.parse(_weightController.text);
                int age = int.parse(_ageController.text);
                double s = _gender == 1 ? 5 : -161;
                _bmrResult = 10 * weight + 6.25 * height - 5 * age + s;
              });
            },
            child: Text('Tính BMR'),
          ),
          Text(
            'Chỉ số BMR của bạn là: ${_bmrResult.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              _saveResult('BMR', _bmrResult.toString());
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
