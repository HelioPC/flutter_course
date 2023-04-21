import 'package:flutter/material.dart';
import 'package:food_app/data/dummy.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/widgets/meal_item.dart';

class CategoriesMealsPage extends StatelessWidget {
  const CategoriesMealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    final meals =
        dummyMeals.where((m) => m.categories.contains(category.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(meal: meals[index]);
        },
      ),
    );
  }
}
