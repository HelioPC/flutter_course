import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/widgets/meal_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? const Center(
            child: Text('Minhas refeições favoritas'),
          )
        : ListView.builder(
            itemCount: favoriteMeals.length,
            itemBuilder: (context, index) {
              return MealItem(meal: favoriteMeals[index]);
            },
          );
  }
}
