import 'package:flutter/material.dart';
import 'package:food_app/pages/categories_meals_page.dart';
import 'package:food_app/pages/categories_page.dart';
import 'package:food_app/pages/meal_detail_page.dart';
import 'package:food_app/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    fontFamily: 'Raleway',
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        AppRoutes.home: (context) => const CategoriesPage(),
        AppRoutes.categoriesMeals: (context) => const CategoriesMealsPage(),
        AppRoutes.mealDetail: (context) => const MealDetailPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const CategoriesPage();
          },
        );
      },
    );
  }
}
