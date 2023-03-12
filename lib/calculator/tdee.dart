import 'package:flutter/material.dart';
import '../appdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TDEEScreen extends StatefulWidget {
  const TDEEScreen({Key? key}) : super(key: key);

  static const routeName = '/tdee';

  @override
  _TDEEScreenState createState() => _TDEEScreenState();
}

class _TDEEScreenState extends State<TDEEScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  double _tdeeResult = 0;
  bool _isMale = true;
  double _activityLevel = 1.2;
  String _selectedActivityLevel = 'Ít vận động';

  List<String> _activityLevels = [
    'Ít vận động',
    'Vận động nhẹ',
    'Vận động vừa',
    'Vận động nhiều',
    'Vận động cực nhiều',
  ];

  void _calculateTDEE() {
    final weight = double.parse(_weightController.text);
    final height = double.parse(_heightController.text);
    final age = double.parse(_ageController.text);

    double bmr;

    if (_isMale) {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }

    switch (_selectedActivityLevel) {
      case 'Ít vận động':
        _activityLevel = 1.2;
        break;
      case 'Vận động nhẹ':
        _activityLevel = 1.375;
        break;
      case 'Vận động vừa':
        _activityLevel = 1.55;
        break;
      case 'Vận động nhiều':
        _activityLevel = 1.725;
        break;
      case 'Vận động cực nhiều':
        _activityLevel = 1.9;
        break;
    }

    _tdeeResult = bmr * _activityLevel;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TDEE Calculator'),
        ),
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age (years)'),
                ),
                SizedBox(height: 10),
                Text('Gender:'),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Male'),
                        value: true,
                        groupValue: _isMale,
                        onChanged: (value) {
                          setState(() {
                            _isMale = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Female'),
                        value: false,
                        groupValue: _isMale,
                        onChanged: (value) {
                          setState(() {
                            _isMale = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Physical Activity Level:'),
                DropdownButton(
                  value: _activityLevel,
                  items: [
                    DropdownMenuItem(
                      child: Text('Sedentary'),
                      value: 1.2,
                    ),
                    DropdownMenuItem(
                      child: Text('Lightly Active'),
                      value: 1.375,
                    ),
                    DropdownMenuItem(
                      child: Text('Moderately Active'),
                      value: 1.55,
                    ),
                    DropdownMenuItem(
                      child: Text('Very Active'),
                      value: 1.725,
                    ),
                    DropdownMenuItem(
                      child: Text('Extremely Active'),
                      value: 1.9,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _activityLevel = value as double;
                    });
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _calculateTDEE,
                  child: Text('Calculate'),
                ),
                SizedBox(height: 20),
                if (_tdeeResult != null)
                  Column(
                    children: [
                      Text(
                        'Your TDEE is:',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${_tdeeResult.toStringAsFixed(2)} calories/day',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _saveResult('BMI', _tdeeResult.toString());
                        },
                        child: const Text('Lưu'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }

  void _saveResult(String type, String result) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'results';
    final value = '$type|$result|${DateTime.now()}';
    prefs.setStringList(key, [...prefs.getStringList(key) ?? [], value]);
  }
}
