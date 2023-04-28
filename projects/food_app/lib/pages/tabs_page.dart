import 'package:flutter/material.dart';
import 'package:food_app/pages/categories_page.dart';
import 'package:food_app/pages/favorite_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s cook'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Categories',
                icon: Icon(Icons.category),
              ),
              Tab(
                text: 'Favorites',
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CategoriesPage(),
            FavoritePage(),
          ],
        ),
      ),
    );
  }
}
