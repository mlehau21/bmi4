import 'package:flutter/material.dart';
import 'calculator/bmi.dart';
import 'calculator/bmr.dart';
import 'calculator/tdee.dart';
import 'calculator/history.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Tính BMI'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(BMIScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Tính BMR'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(BMRScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Tính TDEE'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TDEEScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Xem lịch sử'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(HistoryScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
