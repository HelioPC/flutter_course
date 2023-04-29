import 'package:flutter/material.dart';
import 'package:food_app/widgets/main_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      drawer: const MainDrawer(),
      body: const Center(
        child: Text('Settings page'),
      ),
    );
  }
}
