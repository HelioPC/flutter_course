import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/products_grid.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('All'),
              ),
            ],
            onSelected: (value) {
              setState(() {
                switch (value) {
                  case FilterOptions.favorite:
                    _showFavoriteOnly = true;
                    break;
                  case FilterOptions.all:
                    _showFavoriteOnly = false;
                    break;
                  default:
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (context, value, child) {
              return Badge(
                isLabelVisible: value.itemsCount > 0,
                alignment: const AlignmentDirectional(0.3, -0.5),
                label: Text(
                  value.itemsCount.toString(),
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                child: child,
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductsGrid(
          showFavoriteOnly: _showFavoriteOnly,
        ),
      ),
    );
  }
}
