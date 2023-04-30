import 'package:flutter/material.dart';
import 'package:food_app/models/settings.dart';
import 'package:food_app/widgets/main_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.onSettingsChange,
    required this.settings,
  });

  final Settings settings;
  final Function(Settings) onSettingsChange;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChange(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Settings page',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Gluten free',
                  'Only show gluten free meals',
                  settings.isGlutenFree,
                  (value) => setState(() {
                    settings.isGlutenFree = value;
                  }),
                ),
                _createSwitch(
                  'Lactose free',
                  'Only show dairy free meals',
                  settings.isLactoseFree,
                  (value) => setState(() {
                    settings.isLactoseFree = value;
                  }),
                ),
                _createSwitch(
                  'Vegetarian',
                  'Only show vegetarian meals',
                  settings.isVegetarian,
                  (value) => setState(() {
                    settings.isVegetarian = value;
                  }),
                ),
                _createSwitch(
                  'Vegan meals',
                  'Only show vegan meals',
                  settings.isVegan,
                  (value) => setState(() {
                    settings.isVegan = value;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
