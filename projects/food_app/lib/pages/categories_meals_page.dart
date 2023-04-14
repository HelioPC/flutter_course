import 'package:flutter/material.dart';

class CategoriesMealsPage extends StatelessWidget {
  const CategoriesMealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
      ),
      body: const Center(
        child: Text('Receitas por categoria'),
      ),
    );
  }
}
