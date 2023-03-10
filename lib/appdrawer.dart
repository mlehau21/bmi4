import 'package:flutter/material.dart';
import 'calculator/bmi.dart';
import 'calculator/bmr.dart';
import 'calculator/tdee.dart';
import 'calculator/history.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('BMI'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const BMIScreen()));
              }),
          ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('BMR'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const BMRScreen()));
              }),
          ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('TDEE'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TDEEScreen()));
              }),
          ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Lịch sử'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryScreen()));
              })
        ],
      ));
}
