import 'package:flutter/material.dart';
import 'package:shop/widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ProductsGrid(),
      ),
    );
  }
}
