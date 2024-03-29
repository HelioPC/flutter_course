import 'package:flutter/material.dart';
import 'package:food_app/models/meal.dart';
import 'package:food_app/pages/categories_page.dart';
import 'package:food_app/pages/favorite_page.dart';
import 'package:food_app/widgets/main_drawer.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  late List<Map<String, Object>> _pages;

  _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'title': 'Categories',
        'page': const CategoriesPage(),
      },
      {
        'title': 'Favorites',
        'page': FavoritePage(
          favoriteMeals: widget.favoriteMeals,
        ),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
