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
      drawer: const AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: 20),
            // Text(
            //   'BMI Calculator',
            //   style: TextStyle(
            //     color: Colors.black87,
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(height: 20),
            // Text(
            //   'Calculate your BMI',
            //   style: TextStyle(
            //     color: Colors.grey.shade700,
            //     fontSize: 16,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 20),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Chiều cao (cm)',
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cân nặng (kg)',
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.line_weight),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double height = double.parse(_heightController.text) / 100;
                  double weight = double.parse(_weightController.text);
                  _bmiResult = weight / (height * height);
                });
              },
              child: Text('Tính BMI'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Chỉ số BMI của bạn là: ${_bmiResult.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveResult('BMI', _bmiResult.toStringAsFixed(2).toString());
              },
              child: const Text('Lưu'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade800, Colors.blue.shade400],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8),
          Text(
            'BMI Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Calculate your BMI',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeightTextField() {
    return TextField(
      controller: _heightController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Chiều cao (cm)',
        labelStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(Icons.height),
      ),
    );
  }

  Widget _buildWeightTextField() {
    return TextField(
      controller: _weightController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Cân nặng (kg)',
        labelStyle: TextStyle(fontSize: 16),
        prefixIcon: Icon(Icons.line_weight),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          double height = double.parse(_heightController.text) / 100;
          double weight = double.parse(_weightController.text);
          _bmiResult = weight / (height * height);
        });
      },
      child: Text(
        'Tính BMI',
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildResultText() {
    return Text(
      'Chỉ số BMI của bạn là: ${_bmiResult.toStringAsFixed(2)}',
      style: TextStyle(fontSize: 24),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        _saveResult('BMI', _bmiResult.toStringAsFixed(2).toString());
      },
      child: const Text('Lưu'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
