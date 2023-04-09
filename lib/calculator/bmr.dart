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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Text(
                'BMR là lượng calo cần thiết để duy trì các hoạt động cơ bản của cơ thể trong trạng thái nghỉ ngơi, không tính đến hoạt động vận động.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Giới tính',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _gender == 1 ? Colors.green : Colors.grey[300],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Nam',
                            style: TextStyle(
                              color: _gender == 1 ? Colors.white : Colors.black,
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
                          _gender = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _gender == 2 ? Colors.pink : Colors.grey[300],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            'Nữ',
                            style: TextStyle(
                              color: _gender == 2 ? Colors.white : Colors.black,
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
                  hintText: 'Vui lòng nhập chiều cao theo centimet',
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
                  hintText: 'Vui lòng nhập cân nặng kilogram',
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
              SizedBox(height: 16),
              Text(
                'Chỉ số BMR của bạn là:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${_bmrResult.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _saveResult('BMR', _bmrResult.toStringAsFixed(2).toString());
                },
                child: const Text('Lưu kết quả'),
              ),
            ],
          ),
        ),
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
        content: Text('Đã lưu kết quả'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
