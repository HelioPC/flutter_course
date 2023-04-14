import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';

class CategoriesMealsPage extends StatelessWidget {
  const CategoriesMealsPage({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
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
