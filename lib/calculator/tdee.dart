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
  // String _selectedActivityLevel = 'Ít vận động';

  // List<String> _activityLevels = [
  //   'Ít vận động',
  //   'Vận động nhẹ',
  //   'Vận động vừa',
  //   'Vận động nhiều',
  //   'Vận động cực nhiều',
  //   // 'Sedentary',
  //   // 'Lightly Active',
  //   // 'Moderately Active',
  //   // 'Very Active',
  //   // 'Extremely Active',
  // ];

  void _calculateTDEE() {
    final weight = double.parse(_weightController.text);
    final height = double.parse(_heightController.text);
    final age = double.parse(_ageController.text);
    final level = _activityLevel;
    double bmr;

    if (_isMale) {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }

    _tdeeResult = bmr * level;

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
                SizedBox(height: 16),
                Text(
                  'Giới tính',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMale = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: _isMale == true
                                ? Colors.green
                                : Colors.grey[300],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              'Nam',
                              style: TextStyle(
                                color: _isMale == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMale = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: _isMale == false
                                ? Colors.pink
                                : Colors.grey[300],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              'Nữ',
                              style: TextStyle(
                                color: _isMale == false
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Chiều cao (cm)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Vui lòng nhập chiều cao',
                    prefixIcon: Icon(Icons.height),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Cân nặng (kg)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Vui lòng nhập cân nặng',
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Tuổi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Vui lòng nhập tuổi',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Mức vận động',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  value: _activityLevel,
                  items: [
                    DropdownMenuItem(
                      child: Text('Ít vận động'),
                      value: 1.2,
                    ),
                    DropdownMenuItem(
                      child: Text('Vận động nhẹ'),
                      value: 1.375,
                    ),
                    DropdownMenuItem(
                      child: Text('Vận động vừa'),
                      value: 1.55,
                    ),
                    DropdownMenuItem(
                      child: Text('Vận động nhiều'),
                      value: 1.725,
                    ),
                    DropdownMenuItem(
                      child: Text('Vận động cực nhiều'),
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
                  child: Text('Tính TDEE'),
                ),
                SizedBox(height: 20),
                if (_tdeeResult != null)
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Chỉ số TDEE của bạn là:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                          _saveResult('TDEE',
                              _tdeeResult.toStringAsFixed(2).toString());
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã lưu'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
