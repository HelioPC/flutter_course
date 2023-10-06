import 'package:flutter/material.dart';

class CronometerButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const CronometerButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
