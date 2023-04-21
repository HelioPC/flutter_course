import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';

class CategoriesMealsPage extends StatelessWidget {
  CategoriesMealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('Receitas por categoria #${category.id}'),
      ),
    );
  }
}
