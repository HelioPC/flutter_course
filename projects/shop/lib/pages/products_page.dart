import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/widgets/product_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: products.itemsCount,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (ctx, i) {
            return ProductItem(product: products.items[i]);
          },
        ),
      ),
    );
  }
}
