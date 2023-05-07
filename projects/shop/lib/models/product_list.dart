import 'package:flutter/material.dart';
import 'package:shop/data/dummy.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
