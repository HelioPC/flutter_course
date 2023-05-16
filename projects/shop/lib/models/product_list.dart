import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  void addProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (!hasId) {
      add(newProduct);
    } else {
      update(newProduct);
    }

    notifyListeners();
  }

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void update(Product product) {
    int index = _items.indexWhere(
      (p) => p.id == product.id,
    );

    if (index >= 0) {
      _items[index] = product;
    } else {}
    notifyListeners();
  }

  void delete(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.remove(product);
      notifyListeners();
    }
  }
}
