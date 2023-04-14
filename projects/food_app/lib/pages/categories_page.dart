import 'package:flutter/material.dart';
import 'package:food_app/data/dummy.dart';
import 'package:food_app/widgets/category_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s cook'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children:
            dummyCategories.map((cat) => CategoryItem(category: cat)).toList(),
      ),
    );
  }
}
