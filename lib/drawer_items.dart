import 'package:flutter/material.dart';
import 'calculator/bmi.dart';
import 'calculator/bmr.dart';
import 'calculator/tdee.dart';
import 'calculator/history.dart';
import 'routes.dart';

class DrawerItems {
  static List<Widget> buildDrawerItems(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.calculate),
        title: Text('BMI Calculator'),
        onTap: () {
          Navigator.pushNamed(context, BMIScreen.routeName);
        },
      ),
      ListTile(
        leading: Icon(Icons.calculate),
        title: Text('BMR Calculator'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, BMRScreen.routeName);
        },
      ),
      ListTile(
        leading: Icon(Icons.calculate),
        title: Text('TDEE Calculator'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, TDEEScreen.routeName);
        },
      ),
      ListTile(
        leading: Icon(Icons.history),
        title: Text('History'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, HistoryScreen.routeName);
        },
      ),
    ];
  }
}
