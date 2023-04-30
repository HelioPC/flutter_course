import 'package:flutter/material.dart';
import 'package:food_app/data/dummy.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/models/settings.dart';
import 'package:food_app/pages/categories_meals_page.dart';
import 'package:food_app/pages/meal_detail_page.dart';
import 'package:food_app/pages/settings_page.dart';
import 'package:food_app/pages/tabs_page.dart';
import 'package:food_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    fontFamily: 'Raleway',
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
  );

  Settings settings = Settings();
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

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
        AppRoutes.home: (context) => TabsPage(favoriteMeals: _favoriteMeals),
        AppRoutes.categoriesMeals: (context) => CategoriesMealsPage(
              meals: _availableMeals,
            ),
        AppRoutes.mealDetail: (context) => MealDetailPage(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
        AppRoutes.settings: (context) =>
            SettingsPage(onSettingsChange: _filterMeals, settings: settings),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return TabsPage(favoriteMeals: _favoriteMeals);
          },
        );
      },
    );
  }
}
